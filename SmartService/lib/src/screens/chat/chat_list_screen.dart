

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/constants/sizes.dart';
import 'package:smart_service/src/constants/texts.dart';
import 'package:smart_service/src/repository/chat_service.dart';
import 'package:smart_service/src/screens/chat/chat_screen.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/texts/text_custom.dart';
import 'package:smart_service/src/utils/texts/text_form_field_simple_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:badges/badges.dart' as badges;


class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final _chatService = ChatService();
  final _authUser = FirebaseAuth.instance.currentUser!;
  final _searchController = TextEditingController();

  String _searchQuery = '';
  final Color _primaryColor = ColorApp.tPrimaryColor;
  final Color _secondaryColor = ColorApp.tsecondaryColor;
  final Color _successColor = Colors.green;
  final Color _warningColor = Colors.orange;

  // Méthode sécurisée pour récupérer les données des documents
  dynamic _getSafeData(Map<String, dynamic> data, String field, {dynamic defaultValue}) {
    try {
      return data[field] ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  // Méthode sécurisée pour récupérer la liste des users
  List<String> _getSafeUsersList(Map<String, dynamic> data) {
    try {
      final users = data['users'];
      if (users is List) {
        // Conversion sécurisée de List<dynamic> vers List<String>
        return users.map((item) => item.toString()).toList();
      }
      return <String>[];
    } catch (e) {
      return <String>[];
    }
  }

  // Méthode sécurisée pour trouver l'autre utilisateur
  String _getOtherUserId(List<String> users) {
    try {
      if (users.isEmpty) return '';
      return users.firstWhere(
        (uid) => uid != _authUser.uid,
        orElse: () => '',
      );
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
     /*  appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            LineAwesomeIcons.angle_left_solid,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _refreshChats,
            icon: Icon(
              Icons.refresh_rounded,
              color: _primaryColor,
            ),
          ),
        ],
      ), */
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Search Field - Version améliorée
            _buildSearchField(isDark),
            
            const SizedBox(height: 20),

            /// En-tête avec compteur
            _buildHeaderSection(),

            const SizedBox(height: 16),

            /// Chat List - Version corrigée
            Expanded(
              child: _buildChatList(isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
        decoration: InputDecoration(
          hintText: 'Rechercher une conversation...',
          hintStyle: TextStyle(
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: _primaryColor,
            size: 22,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                  icon: Icon(
                    Icons.clear_rounded,
                    color: Colors.grey.shade500,
                    size: 20,
                  ),
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        style: TextStyle(
          fontSize: 16,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getChatRooms(),
      builder: (ctx, snapshot) {
        final count = snapshot.hasData ? snapshot.data!.docs.length : 0;
        
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Conversations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _primaryColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.chat_rounded, size: 14, color: _primaryColor),
                  SizedBox(width: 6),
                  Text(
                    '$count conversations',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildChatList(bool isDark) {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getChatRooms(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        if (snapshot.hasError) {
          return _buildErrorState();
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState();
        }

        final chatDocs = snapshot.data!.docs;

        return ListView.separated(
          itemCount: chatDocs.length,
          separatorBuilder: (_, __) => SizedBox(height: 8),
          itemBuilder: (context, index) {
            final chatRoom = chatDocs[index];
            return _buildChatItem(chatRoom, isDark);
          },
        );
      },
    );
  }

  Widget _buildChatItem(QueryDocumentSnapshot chatRoom, bool isDark) {
    final chatData = chatRoom.data() as Map<String, dynamic>;
    
    // Récupération sécurisée des données
    final users = _getSafeUsersList(chatData);
    final otherUserId = _getOtherUserId(users);

    if (otherUserId.isEmpty) {
      return const SizedBox();
    }

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(otherUserId)
          .get(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return _buildChatItemShimmer();
        }

        if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
          return const SizedBox();
        }

        final userData = userSnapshot.data!.data() as Map<String, dynamic>;
        
        // Récupération sécurisée des données utilisateur
        final fullName = _getSafeData(userData, 'fullName', defaultValue: 'Utilisateur') as String;
        final email = _getSafeData(userData, 'email', defaultValue: '') as String;
        final profile = _getSafeData(userData, 'profilePicture') as String?;
        final isOnline = _getSafeData(userData, 'isOnline', defaultValue: false) as bool;
        
        // Récupération sécurisée des données du chat
        final lastMessage = _getSafeData(chatData, 'lastMessage', defaultValue: 'Démarrer la conversation') as String;
        final timestamp = _getSafeData(chatData, 'createdAt', defaultValue: Timestamp.now()) as Timestamp;
        final unreadCount = _getSafeData(chatData, 'unreadCount', defaultValue: 0) as int;

        // Filtrage via recherche
        final query = _searchQuery;
        if (query.isNotEmpty &&
            !(fullName.toLowerCase().contains(query) ||
                email.toLowerCase().contains(query))) {
          return const SizedBox();
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDark ? Colors.grey.shade800 : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      receiverID: otherUserId,
                      receiverEmail: email,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Avatar avec badge en ligne
                    Stack(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isOnline ? _successColor : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: profile == null || profile.isEmpty
                                ? Image.asset(
                                    "assets/images/profile.jpg",
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    profile,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/images/profile.jpg",
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                          ),
                        ),
                        if (isOnline)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: _successColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDark ? Colors.grey.shade800 : Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    SizedBox(width: 16),

                    // Contenu du chat
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  fullName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (unreadCount > 0)
                                badges.Badge(
                                  badgeContent: Text(
                                    unreadCount > 99 ? '99+' : '$unreadCount',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  badgeStyle: badges.BadgeStyle(
                                    badgeColor: _primaryColor,
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            lastMessage,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 12,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(width: 4),
                              Text(
                                _formatTime(timestamp),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 12),

                    // Indicateur de statut
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getStatusColor(timestamp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatItemShimmer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade100,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar shimmer
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
            ),
            SizedBox(width: 16),
            // Contenu shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(Timestamp timestamp) {
    final messageTime = timestamp.toDate();
    final now = DateTime.now();
    final difference = now.difference(messageTime);

    if (difference.inMinutes < 5) {
      return _successColor; // Très récent - vert
    } else if (difference.inHours < 1) {
      return _warningColor; // Récent - orange
    } else {
      return Colors.grey.shade400; // Ancien - gris
    }
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/no_data.json',
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            'Chargement des conversations...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/error.json',
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            'Erreur de chargement',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade600,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Impossible de charger les conversations. Vérifiez votre connexion.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _refreshChats,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: Icon(Icons.refresh_rounded, size: 18),
            label: Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/no_data.json',
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            'Aucune conversation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Commencez une nouvelle conversation avec vos clients',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(Timestamp timestamp) {
    final time = timestamp.toDate();
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'À l\'instant';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} j';
    } else {
      return DateFormat('dd/MM/yy').format(time);
    }
  }

  void _refreshChats() {
    setState(() {});
  }
}