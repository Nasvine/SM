import 'package:carousel_slider/carousel_slider.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/models/order_model.dart';
import 'package:smart_service/src/screens/orders/order_step.dart';
import 'package:smart_service/src/screens/verify_account/verify_account.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/texts/button_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_custom/text_custom.dart';
import 'package:smart_service/src/screens/orders/form_order.dart';
import 'package:intl/intl.dart';
import 'package:smart_service/src/models/transactions/transaction_model.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.userFullName,
    required this.userEmail,
  });

  final String userFullName;
  final String userEmail;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  List imageList = [
    {"id": 1, "image_path": 'assets/images/Slide1.jpg'},
    {"id": 2, "image_path": 'assets/images/Slide2.jpg'},
    {"id": 3, "image_path": 'assets/images/Slide3.jpg'},
    {"id": 4, "image_path": 'assets/images/Slide4.jpg'},
  ];

  final List<ServiceItem> services = [
    ServiceItem(
      'Marché',
      'assets/images/super-market.png',
      ColorApp.tSecondaryNewColor,
    ),
    ServiceItem(
      'Pharmacie',
      'assets/images/pharmacie.png',
      ColorApp.tsombreBleuColor,
    ),
    ServiceItem(
      'Repas',
      'assets/images/repas.png',
      ColorApp.tSecondaryNewColor,
    ),
    ServiceItem(
      'Course',
      'assets/images/delivery.png',
      ColorApp.tsombreBleuColor,
    ),
    ServiceItem(
      'Restaurant',
      'assets/images/restaurant.png',
      ColorApp.tsombreBleuColor,
    ),
    ServiceItem(
      'Courrier',
      'assets/images/administration_image.png',
      ColorApp.tSecondaryNewColor,
    ),
    ServiceItem(
      'Couturier',
      'assets/images/coordonier.png',
      ColorApp.tsombreBleuColor,
    ),
    ServiceItem(
      'Banque',
      'assets/images/banque.png',
      ColorApp.tSecondaryNewColor,
    ),
    ServiceItem('Gaz', 'assets/images/gaz.png', ColorApp.tsombreBleuColor),
    ServiceItem(
      'Cordonnier',
      'assets/images/cor.png',
      ColorApp.tSecondaryNewColor,
    ),
    ServiceItem(
      'Ecolier(e)s',
      'assets/images/ecolier.png',
      ColorApp.tsombreBleuColor,
    ),
    ServiceItem(
      'Autres',
      'assets/images/super-market.png',
      ColorApp.tSecondaryNewColor,
    ),
  ];

  Stream<int> getOrderPendingTotal(String userId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where(
          'userRef',
          isEqualTo: FirebaseFirestore.instance.collection('users').doc(userId),
        )
        .where('paymentStatus', isEqualTo: "Pending")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Stream<int> getOrderFinishTotal(String userId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where(
          'ownerRef',
          isEqualTo: FirebaseFirestore.instance.collection('users').doc(userId),
        )
        .where('status', isEqualTo: "finish")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Stream<List<OrderModel>> getOrdersFinishLists(String userId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .orderBy("createdAt", descending: true)
        .where(
          'userRef',
          isEqualTo: FirebaseFirestore.instance.collection('users').doc(userId),
        )
        .where('paymentStatus', isEqualTo: "Completed")
        .limit(5)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList(),
        );
  }

  Stream<List<TransactionModel>> getTransactions(String userId) {
    return FirebaseFirestore.instance
        .collection('transactions')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TransactionModel.fromSnapshot(doc))
              .toList(),
        );
  }

  // NOUVELLE MÉTHODE : Livraison en cours
  Stream<OrderModel?> getCurrentDelivery(String userId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .orderBy("createdAt", descending: true)
        .where(
          'userRef',
          isEqualTo: FirebaseFirestore.instance.collection('users').doc(userId),
        )
        .where(
          'status',
          whereIn: [
            'neworder',
            'assigned',
            'accepted',
            'pending',
            'delivered',
            'paymentstep',
          ],
        )
        .limit(1)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) return null;
          return OrderModel.fromSnapshot(snapshot.docs.first);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header avec carousel
          SliverToBoxAdapter(child: _buildHeaderSection(context)),

          // Services section
          SliverToBoxAdapter(child: _buildServicesSection(context)),

          // NOUVELLE SECTION : Livraison en cours
          SliverToBoxAdapter(child: _buildCurrentDeliverySection(context)),

          // Livraisons récentes
          SliverToBoxAdapter(child: _buildRecentDeliveriesSection(context)),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorApp.tPrimaryColor.withOpacity(0.1), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bonjour message
            _buildWelcomeSection(isDark),

            const SizedBox(height: 20),

            // Carousel
            _buildCarouselSection(),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prêt pour une nouvelle commande ?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
          ),
        ),
        /* const SizedBox(height: 8),
        Text(
          'Prêt pour une nouvelle commande ?',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ), */
      ],
    );
  }

  Widget _buildCarouselSection() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CarouselSlider(
              items: imageList
                  .map(
                    (item) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                        item['image_path'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                aspectRatio: 2,
                viewportFraction: 1,
                autoPlayInterval: const Duration(seconds: 4),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Indicateurs
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: currentIndex == entry.key ? 20 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: currentIndex == entry.key
                    ? ColorApp.tPrimaryColor
                    : Colors.grey.withOpacity(0.5),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Services disponibles',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ColorApp.tPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${services.length} services',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorApp.tPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Grid des services
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: services.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final service = services[index];
              return _buildServiceItem(service, isDark);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(ServiceItem service, bool isDark) {
    return GestureDetector(
      onTap: () {
        Get.to(() => FormOrderScreen());
      },
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: service.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: service.color.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Center(
              child: Image.asset(
                service.iconPath,
                width: 32,
                height: 32,
                // SUPPRIMER la propriété color pour afficher l'image originale
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            service.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // NOUVELLE SECTION : Livraison en cours
  Widget _buildCurrentDeliverySection(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Livraison en cours',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
                ),
              ),
              StreamBuilder(
                stream: getCurrentDelivery(
                  FirebaseAuth.instance.currentUser!.uid,
                ),
                builder: (context, snapshot) {
                  final hasCurrentDelivery =
                      snapshot.hasData && snapshot.data != null;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: hasCurrentDelivery
                          ? Colors.orange.withOpacity(0.1)
                          : Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      hasCurrentDelivery ? 'En cours' : 'Aucune',
                      style: TextStyle(
                        fontSize: 12,
                        color: hasCurrentDelivery
                            ? Colors.orange
                            : Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          StreamBuilder(
            stream: getCurrentDelivery(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return _buildLoadingCurrentDelivery();
              }

              if (!asyncSnapshot.hasData || asyncSnapshot.data == null) {
                return _buildNoCurrentDeliveryState();
              }

              final currentOrder = asyncSnapshot.data!;
              return _buildCurrentDeliveryItem(currentOrder, isDark);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCurrentDeliveryItem(OrderModel order, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorApp.tPrimaryColor.withOpacity(0.1),
            ColorApp.tsecondaryColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorApp.tPrimaryColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: ColorApp.tPrimaryColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header avec statut et progression
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Commande #${order.orderId}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getStatusText(order.status),
                      style: TextStyle(
                        fontSize: 12,
                        color: _getStatusColor(order.status),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getStatusIcon(order.status),
                  color: _getStatusColor(order.status),
                  size: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Barre de progression
          _buildProgressBar(order.status),

          const SizedBox(height: 16),

          // Détails de la livraison
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.place, size: 14, color: Colors.green),
                      const SizedBox(width: 6),
                      Text(
                        'Retrait',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 150,
                    child: Text(
                      order.withdrawalPoint.address,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.red),
                      const SizedBox(width: 6),
                      Text(
                        'Destination',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 130,
                    child: Text(
                      order.destinationLocation.address,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Footer avec prix et action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${order.amount.toInt()} F',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorApp.tPrimaryColor,
                    ),
                  ),
                  Text(
                    'Total à payer',
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
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
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: ColorApp.tPrimaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Suivre',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(String status) {
    final progress = _getProgressValue(status);

    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          color: ColorApp.tPrimaryColor,
          borderRadius: BorderRadius.circular(10),
          minHeight: 6,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildProgressStep('Assignée', 1, progress),
            _buildProgressStep('Acceptée', 2, progress),
            _buildProgressStep('En cours', 3, progress),
            _buildProgressStep('Livrée', 4, progress),
            _buildProgressStep('Terminée', 5, progress),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressStep(String label, int step, double progress) {
    final isCompleted = progress >= (step / 5);
    final isCurrent = progress > ((step - 1) / 5) && progress < (step / 5);

    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? ColorApp.tPrimaryColor
                : (isCurrent ? ColorApp.tPrimaryColor : Colors.grey[300]),
            border: Border.all(
              color: isCurrent ? ColorApp.tPrimaryColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: isCompleted ? ColorApp.tPrimaryColor : Colors.grey[500],
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  double _getProgressValue(String status) {
    switch (status.toLowerCase()) {
      case 'assigned':
        return 0.2;
      case 'accepted':
        return 0.4;
      case 'pending':
        return 0.6;
      case 'delivered':
        return 0.8;
      case 'paymentstep':
        return 0.9;
      case 'finish':
        return 1.0;
      default:
        return 0.0;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'assigned':
        return 'Course assignée à un livreur';
      case 'accepted':
        return 'Course acceptée par le livreur';
      case 'pending':
        return 'En cours de livraison';
      case 'delivered':
        return 'Colis livré';
      case 'paymentstep':
        return 'En attente de paiement';
      case 'finish':
        return 'Course terminée';
      default:
        return status;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'assigned':
        return Icons.person_search;
      case 'accepted':
        return Icons.check_circle;
      case 'pending':
        return Icons.delivery_dining;
      case 'delivered':
        return Icons.local_shipping;
      case 'paymentstep':
        return Icons.payment;
      case 'finish':
        return Icons.flag;
      default:
        return Icons.info;
    }
  }

  Widget _buildNoCurrentDeliveryState() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Lottie.asset(
            height: 120,
            width: 120,
            'assets/images/no_data.json',
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucune livraison en cours',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vos commandes en cours apparaîtront ici',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Get.to(() => FormOrderScreen());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ColorApp.tPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Créez une nouvelle commande',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorApp.tPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCurrentDelivery() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(width: 120, height: 16, color: Colors.grey[300]),
              Spacer(),
              Container(width: 60, height: 20, color: Colors.grey[300]),
            ],
          ),
          const SizedBox(height: 16),
          Container(width: double.infinity, height: 6, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 80, height: 12, color: Colors.grey[300]),
                  const SizedBox(height: 8),
                  Container(width: 120, height: 10, color: Colors.grey[300]),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(width: 80, height: 12, color: Colors.grey[300]),
                  const SizedBox(height: 8),
                  Container(width: 120, height: 10, color: Colors.grey[300]),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentDeliveriesSection(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Livraisons récentes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
                ),
              ),
              StreamBuilder(
                stream: getOrdersFinishLists(
                  FirebaseAuth.instance.currentUser!.uid,
                ),
                builder: (context, snapshot) {
                  final count = snapshot.hasData ? snapshot.data!.length : 0;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorApp.tPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$count commandes',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorApp.tPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          StreamBuilder(
            stream: getOrdersFinishLists(
              FirebaseAuth.instance.currentUser!.uid,
            ),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return _buildLoadingOrders();
              }

              if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
                return _buildEmptyOrdersState();
              }

              final orders = asyncSnapshot.data!;

              return ListView.separated(
                itemCount: orders.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return _buildOrderItem(order, isDark);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(OrderModel order, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header avec date et statut
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat(
                      'dd MMM yyyy - HH:mm',
                    ).format(order.createdAt.toDate()),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  order.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(order.status),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Détails de la commande
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Commande #${order.orderId}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Distance: ${order.distance.toStringAsFixed(2)} Km',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${order.amount.toInt()} F',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorApp.tPrimaryColor,
                    ),
                  ),
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'delivered':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildEmptyOrdersState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Lottie.asset(
            height: 150,
            width: 150,
            'assets/images/no_data.json',
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucune livraison récente',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vos commandes apparaîtront ici',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingOrders() {
    return Column(
      children: List.generate(3, (index) => _buildShimmerOrderItem()),
    );
  }

  Widget _buildShimmerOrderItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 120, height: 12, color: Colors.grey[300]),
              Container(width: 60, height: 20, color: Colors.grey[300]),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 80, height: 14, color: Colors.grey[300]),
                  const SizedBox(height: 8),
                  Container(width: 100, height: 12, color: Colors.grey[300]),
                ],
              ),
              Container(width: 50, height: 18, color: Colors.grey[300]),
            ],
          ),
        ],
      ),
    );
  }
}

class ServiceItem {
  final String name;
  final String iconPath;
  final Color color;

  ServiceItem(this.name, this.iconPath, this.color);
}
