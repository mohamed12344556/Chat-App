import 'dart:developer';

import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String id = 'user_chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController userControllerMassage = TextEditingController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  final scrollController = ScrollController();

  // صور المستخدمين
  final String currentUserImageUrl =
      'assets/images/bmw.webp'; // رابط صورة المستخدم الحالي
  final String otherUserImageUrl =
      'assets/images/mercedes.webp'; // رابط صورة المستخدم الآخر

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    log('Current user: $email');

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              MessageModel.fromJson(
                snapshot.data!.docs[i],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('User Chat'),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: Color(0xff000E08),
                  size: 20,
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      log('Message from: ${messagesList[index].id}');
                      return ChatUser(
                        message: messagesList[index],
                        isCurrentUser: messagesList[index].id == email,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: TextField(
                    controller: userControllerMassage,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Color(0xffCDD1D0),
                          width: 1.3,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          messages.add({
                            'message': userControllerMassage.text,
                            'createdAt': DateTime.now(),
                            'id': email,
                            'senderImageUrl':
                                currentUserImageUrl, // إرسال رابط صورة المرسل
                            'receiverImageUrl':
                                otherUserImageUrl, // إرسال رابط صورة المستقبل
                          });
                          userControllerMassage.clear();
                          setState(() {});
                          Future.delayed(Duration(milliseconds: 100))
                              .then((value) {
                            scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn,
                            );
                          });
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.paperPlane,
                          color: Color(0xff000E08),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ChatUser extends StatelessWidget {
  const ChatUser({
    super.key,
    required this.message,
    required this.isCurrentUser,
    // required this.currentUserImageUrl,
  });

  final MessageModel message;
  final bool isCurrentUser;
  // final String currentUserImageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isCurrentUser) // صورة المستخدم الآخر
          CircleAvatar(
            backgroundImage: AssetImage(
              message.receiverImageUrl, // عرض صورة المستقبل
            ),
            radius: 24,
          ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(
              top: 35,
              left: 5,
              right: 16,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 221, 229, 235),
              borderRadius: BorderRadius.only(
                topLeft: isCurrentUser
                    ? const Radius.circular(16)
                    : const Radius.circular(0),
                topRight: !isCurrentUser
                    ? const Radius.circular(16)
                    : const Radius.circular(0),
                bottomLeft: const Radius.circular(16),
                bottomRight: const Radius.circular(16),
              ),
            ),
            child: Text(
              message.message.toString(),
              maxLines: null,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff000E08),
              ),
            ),
          ),
        ),
        if (isCurrentUser) // صورة المستخدم الحالي
          CircleAvatar(
            backgroundImage: AssetImage(
              message.senderImageUrl, // عرض صورة المرسل
            ),
            radius: 24,
          ),
      ],
    );
  }
}
