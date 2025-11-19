import 'package:smart_service/notification_services.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/controllers/OrdersController.dart';
import 'package:smart_service/src/models/auth/notification_model.dart';
import 'package:smart_service/src/models/auth/user_model.dart';
import 'package:smart_service/src/models/order_model.dart';
import 'package:smart_service/src/models/transactions/transaction_model.dart';
import 'package:smart_service/src/models/wallet/wallet_model.dart';
import 'package:smart_service/src/screens/orders/TrackDeliveryPage.dart';
import 'package:smart_service/src/repository/authentification_repository.dart';
import 'package:smart_service/src/screens/orders/orders.dart';
import 'package:smart_service/src/screens/tabs.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/texts/button_custom.dart';
import 'package:smart_service/src/utils/texts/button_custom_outlined.dart';
import 'package:smart_service/src/utils/texts/text_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkiapay_flutter_sdk/kkiapay_flutter_sdk.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:confetti/confetti.dart';

final ordersController = Get.put(Orderscontroller());

class OrderStep extends StatefulWidget {
  const OrderStep({
    super.key,
    required this.status,
    required this.orderId,
    required this.amount,
    required this.carId,
    required this.userCreatedId,
    required this.managerRef,
    required this.deliverRef,
    required this.totalPrice,
  });

  final String status;
  final String carId;
  final String orderId;
  final String userCreatedId;
  final DocumentReference? managerRef;
  final DocumentReference? deliverRef;
  final double amount;
  final double totalPrice;

  @override
  State<OrderStep> createState() => _OrderStepState();
}

class _OrderStepState extends State<OrderStep> {
  final firebase = FirebaseFirestore.instance;
  int currentStep = 0;
  var user = {};
  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String fcmDeliver = "";
  String fcmManager = "";
  OrderModel orderData = OrderModel.empty();
  late ConfettiController _confettiController;

  // Couleurs personnalisées pour le design
  final Color _primaryColor = ColorApp.tPrimaryColor;
  final Color _secondaryColor = ColorApp.tsecondaryColor;
  final Color _successColor = Colors.green;
  final Color _warningColor = Colors.orange;
  final Color _errorColor = Colors.red;
  final Color _disabledColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _getUserInfo();
    _fetchOrderDetails();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _getUserInfo() async {
    final auth = FirebaseAuth.instance.currentUser!;
    final data = await AuthentificationRepository.instance.getUserInfo(auth.uid);
    if (data.isNotEmpty) {
      setState(() {
        user = data;
        userName = user['fullName'];
        userEmail = user['email'];
      });
    }
  }

  void _fetchOrderDetails() async {
    final data = await firebase.collection('orders').doc(widget.orderId).get();
    if (data.exists) {
      final order = OrderModel.fromSnapshot(data);
      setState(() {
        orderData = order;
      });
    }
  }

