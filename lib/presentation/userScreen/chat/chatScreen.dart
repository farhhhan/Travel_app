import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/domain/userModel/userModel.dart';
import 'package:travel_app/infrastructure/chatRepo.dart';
import 'package:travel_app/presentation/custome_widget/custom_send.dart';
import 'package:travel_app/presentation/userScreen/agencyshow/agencyPackages.dart';
import 'package:travel_app/presentation/userScreen/chat/chatbuble.dart';

// ignore: must_be_immutable
class ChatsScreen extends StatefulWidget {
  ChatsScreen({required this.userModel, super.key});
  UserModel? userModel;

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController messageController = TextEditingController();

  MessageRepo _messageRepo = MessageRepo();
  List<DateTime> _messageDates = [];

  @override
  void initState() {
    super.initState();
    _markMessagesAsSeen();
  }

  Future<void> _markMessagesAsSeen() async {
    await _messageRepo.markMessagesAsSeen(widget.userModel!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AgencyIndvScreen(
                  agencyModel: widget.userModel!,
                ),
              ),
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: 30,
                backgroundImage: NetworkImage(widget.userModel!.profile),
              ),
              SizedBox(
                width: 10,
              ),
              Text('${widget.userModel!.name}')
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          Custome_send(userModel: widget.userModel!)
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _messageRepo.getMessage(
          FirebaseAuth.instance.currentUser!.uid, widget.userModel!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error is show');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        final docs = snapshot.data!.docs;
        _messageDates = _getMessageDates(docs);
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final message = docs[index];
            final isLastMessageOfDay = _isLastMessageOfDay(index);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isLastMessageOfDay) _buildDateHeader(message),
                _buildMessageItem(message),
              ],
            );
          },
        );
      },
    );
  }

  List<DateTime> _getMessageDates(List<QueryDocumentSnapshot<Object?>> docs) {
    return docs.map((e) {
      int sendTimeInMillis = e['send_time'];
      return DateTime.fromMillisecondsSinceEpoch(sendTimeInMillis);
    }).toList();
  }

  bool _isLastMessageOfDay(int index) {
    if (index == 0) return true;
    final currentDate = _messageDates[index];
    final previousDate = _messageDates[index - 1];
    return currentDate.day != previousDate.day;
  }
Widget _buildDateHeader(QueryDocumentSnapshot<Object?> message) {
  int sendTimeInMillis = message['send_time'];
  DateTime sendTime = DateTime.fromMillisecondsSinceEpoch(sendTimeInMillis);
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

  String formattedDate;

  if (sendTime.year == now.year &&
      sendTime.month == now.month &&
      sendTime.day == now.day) {
    formattedDate = 'Today';
  } else if (sendTime.year == yesterday.year &&
      sendTime.month == yesterday.month &&
      sendTime.day == yesterday.day) {
    formattedDate = 'Yesterday';
  } else {
    formattedDate = DateFormat('dd MMM yyyy').format(sendTime);
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          formattedDate,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}
  Widget _buildMessageItem(QueryDocumentSnapshot<Object?> e) {
    Map<String, dynamic> data = e.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data['send_id'] == FirebaseAuth.instance.currentUser!.uid;
    int sendTimeInMillis = data['send_time'];
    DateTime sendTime = DateTime.fromMillisecondsSinceEpoch(sendTimeInMillis);

    String messageContent = data['messege_content'] ?? '';
    String period = sendTime.hour < 12 ? 'AM' : 'PM';
    int hour12 = sendTime.hour == 0 ? 12 : sendTime.hour % 12;
    String formattedTime =
        '${hour12.toString().padLeft(2, '0')}:${sendTime.minute.toString().padLeft(2, '0')} $period';

    return ChatBubble(
                messageContent: messageContent,
                isCurrentUser: isCurrentUser,
                isSeen: data['seen_time'],
                formattedTime: formattedTime,
              );
  }
}


