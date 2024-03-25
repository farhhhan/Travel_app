import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/domain/userModel/userModel.dart';
import 'package:travel_app/infrastructure/chatRepo.dart';
import 'package:travel_app/presentation/custome_widget/custom_send.dart';
import 'package:travel_app/presentation/userScreen/agencyshow/agencyPackages.dart';

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
        appBar: AppBar(
          toolbarHeight: 100,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
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
        ));
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        return ListView(
          children:
              snapshot.data!.docs.map((e) => _buildMessageItem(e)).toList(),
        );
      },
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

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green[700],
            borderRadius: BorderRadius.circular(10),
          ),
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  messageContent,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formattedTime,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                   !isCurrentUser ? SizedBox()   : Icon(Icons.done_all,
                  color: data['seen_time']? Colors.blue:Colors.grey ,
                  ), 
                  
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
