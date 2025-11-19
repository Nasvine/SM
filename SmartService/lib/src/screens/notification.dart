import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/constants/sizes.dart';
import 'package:smart_service/src/models/auth/notification_model.dart';
import 'package:smart_service/src/models/transactions/transaction_model.dart';
import 'package:smart_service/src/screens/tabs.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:text_custom/text_custom.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:badges/badges.dart' as badges;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Stream<List<NotificationModel>> getNotifications(String userId) {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where(
          'receiverRef',
          isEqualTo: FirebaseFirestore.instance.collection("users").doc(userId),
        )
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => NotificationModel.fromSnapshot(doc))
              .toList(),
        );
  }

  Future<void> _markAsRead(String notificationId) async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': true});
  }

  Future<void> _markAllAsRead(List<NotificationModel> notifications) async {
    final batch = FirebaseFirestore.instance.batch();
    
    for (final notification in notifications) {
      if (!notification.isRead) {
        final docRef = FirebaseFirestore.instance
            .collection('notifications')
            .doc(notification.uid);
        batch.update(docRef, {'isRead': true});
      }
    }
    
    await batch.commit();
  }

  Future<void> _deleteNotification(String notificationId) async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(notificationId)
        .delete();
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case "Location":
        return Colors.blue;
      case "Chat":
        return Colors.green;
      case "Platform":
        return Colors.orange;
      case "Payment":
        return Colors.purple;
      default:
        return ColorApp.tPrimaryColor;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case "Location":
        return Iconsax.location;
      case "Chat":
        return Iconsax.message;
      case "Platform":
        return Iconsax.info_circle;
      case "Payment":
        return Iconsax.wallet;
      default:
        return Iconsax.notification;
    }
  }

  String _formatTime(Timestamp timestamp) {
    final time = timestamp.toDate();
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'À l\'instant';
    } else if (difference.inMinutes < 60) {
      return 'Il y a ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Il y a ${difference.inHours} h';
    } else if (difference.inDays == 1) {
      return 'Hier';
    } else if (difference.inDays < 7) {
      return 'Il y a ${difference.inDays} j';
    } else {
      return DateFormat('dd/MM/yy').format(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    
    return Scaffold(
      backgroundColor: isDark ? ColorApp.tdarkColor : Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.offAll(() => TabsScreen(initialIndex: 0)),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
            size: 20,
          ),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
          ),
        ),
        actions: [
          StreamBuilder<List<NotificationModel>>(
            stream: getNotifications(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              final hasUnread = snapshot.hasData && 
                  snapshot.data!.any((notification) => !notification.isRead);
              
              return IconButton(
                onPressed: snapshot.hasData ? () => _markAllAsRead(snapshot.data!) : null,
                icon: badges.Badge(
                  showBadge: hasUnread,
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.red,
                  ),
                  badgeContent: const Text(''),
                  child: Icon(
                    Iconsax.tick_circle,
                    color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
                  ),
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header avec statistiques
          _buildHeaderSection(isDark),
          
          // Liste des notifications
          Expanded(
            child: _buildNotificationsList(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(bool isDark) {
    return StreamBuilder<List<NotificationModel>>(
      stream: getNotifications(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        final totalCount = snapshot.hasData ? snapshot.data!.length : 0;
        final unreadCount = snapshot.hasData ? 
            snapshot.data!.where((n) => !n.isRead).length : 0;
        
        return Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorApp.tPrimaryColor.withOpacity(0.1),
                ColorApp.tSecondaryColor.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Total',
                totalCount.toString(),
                Iconsax.notification,
                Colors.blue,
                isDark,
              ),
              _buildStatItem(
                'Non lues',
                unreadCount.toString(),
                Iconsax.notification_bing,
                Colors.orange,
                isDark,
              ),
              _buildStatItem(
                'Lues',
                (totalCount - unreadCount).toString(),
                Iconsax.tick_circle,
                Colors.green,
                isDark,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color, bool isDark) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationsList(bool isDark) {
    return StreamBuilder<List<NotificationModel>>(
      stream: getNotifications(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildEmptyState(isDark);
        }

        final notifications = snapshot.data!;

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: notifications.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return _buildNotificationItem(notification, isDark);
          },
        );
      },
    );
  }

  Widget _buildNotificationItem(NotificationModel notification, bool isDark) {
    final color = _getNotificationColor(notification.type);
    final icon = _getNotificationIcon(notification.type);
    
    return Dismissible(
      key: Key(notification.uid!),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Iconsax.trash,
          color: Colors.red,
          size: 24,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Supprimer la notification"),
            content: const Text("Voulez-vous vraiment supprimer cette notification ?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Annuler"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  "Supprimer",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) => _deleteNotification(notification.uid!),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _markAsRead(notification.uid!),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: notification.isRead 
                    ? Colors.transparent 
                    : color.withOpacity(0.3),
                width: notification.isRead ? 0 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon avec badge non lu
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 24,
                      ),
                    ),
                    if (!notification.isRead)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark ? Colors.grey[800]! : Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(width: 16),
                
                // Contenu de la notification
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            _formatTime(notification.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.message,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _getTypeLabel(notification.type),
                          style: TextStyle(
                            fontSize: 10,
                            color: color,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "Location":
        return "Livraison";
      case "Chat":
        return "Message";
      case "Platform":
        return "Plateforme";
      case "Payment":
        return "Paiement";
      default:
        return type;
    }
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 16,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 200,
                      height: 14,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 60,
                      height: 20,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(bool isDark) {
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
          Text(
            'Aucune notification',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vous serez notifié dès qu\'il y aura du nouveau',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}