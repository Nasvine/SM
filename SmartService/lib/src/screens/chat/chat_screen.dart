import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/models/auth/user_model.dart';
import 'package:smart_service/src/repository/chat_service.dart';
import 'package:smart_service/src/screens/chat/chat_bubble.dart';
import 'package:smart_service/src/screens/chat/message_bubble.dart';
import 'package:smart_service/src/screens/chat/message_bubble_next.dart';
import 'package:smart_service/src/screens/tabs.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/texts/text_form_field_simple_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String receiverID;
  final String receiverEmail;

  ChatScreen({
    super.key,
    required this.receiverID,
    required this.receiverEmail,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final _chatService = ChatService();
  final _auth = FirebaseAuth.instance.currentUser!;
  UserModel receiverInfo = UserModel.empty();
  bool _isSending = false;
  bool _showScrollToBottom = false;

  // Couleurs personnalisées pour le design
  final Color _primaryColor = ColorApp.tPrimaryColor;
  final Color _secondaryColor = ColorApp.tsecondaryColor;
  final Color _successColor = Colors.green;
  final Color _warningColor = Colors.orange;
  final Color _infoColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    fetchReceiver();
    _scrollController.addListener(_onScroll);
    _focusNode.addListener(_onFocusChange);
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      setState(() {
        _showScrollToBottom = currentScroll < maxScroll - 100;
      });
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _scrollToBottomInstant() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0.0);
    }
  }

  // send message
  void sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _isSending = true;
    });

    try {
      await _chatService.sendMessage(
        widget.receiverID,
        _messageController.text.trim(),
        receiverInfo.fcmToken ?? '',
      );
      _messageController.clear();
      _scrollToBottom();
    } catch (e) {
      print('Error sending message: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'envoi du message'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  void fetchReceiver() async {
    try {
      final data = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.receiverID)
          .get();
      if (data.exists) {
        final user = UserModel.fromSnapshot(data);
        setState(() {
          receiverInfo = user;
        });
      }
    } catch (e) {
      print('Error fetching receiver: $e');
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.offAll(() => TabsScreen(initialIndex: 2)),
        icon: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _primaryColor.withOpacity(0.1),
          ),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: _primaryColor,
            size: 18,
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _primaryColor.withOpacity(0.3), width: 2),
            ),
            child: ClipOval(
              child: receiverInfo.profilePicture != null && receiverInfo.profilePicture!.isNotEmpty
                  ? Image.network(
                      receiverInfo.profilePicture!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _primaryColor.withOpacity(0.1),
                          ),
                          child: Icon(
                            Icons.person,
                            color: _primaryColor,
                            size: 20,
                          ),
                        );
                      },
                    )
                  : Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _primaryColor.withOpacity(0.1),
                      ),
                      child: Icon(
                        Icons.person,
                        color: _primaryColor,
                        size: 20,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                receiverInfo.fullName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              /* StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.receiverID)
                    .snapshots(),
                builder: (context, snapshot) {
                  final isOnline = snapshot.data?['isOnline'] ?? false;
                  return Text(
                    isOnline ? 'En ligne' : 'Hors ligne',
                    style: TextStyle(
                      fontSize: 12,
                      color: isOnline ? _successColor : Colors.grey,
                    ),
                  );
                },
              ), */
            ],
          ),
        ],
      ),
      actions: [
        /* IconButton(
          onPressed: () {
            // Action pour les options supplémentaires
          },
          icon: Icon(Icons.more_vert, color: _primaryColor),
        ), */
      ],
      elevation: 1,
      backgroundColor: THelperFunctions.isDarkMode(context)
          ? Colors.grey[900]
          : Colors.white,
    );
  }

  Widget _buildMessageList() {
    String senderID = _auth.uid;
    
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return _buildEmptyState();
        }

        if (chatSnapshots.hasError) {
          return _buildErrorState();
        }

        final loadedMessages = chatSnapshots.data!.docs;

        return Stack(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(bottom: 80, left: 16, right: 16, top: 16),
              reverse: true,
              controller: _scrollController,
              itemCount: loadedMessages.length,
              itemBuilder: (ctx, index) {
                final chatMessage = loadedMessages[index].data() as Map<String, dynamic>;

                if (!chatMessage.containsKey('message') || !chatMessage.containsKey('senderID')) {
                  return SizedBox.shrink();
                }

                final nextChatMessage = index + 1 < loadedMessages.length
                    ? loadedMessages[index + 1].data() as Map<String, dynamic>
                    : null;

                final currentMessageUserId = chatMessage['senderID'];
                final nextMessageUserId = nextChatMessage != null
                    ? nextChatMessage['senderID']
                    : null;
                final nextUserIsSame = nextMessageUserId == currentMessageUserId;

                final timestamp = chatMessage['timestamp'] as Timestamp?;
                final messageTime = timestamp != null 
                    ? DateFormat('HH:mm').format(timestamp.toDate())
                    : '';

                if (nextUserIsSame) {
                  return MessageBubbleNext.next(
                    message: chatMessage['message'],
                    isMe: _auth.uid == currentMessageUserId,
                    time: messageTime,
                  );
                } else {
                  return MessageBubble.first(
                    userImage: _auth.uid == currentMessageUserId 
                        ? _auth.photoURL ?? ''
                        : receiverInfo.profilePicture ?? '',
                    username: _auth.uid == currentMessageUserId
                        ? 'Vous'
                        : receiverInfo.fullName,
                    message: chatMessage['message'],
                    isMe: _auth.uid == currentMessageUserId,
                    time: messageTime,
                  );
                }
              },
            ),

            // Bouton scroll to bottom
            if (_showScrollToBottom)
              Positioned(
                bottom: 90,
                right: 20,
                child: FloatingActionButton.small(
                  onPressed: _scrollToBottomInstant,
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.arrow_downward, size: 18),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: _primaryColor),
          SizedBox(height: 16),
          Text(
            'Chargement des messages...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
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
            'assets/images/empty_chat.json',
            height: 200,
            width: 200,
          ),
          SizedBox(height: 20),
          Text(
            'Aucun message',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Envoyez le premier message pour commencer la conversation',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
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
          Icon(Icons.error_outline, size: 64, color: Colors.red),
          SizedBox(height: 16),
          Text(
            'Erreur de chargement',
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: THelperFunctions.isDarkMode(context)
            ? Colors.grey[800]
            : Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              focusNode: _focusNode,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Tapez votre message...',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
              ),
              onSubmitted: (value) => sendMessage(),
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: _messageController.text.trim().isEmpty
                    ? [Colors.grey, Colors.grey]
                    : [_primaryColor, _secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: _messageController.text.trim().isEmpty
                  ? []
                  : [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
            ),
            child: IconButton(
              onPressed: _messageController.text.trim().isEmpty || _isSending
                  ? null
                  : sendMessage,
              icon: _isSending
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildUserInput(context),
          ],
        ),
      ),
    );
  }
}