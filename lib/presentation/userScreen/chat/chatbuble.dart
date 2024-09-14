import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final String messageContent;
  final bool isCurrentUser;
  final bool isSeen;
  final String formattedTime;

  const ChatBubble({
    Key? key,
    required this.messageContent,
    required this.isCurrentUser,
    required this.isSeen,
    required this.formattedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.green[700] : Colors.blue[300],
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
                    color: isCurrentUser ? Colors.white : Colors.black,
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
                        color: isCurrentUser ? Colors.white : Colors.black,
                      ),
                    ),
                    if (isCurrentUser)
                      Icon(
                        Icons.done_all,
                        color: isSeen ? Colors.blue : Colors.grey,
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
