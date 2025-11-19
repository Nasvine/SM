import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/models/auth/notification_model.dart';
import 'package:smart_service/src/repository/authentification_repository.dart';
import 'package:smart_service/src/screens/chat/chat_list_screen.dart';
import 'package:smart_service/src/screens/home_page/home.dart';
import 'package:smart_service/src/screens/home_page/profile.dart';
import 'package:smart_service/src/screens/notification.dart';
import 'package:smart_service/src/screens/orders/orders.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/widget_theme/circle_icon_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:iconsax/iconsax.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final controller = Get.put(TabsScreenController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Stream<int> getNotificationTotal(String userId) {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where(
          'receiverRef',
          isEqualTo: FirebaseFirestore.instance.collection('users').doc(userId),
        )
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  @override
  Widget build(BuildContext context) {
    controller._selectedIndex.value = widget.initialIndex;
    final isDark = THelperFunctions.isDarkMode(context);
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: isDark ? Colors.grey[900] : Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              "Quitter l'application",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            content: Text(
              "Voulez-vous vraiment quitter SmartService ?",
              style: TextStyle(
                color: isDark ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  "Annuler",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  "Quitter",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: isDark ? ColorApp.tDarkBgColor : Colors.grey[50],
        appBar: _buildAppBar(context, isDark, size),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(isDark),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isDark, Size size) {
    return AppBar(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      elevation: 0,
      leading: _buildLeadingSection(context, isDark),
      title: _buildTitleSection(isDark),
      actions: [_buildNotificationAction(isDark)],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  Widget _buildLeadingSection(BuildContext context, bool isDark) {
    return Obx(() {
      if (controller._selectedIndex.value == 0) {
        return Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: controller.profilePicture.value.isEmpty
                  ? Image.asset(
                      "assets/images/profile.jpg",
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      controller.profilePicture.value,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/profile.jpg",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
            ),
          ),
        );
      } else {
        return IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : Colors.black,
            size: 20,
          ),
        );
      }
    });
  }

  Widget _buildTitleSection(bool isDark) {
    return Obx(() {
      final index = controller._selectedIndex.value;
      
      switch (index) {
        case 0:
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Salut, ${controller.userConnectName.value} 👋",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 14,
                    color: ColorApp.tPrimaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${controller.userAdress.value}" ?? "Cotonou, Bénin",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          );
        case 1:
          return Text(
            'Mes Commandes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          );
        case 2:
          return Text(
            'Messages',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          );
        case 3:
          return Text(
            'Mon Profil',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          );
        default:
          return Text(
            'SmartService',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          );
      }
    });
  }

  Widget _buildNotificationAction(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: StreamBuilder(
        stream: getNotificationTotal(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          final count = snapshot.data ?? 0;
          
          return badges.Badge(
            position: badges.BadgePosition.topEnd(top: -8, end: -8),
            badgeContent: Text(
              count > 99 ? '99+' : count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            showBadge: count > 0,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Iconsax.notification,
                  size: 20,
                  color: isDark ? Colors.white : Colors.grey[700],
                ),
                onPressed: () async {
                  // Marquer les notifications comme lues
                  final notifications = await FirebaseFirestore.instance
                      .collection('notifications')
                      .where(
                        'receiverRef',
                        isEqualTo: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid),
                      )
                      .where('isRead', isEqualTo: false)
                      .get();

                  for (final doc in notifications.docs) {
                    await FirebaseFirestore.instance
                        .collection('notifications')
                        .doc(doc.id)
                        .update({'isRead': true});
                  }
                  
                  Get.to(() => NotificationScreen());
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (controller.user.isEmpty) {
        return _buildLoadingState();
      }

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: controller.screens[controller._selectedIndex.value],
      );
    });
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: ColorApp.tPrimaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const CircularProgressIndicator(
              color: ColorApp.tPrimaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Chargement...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(bool isDark) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          top: false, // Important pour éviter les débordements
          child: SizedBox(
            height: 70, // Hauteur fixe
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    icon: Iconsax.home,
                    activeIcon: Iconsax.home_15,
                    label: 'Accueil',
                    index: 0,
                    isDark: isDark,
                  ),
                  _buildNavItem(
                    icon: Iconsax.shopping_cart,
                    activeIcon: Iconsax.shopping_cart5,
                    label: 'Commandes',
                    index: 1,
                    isDark: isDark,
                  ),
                  _buildNavItem(
                    icon: Iconsax.message,
                    activeIcon: Iconsax.message5,
                    label: 'Messages',
                    index: 2,
                    isDark: isDark,
                  ),
                  _buildNavItem(
                    icon: Iconsax.profile_circle,
                    activeIcon: Iconsax.profile_circle5,
                    label: 'Profil',
                    index: 3,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required bool isDark,
  }) {
    final isSelected = controller._selectedIndex.value == index;
    
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller._selectedIndex.value = index,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6), // Réduit le padding
            constraints: const BoxConstraints(
              minHeight: 50, // Hauteur minimale
              maxHeight: 60, // Hauteur maximale
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Important pour éviter le débordement
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isSelected ? ColorApp.tPrimaryColor.withOpacity(0.1) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isSelected ? activeIcon : icon,
                    size: 20, // Taille réduite de l'icône
                    color: isSelected ? ColorApp.tPrimaryColor : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2), // Espacement réduit
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9, // Taille de police réduite
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? ColorApp.tPrimaryColor : Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabsScreenController extends GetxController {
  static TabsScreenController get to => Get.find();

  final _selectedIndex = 0.obs;
  final userConnectName = ''.obs;
  final profilePicture = ''.obs;
  final userAdress = ''.obs;
  final user = <String, dynamic>{}.obs;
  final auth = FirebaseAuth.instance.currentUser!;
  RxBool accountVerified = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getUserInfo();
  }

  void _getUserInfo() async {
    try {
      final data = await AuthentificationRepository.instance.getUserInfo(auth.uid);
      if (data.isNotEmpty) {
        user.value = data;
        userConnectName.value = data['fullName'];
        userAdress.value = data['userAdress'];
        
        // Récupérer le prénom
        final parts = userConnectName.value.trim().split(" ");
        userConnectName.value = parts.length >= 2 ? parts[1] : parts.first;
        
        profilePicture.value = user['profilePicture'] ?? '';
      }
    } catch (e) {
      print('Erreur lors du chargement des infos utilisateur: $e');
    }
  }

  List<Widget> get screens => [
        HomeScreen(
          userFullName: user['fullName'] ?? 'Utilisateur',
          userEmail: user['email'] ?? '',
        ),
        const OrdersScreen(),
        const ChatListScreen(),
        ProfileScreen(
          userFullName: user['fullName'] ?? 'Utilisateur',
          userEmail: user['email'] ?? '',
        ),
      ];
}