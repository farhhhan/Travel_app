import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/domain/userModel/userModel.dart';
import 'package:travel_app/infrastructure/chatRepo.dart';

class Custome_send extends StatefulWidget {
  Custome_send({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  State<Custome_send> createState() => _Custome_sendState();
}

class _Custome_sendState extends State<Custome_send> {
  final TextEditingController messageController = TextEditingController();

  MessageRepo _messageRepo = MessageRepo();
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _messageRepo.sendMessage(
          widget.userModel.uid, messageController.text, widget.userModel);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 20.0, left: 10, right: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: CupertinoTextField(
              autocorrect: true,
              controller: messageController,
              placeholder: 'Send message',
              cursorColor: Colors.white,
              maxLines: null,
              onChanged: (value) {
                int numLines = (value.length / 40).ceil();
                numLines = numLines == 0 ? 1 : numLines;

                if (messageController.text.isNotEmpty) {
                  setState(() {
                    messageController.text = messageController.text;
                  });
                }
              },
              style: TextStyle(color: Colors.white), // Set text color to white
              decoration: BoxDecoration(
                border: Border.all(
                  color: CupertinoColors.white,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            )),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                sendMessage();
              },
              child: CircleAvatar(
                maxRadius: 20,
                backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.BbLuhDDb6sN1uWcP6Db31gAAAA?w=300&h=300&rs=1&pid=ImgDetMain'),
              ),
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
      ),
    );
  }
}
