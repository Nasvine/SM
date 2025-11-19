import 'package:lottie/lottie.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/models/order_model.dart';
import 'package:smart_service/src/screens/orders/order_step.dart';
import 'package:smart_service/src/screens/tabs.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/loaders/loaders.dart';
import 'package:smart_service/src/utils/texts/button_custom.dart';
import 'package:smart_service/src/utils/texts/text_custom.dart';
import 'package:smart_service/src/utils/widget_theme/custom_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final tabs = OrderStatus.values.map((item) => item.name).toList();
  late List<OrderModel> orders = [];
  int selectedStars = 0;
  final TextEditingController commentController = TextEditingController();
  bool isValidated = false;

  // Fonction de traduction des statuts
  String _translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'neworder': return 'Nouvelle commande';
      case 'assigned': return 'Assignée';
      case 'accepted': return 'Acceptée';
      case 'pending': return 'En cours';
      case 'delivered': return 'Livrée';
      case 'paymentstep': return 'Paiement';
      case 'finish': return 'Terminée';
      case 'cancelled': return 'Annulée';
      case 'refused': return 'Refusée';
      case 'completed': return 'Terminée';
      default: return status;
    }
  }

  // Fonction pour obtenir les infos du statut (texte + couleur)
  Map<String, dynamic> _getStatusInfo(String status) {
    final statusLower = status.toLowerCase();
    
    switch (statusLower) {
      case 'neworder':
        return {'text': 'Nouvelle', 'color': Colors.blue};
      case 'assigned':
        return {'text': 'Assignée', 'color': Colors.orange};
      case 'accepted':
        return {'text': 'Acceptée', 'color': Colors.green};
      case 'pending':
        return {'text': 'En cours', 'color': Colors.purple};
      case 'delivered':
        return {'text': 'Livrée', 'color': Colors.teal};
      case 'paymentstep':
        return {'text': 'Paiement', 'color': Colors.indigo};
      case 'finish':
      case 'completed':
        return {'text': 'Terminée', 'color': Colors.green};
      case 'cancelled':
        return {'text': 'Annulée', 'color': Colors.red};
      case 'refused':
        return {'text': 'Refusée', 'color': Colors.red};
      default:
        return {'text': status, 'color': Colors.grey};
    }
  }

  Stream<List<OrderModel>> _getOrderList() {
    final firebase = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance.currentUser!;
    return firebase
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .where('userRef', isEqualTo: firebase.collection('users').doc(auth.uid))
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((order) => OrderModel.fromSnapshot(order))
              .toList(),
        );
  }

  void showAvisModal(BuildContext context, String orderId) async {
    TextEditingController commentController = TextEditingController();
    int selectedStars = 0;
    bool isValidated = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Donnez votre avis",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  // ⭐ Étoiles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          setModalState(() {
                            selectedStars = index + 1;
                          });
                        },
                        icon: Icon(
                          index < selectedStars
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 30,
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 20),

                  // 💬 Commentaire
                  TextField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Commentaire (obligatoire)",
                      border: OutlineInputBorder(),
                      hintText: "Partagez votre expérience...",
                    ),
                  ),

                  SizedBox(height: 20),

                  // 📤 Bouton d'envoi
                  isValidated
                      ? CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (selectedStars == 0) {
                                TLoaders.errorSnackBar(
                                  title: "Note requise",
                                  message: "Veuillez donner une note en étoiles",
                                );
                                return;
                              }
                              if (commentController.text.isEmpty) {
                                TLoaders.errorSnackBar(
                                  title: "Commentaire requis",
                                  message: "Veuillez donner un commentaire sur la livraison",
                                );
                                return;
                              }
                              try {
                                setModalState(() {
                                  isValidated = true;
                                });

                                await FirebaseFirestore.instance
                                    .collection('orders')
                                    .doc(orderId)
                                    .update({
                                      "clientRating": selectedStars,
                                      "clientReviews": commentController.text.trim(),
                                      "status": "completed",
                                    });

                                setModalState(() {
                                  isValidated = false;
                                });

                                TLoaders.successSnackBar(
                                  title: "Succès",
                                  message: "Votre avis a été envoyé avec succès",
                                );
                                Navigator.pop(context);
                              } catch (e) {
                                setModalState(() {
                                  isValidated = false;
                                });
                                TLoaders.errorSnackBar(
                                  title: "Erreur",
                                  message: "Une erreur est survenue: $e"
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorApp.tsecondaryColor,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Envoyer ma note",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange.shade100,
                  ),
                  child: const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: ColorApp.tsecondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    labelColor: ColorApp.tWhiteColor,
                    unselectedLabelColor: ColorApp.tBlackColor,
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    tabs: [
                      Tab(text: "Mes courses"),
                      Tab(text: "Historiques"),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        body: StreamBuilder<List<OrderModel>>(
          stream: _getOrderList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      "Chargement des commandes...",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Erreur de chargement",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Veuillez réessayer",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      height: 200,
                      width: 200,
                      'assets/images/no_data.json',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    TextCustom(
                      TheText: "Aucune course trouvée",
                      TheTextSize: 16,
                      TheTextFontWeight: FontWeight.bold,
                      TheTextColor: Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    TextCustom(
                      TheText: "Vos commandes apparaîtront ici",
                      TheTextSize: 14,
                      TheTextColor: Colors.grey,
                    ),
                  ],
                ),
              );
            }

            final allOrders = snapshot.data!;

            // Séparation des commandes
            final mesCourses = allOrders
                .where((order) => 
                  order.status.toLowerCase() != "completed" &&
                  order.status.toLowerCase() != "finish" &&
                  order.status.toLowerCase() != "cancelled" &&
                  order.status.toLowerCase() != "refused")
                .toList();

            final historiques = allOrders
                .where((order) => 
                  order.status.toLowerCase() == "completed" ||
                  order.status.toLowerCase() == "finish" ||
                  order.status.toLowerCase() == "cancelled" ||
                  order.status.toLowerCase() == "refused")
                .toList();

            return TabBarView(
              children: [
                // Onglet "Mes courses"
                _buildOrderList(mesCourses, "Aucune course en cours"),

                // Onglet "Historiques"
                _buildOrderList(historiques, "Aucun historique de commandes"),
              ],
            );
          },
        ),
      ),
    );
  }

  // Widget réutilisable pour afficher une liste de commandes
  Widget _buildOrderList(List<OrderModel> orders, String emptyMessage) {
    if (orders.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Container(
          height: 200,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorApp.tsombreBleuColor.withOpacity(0.1),
            border: Border.all(color: ColorApp.tsombreBleuColor.withOpacity(0.3)),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  height: 120,
                  width: 120,
                  'assets/images/no_data.json',
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                TextCustom(
                  TheText: emptyMessage,
                  TheTextSize: 14,
                  TheTextColor: Colors.grey,
                  TheTextFontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(5),
      separatorBuilder: (_, __) => const SizedBox(height: 5),
      itemCount: orders.length,
      itemBuilder: (_, index) {
        final order = orders[index];
        final statusInfo = _getStatusInfo(order.status);

        return _buildOrderCard(order, statusInfo);
      },
    );
  }

  // Widget pour construire une carte de commande
  Widget _buildOrderCard(OrderModel order, Map<String, dynamic> statusInfo) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          print('Commande ID: ${order.orderId}');
          Get.to(
            () => OrderStep(
              status: order.status,
              orderId: order.uid!,
              amount: order.amount,
              carId: '',
              userCreatedId: order.userRef!.id,
              managerRef: order.managerRef,
              deliverRef: order.deliverRef,
              totalPrice: order.totalPrice,
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image de la commande
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Screenshot.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16),
              
              // Contenu de la commande
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ligne 1: ID de commande et Statut
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextCustom(
                            TheText: 'ID: #${order.orderId}',
                            TheTextSize: 14,
                            TheTextFontWeight: FontWeight.bold,
                            TheTextColor: ColorApp.tsecondaryColor,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: statusInfo['color'].withOpacity(0.1),
                            border: Border.all(
                              color: statusInfo['color'] as Color,
                              width: 1,
                            ),
                          ),
                          child: TextCustom(
                            TheText: statusInfo['text'],
                            TheTextSize: 10,
                            TheTextFontWeight: FontWeight.bold,
                            TheTextColor: statusInfo['color'] as Color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    
                    // Ligne 2: Date
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 6),
                        TextCustom(
                          TheText: DateFormat('dd/MM/yyyy').format(order.createdAt.toDate()),
                          TheTextSize: 12,
                          TheTextColor: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    
                    // Ligne 3: Heure
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 6),
                        TextCustom(
                          TheText: DateFormat('HH:mm').format(order.createdAt.toDate()),
                          TheTextSize: 12,
                          TheTextColor: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    
                    // Ligne 4: Prix
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(
                          TheText: 'Montant:',
                          TheTextSize: 12,
                          TheTextFontWeight: FontWeight.bold,
                        ),
                        TextCustom(
                          TheText: "${order.amount.toStringAsFixed(0)} FCFA",
                          TheTextSize: 14,
                          TheTextFontWeight: FontWeight.bold,
                          TheTextColor: ColorApp.tsecondaryColor,
                        ),
                      ],
                    ),
                    
                    // Bouton de notation (uniquement pour les commandes terminées)
                    if (order.status == "finish" || order.status == "completed")
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Container(
                          width: double.infinity,
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () => showAvisModal(context, order.uid!),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorApp.tPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: TextCustom(
                              TheText: 'Noter la course',
                              TheTextSize: 12,
                              TheTextColor: ColorApp.tWhiteColor,
                              TheTextFontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}