  Future<String> getFCM_Deliver(String userId) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = UserModel.fromSnapshot(doc);
      setState(() {
        fcmDeliver = data.fcmToken!;
      });
      return data.fcmToken!;
    }
    return '';
  }

  Future<String> getFCM_Manager(String userId) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = UserModel.fromSnapshot(doc);
      setState(() {
        fcmManager = data.fcmToken!;
      });
      return data.fcmToken!;
    }
    return '';
  }

  void callback(response, context) async {
    try {
      final status = response['name'] ?? response['status'];
      
      switch (status) {
        case PAYMENT_CANCELLED:
          Navigator.pop(context);
          _showCustomSnackBar('Paiement annulé', _warningColor, Icons.cancel);
          break;

        case PAYMENT_SUCCESS:
          Navigator.pop(context);
          final String reference = _extractTransactionReference(response);
          await _updateOrderStatusAfterPayment('finish', reference);
          _confettiController.play();
          _showCustomSnackBar('Paiement réussi!', _successColor, Icons.check_circle);
          break;

        case PENDING_PAYMENT:
          _showCustomSnackBar('Paiement en attente', _warningColor, Icons.access_time);
          break;

        default:
          print('Événement non géré: $status');
          break;
      }
    } catch (e) {
      _showCustomSnackBar('Erreur lors du traitement du paiement', _errorColor, Icons.error);
    }
  }

  void _showCustomSnackBar(String message, Color color, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Expanded(child: Text(message, style: TextStyle(color: Colors.white))),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  String _extractTransactionReference(Map<String, dynamic> response) {
    if (response['data'] != null && response['data']['transactionId'] != null) {
      return response['data']['transactionId'];
    }
    if (response['reference'] != null) {
      return response['reference'];
    }
    if (response['transactionId'] != null) {
      return response['transactionId'];
    }
    return 'REF_${DateTime.now().millisecondsSinceEpoch}';
  }

  KKiaPay buildKkiaPay() {
    return KKiaPay(
      amount: widget.totalPrice.toInt(),
      countries: ["BJ", "CI", "SN", "TG"],
      phone: "22961000000",
      name: userName,
      email: userEmail,
      reason: 'Paiement de la Course #${widget.orderId}',
      data: 'Fake data',
      sandbox: true,
      apikey: "c6026b10652411efbf02478c5adba4b8",
      callback: callback,
      theme: defaultTheme,
      partnerId: 'AxXxXXxId',
      paymentMethods: ["momo", "card"],
    );
  }

  int _getStepFromStatus(String status) {
    switch (status.toLowerCase()) {
      case 'neworder': return 0;
      case 'assigned': return 1;
      case 'accepted': return 2;
      case 'pending': return 3;
      case 'delivered': return 4;
      case 'paymentstep': return 5;
      case 'finish': return 6;
      case 'cancelled': return 7;
      case 'refused': return 8;
      default: return 0;
    }
  }

  // Fonction pour obtenir les informations du statut (icône et couleur)
  Map<String, dynamic> _getStepInfo(int step) {
    switch (step) {
      case 0:
        return {
          'icon': Icons.shopping_cart_outlined,
          'color': _primaryColor,
          'title': 'Nouvelle commande',
          'subtitle': 'Votre commande a été enregistrée'
        };
      case 1:
        return {
          'icon': Icons.assignment_outlined,
          'color': _warningColor,
          'title': 'Assignation',
          'subtitle': 'Recherche d\'un livreur'
        };
      case 2:
        return {
          'icon': Icons.thumb_up_outlined,
          'color': Colors.blue,
          'title': 'Acceptation',
          'subtitle': 'Livreur assigné'
        };
      case 3:
        return {
          'icon': Icons.delivery_dining_outlined,
          'color': Colors.purple,
          'title': 'En livraison',
          'subtitle': 'Votre colis est en route'
        };
      case 4:
        return {
          'icon': Icons.delivery_dining,
          'color': Colors.teal,
          'title': 'Livré',
          'subtitle': 'Colis arrivé à destination'
        };
      case 5:
        return {
          'icon': Icons.payment_outlined,
          'color': Colors.indigo,
          'title': 'Paiement',
          'subtitle': 'Finalisez votre paiement'
        };
      case 6:
        return {
          'icon': Icons.celebration_outlined,
          'color': _successColor,
          'title': 'Terminé',
          'subtitle': 'Commande finalisée'
        };
      default:
        return {
          'icon': Icons.circle_outlined,
          'color': Colors.grey,
          'title': 'Étape $step',
          'subtitle': ''
        };
    }
  }

  Widget _buildStepIndicator(int step, bool isActive, bool isCompleted) {
    final stepInfo = _getStepInfo(step);
    
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isCompleted ? stepInfo['color'] : (isActive ? stepInfo['color'] : Colors.grey.shade300),
        shape: BoxShape.circle,
        boxShadow: isActive ? [
          BoxShadow(
            color: (stepInfo['color'] as Color).withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
          )
        ] : null,
      ),
      child: Icon(
        stepInfo['icon'],
        color: isCompleted || isActive ? Colors.white : Colors.grey,
        size: 20,
      ),
    );
  }

  Widget _buildStepContent(int step, bool isActive, int currentStep) {
    final stepInfo = _getStepInfo(step);
    final isStepCompleted = step < currentStep;
    final isStepFuture = step > currentStep;
    
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isActive ? (stepInfo['color'] as Color).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: isActive ? Border.all(color: stepInfo['color'] as Color, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(stepInfo['icon'], color: stepInfo['color'] as Color, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stepInfo['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: stepInfo['color'] as Color,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      stepInfo['subtitle'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              // Badge d'état
              if (isStepCompleted)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _successColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Terminé',
                    style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              else if (isActive)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: stepInfo['color'] as Color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'En cours',
                    style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              else if (isStepFuture)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _disabledColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'À venir',
                    style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),
          _buildStepSpecificContent(step, isActive, currentStep),
        ],
      ),
    );
  }

  Widget _buildStepSpecificContent(int step, bool isActive, int currentStep) {
    final isStepCompleted = step < currentStep;
    final isStepFuture = step > currentStep;
    
    switch (step) {
      case 0:
        return Column(
          children: [
            Lottie.asset(
              'assets/images/order_placed.json',
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Votre commande a été enregistrée avec succès et est en cours de traitement...',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
          ],
        );
      
      case 3:
        return Column(
          children: [
            Lottie.asset(
              'assets/images/delivery.json',
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Votre commande est en cours de livraison par le livreur.',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    text: 'Voir sur la carte',
                    icon: Icons.map_outlined,
                    color: isActive ? _primaryColor : _disabledColor,
                    onPressed: isActive ? () {
                      Get.to(
                        () => TrackDeliveryPage(
                          orderId: orderData.uid!,
                          googleApiKey: "AIzaSyCv7nzABmowHcgisZuOVJL8HvENMMQ-uxU",
                        ),
                      );
                    } : null,
                    isDisabled: !isActive,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    text: 'Confirmer réception',
                    icon: Icons.check_circle_outline,
                    color: isActive ? _successColor : _disabledColor,
                    onPressed: isActive ? _confirmReception : null,
                    isDisabled: !isActive,
                  ),
                ),
              ],
            ),
            if (isStepFuture) ...[
              SizedBox(height: 12),
              Text(
                'Ces actions seront disponibles lorsque la livraison sera en cours',
                style: TextStyle(fontSize: 12, color: _warningColor, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        );
      
      case 5:
        return Column(
          children: [
            Lottie.asset(
              'assets/images/payment.json',
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              "Pour payer la course, vous pouvez le faire par Mobile Money ou en espèces.",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _buildActionButton(
              text: 'Payer ${orderData.totalPrice.toInt()} FCFA',
              icon: Icons.payment,
              color: isActive ? _secondaryColor : _disabledColor,
              onPressed: isActive ? _showPaymentConfirmation : null,
              isDisabled: !isActive,
            ),
            if (isStepFuture) ...[
              SizedBox(height: 12),
              Text(
                'Le paiement sera disponible après la réception du colis',
                style: TextStyle(fontSize: 12, color: _warningColor, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange, size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Par espèces, remettez l'argent au livreur et exigez qu'il confirme la réception.",
                      style: TextStyle(fontSize: 12, color: Colors.orange.shade800),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      
      case 6:
        return Column(
          children: [
            Lottie.asset(
              'assets/images/success.json',
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Félicitations ! Votre commande a été traitée avec succès.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _successColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Merci pour votre confiance.',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _buildActionButton(
              text: 'Retour à l\'accueil',
              icon: Icons.home,
              color: _primaryColor,
              onPressed: () => Get.offAll(() => TabsScreen(initialIndex: 1)),
              isDisabled: false,
            ),
          ],
        );
      
      default:
        return Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                _getStepInfo(step)['subtitle'],
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                textAlign: TextAlign.center,
              ),
              if (isStepFuture) ...[
                SizedBox(height: 8),
                Text(
                  'Cette étape sera bientôt disponible',
                  style: TextStyle(fontSize: 12, color: _disabledColor, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        );
    }
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
    required bool isDisabled,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? _disabledColor : color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: isDisabled ? 0 : 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12, 
                fontWeight: FontWeight.bold,
                color: isDisabled ? Colors.grey.shade400 : Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (isDisabled) ...[
            SizedBox(width: 4),
            Icon(Icons.lock_outline, size: 14, color: Colors.grey.shade400),
          ],
        ],
      ),
    );
  }

  void _confirmReception() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => _buildConfirmationDialog(
        title: "Confirmer la réception",
        content: "Voulez-vous vraiment confirmer la réception du colis ?",
        confirmText: "Oui, confirmer",
        confirmColor: _successColor,
      ),
    );

    if (confirm == true) {
      try {
        await _processReceptionConfirmation();
      } catch (e) {
        _showCustomSnackBar('Erreur lors de la confirmation: $e', _errorColor, Icons.error);
      }
    }
  }

  void _showPaymentConfirmation() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => _buildConfirmationDialog(
        title: "Paiement Mobile Money",
        content: "Voulez-vous effectuer le paiement par Mobile Money ?",
        confirmText: "Payer maintenant",
        confirmColor: _secondaryColor,
      ),
    );

    if (confirm == true) {
      try {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => buildKkiaPay()),
        );
      } catch (e) {
        _showCustomSnackBar('Erreur: $e', _errorColor, Icons.error);
      }
    }
  }

  Widget _buildConfirmationDialog({
    required String title,
    required String content,
    required String confirmText,
    required Color confirmColor,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.help_outline, size: 48, color: _primaryColor),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Annuler'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: confirmColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(confirmText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _processReceptionConfirmation() async {
    final firebase = FirebaseFirestore.instance;

    final notificationManager = NotificationModel(
      senderRef: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid),
      receiverRef: widget.managerRef,
      title: 'Réception de colis 🎉',
      message: "Le client vient de récupérer son colis.",
      type: "Location",
      isRead: false,
      createdAt: Timestamp.now(),
    );

    final notificationDeliver = NotificationModel(
      senderRef: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid),
      receiverRef: widget.deliverRef,
      title: 'Colis livré avec succès 🎉',
      message: "Le client a confirmé la réception du colis.",
      type: "Location",
      isRead: false,
      createdAt: Timestamp.now(),
    );

    await firebase.collection('orders').doc(widget.orderId).update({'status': "paymentstep"});

    await getFCM_Deliver(widget.deliverRef!.id);
    await getFCM_Manager(widget.managerRef!.id);

    await FirebaseFirestore.instance.collection('notifications').add(notificationManager.toJson());
    await FirebaseFirestore.instance.collection('notifications').add(notificationDeliver.toJson());

    NotificationServices().sendPushNotification(
      deviceToken: fcmDeliver,
      title: "Colis livré avec succès 🎉",
      body: "Le client a confirmé la réception du colis.",
    );

    NotificationServices().sendPushNotification(
      deviceToken: fcmManager,
      title: "Réception confirmée 🎉",
      body: "Le client vient de récupérer son colis.",
    );

    _showCustomSnackBar('Réception confirmée avec succès!', _successColor, Icons.check_circle);
  }

  Future<void> _updateOrderStatusAfterPayment(String newStatus, String reference) async {
    try {
      final firebase = FirebaseFirestore.instance;

      await firebase.collection('orders').doc(widget.orderId).update({
        'status': "finish",
        'paymentStatus': "Completed",
      });

      // Gestion du portefeuille
      final walletData = await firebase
          .collection('wallets')
          .where('userId', isEqualTo: widget.deliverRef)
          .limit(1)
          .get();

      final transaction = TransactionModel(
        userId: widget.deliverRef!.id,
        userCreatedId: FirebaseAuth.instance.currentUser!.uid,
        amount: widget.amount.toDouble(),
        type: "payment",
        status: "completed",
        createdAt: Timestamp.now(),
        reference: reference,
      );

      if (walletData.docs.isNotEmpty) {
        final existingWalletDoc = walletData.docs.first;
        final data = WalletModel.fromSnapshot(existingWalletDoc);

        final wallet = WalletModel(
          userId: data.userId,
          amount: data.amount + widget.amount.toDouble(),
          createdAt: Timestamp.now(),
        );

        await firebase.collection('wallets').doc(data.uuid!.id).update(wallet.toMap());
      } else {
        final wallet = WalletModel(
          userId: widget.deliverRef!.id,
          amount: widget.amount.toDouble(),
          createdAt: Timestamp.now(),
        );
        await firebase.collection('wallets').add(wallet.toMap());
      }

      await firebase.collection('transactions').add(transaction.toJson());

      // Notifications
      final notificationManager = NotificationModel(
        senderRef: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid),
        receiverRef: widget.managerRef,
        title: 'Paiement reçu 💰',
        message: "Le client vient de payer la course.",
        type: "Location",
        isRead: false,
        createdAt: Timestamp.now(),
      );

      final notificationDeliver = NotificationModel(
        senderRef: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid),
        receiverRef: widget.deliverRef,
        title: 'Paiement reçu 💰',
        message: "Votre paiement a été crédité.",
        type: "Location",
        isRead: false,
        createdAt: Timestamp.now(),
      );

      await getFCM_Deliver(widget.deliverRef!.id);
      await getFCM_Manager(widget.managerRef!.id);

      await FirebaseFirestore.instance.collection('notifications').add(notificationManager.toJson());
      await FirebaseFirestore.instance.collection('notifications').add(notificationDeliver.toJson());

      NotificationServices().sendPushNotification(
        deviceToken: fcmDeliver,
        title: "Paiement reçu 💰",
        body: "Votre compte a été crédité de ${widget.amount} FCFA",
      );

      NotificationServices().sendPushNotification(
        deviceToken: fcmManager,
        title: "Paiement confirmé 💰",
        body: "Le client a payé la course #${widget.orderId}",
      );

      await firebase.collection('users').doc(widget.deliverRef!.id).update({
        'isAvailable': true,
      });

      Future.delayed(Duration(seconds: 2), () {
        Get.offAll(() => TabsScreen(initialIndex: 1));
      });

    } catch (e) {
      _showCustomSnackBar('Erreur lors de la mise à jour: $e', _errorColor, Icons.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.offAll(() => TabsScreen(initialIndex: 1)),
          icon: Icon(
            LineAwesomeIcons.angle_left_solid,
            color: THelperFunctions.isDarkMode(context) ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
          ),
        ),
        centerTitle: true,
        title: TextCustom(
          TheText: "Suivi de commande",
          TheTextSize: 16,
          TheTextFontWeight: FontWeight.bold,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('orders').doc(widget.orderId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: _primaryColor),
                      SizedBox(height: 16),
                      Text(
                        'Chargement du suivi...',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                );
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return _buildErrorState("Commande introuvable");
              }

              final status = snapshot.data!['status'];
              final currentStep = _getStepFromStatus(status);

              if (status == "refused") {
                return _buildErrorState(
                  "Commande refusée",
                  "Votre commande a été refusée par l'administrateur.",
                  Icons.block,
                  _errorColor,
                );
              }

              if (status == "cancelled") {
                return _buildErrorState(
                  "Commande annulée",
                  "Votre commande a été annulée.",
                  Icons.cancel,
                  _warningColor,
                );
              }

              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // En-tête
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.receipt_long, color: _primaryColor, size: 24),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Commande #${widget.orderId}',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${widget.amount.toInt()} FCFA',
                                        style: TextStyle(fontSize: 14, color: _secondaryColor, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Divider(),
                            SizedBox(height: 8),
                            Text(
                              'Suivez l\'avancement de votre commande en temps réel',
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Étapes
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        final isActive = index == currentStep;
                        final isCompleted = index < currentStep;
                        
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    _buildStepIndicator(index, isActive, isCompleted),
                                    if (index < 6)
                                      Container(
                                        width: 2,
                                        height: 40,
                                        color: isCompleted ? _getStepInfo(index)['color'] : Colors.grey.shade300,
                                      ),
                                  ],
                                ),
                                SizedBox(width: 16),
                                Expanded(child: _buildStepContent(index, isActive, currentStep)),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),

          // Confetti pour la célébration
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [Colors.green, Colors.blue, Colors.orange, Colors.pink],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String title, [String? message, IconData? icon, Color? color]) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              size: 64,
              color: color ?? _errorColor,
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color ?? _errorColor),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              SizedBox(height: 12),
              Text(
                message,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: 30),
            _buildActionButton(
              text: 'Retour à l\'accueil',
              icon: Icons.home,
              color: _primaryColor,
              onPressed: () => Get.offAll(() => TabsScreen(initialIndex: 1)),
              isDisabled: false,
            ),
          ],
        ),
      ),
    );
  }
}