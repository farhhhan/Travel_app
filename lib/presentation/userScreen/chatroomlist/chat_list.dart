import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/application/bloc/chatBloc/bloc/chat_room_bloc.dart';
import 'package:travel_app/infrastructure/chatRepo.dart';
import 'package:travel_app/presentation/custome_widget/custom_bookskell.dart';
import 'package:travel_app/presentation/themeData/themeDataColors.dart';
import 'package:travel_app/presentation/userScreen/chat/chatScreen.dart';
import 'package:travel_app/presentation/userScreen/chatroomlist/skell/chatroomSkell.dart';

class ChatRoomListScreen extends StatefulWidget {
  const ChatRoomListScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomListScreen> createState() => _ChatRoomListScreenState();
}

class _ChatRoomListScreenState extends State<ChatRoomListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatRoomBloc>().add(getChatListEvent(search: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messaging',
          style: GoogleFonts.aBeeZee(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        bottom: PreferredSize(
          preferredSize: Size(10, 29),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CupertinoSearchTextField(
              onChanged: (value) {
                context
                    .read<ChatRoomBloc>()
                    .add(getChatListEvent(search: value));
              },
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ChatRoomBloc, ChatRoomState>(
            builder: (context, state) {
              if (state is ChatLaodingState) {
                return Expanded(child: custom_chatSKell());
              } else if (state is ChatLoadedState) {
                if (state.ChatList.length <= 0) {
                  return Center(
                    child: Image.network(
                      'https://th.bing.com/th/id/OIP.XTXjmYjjoYO9w6nSVw0gqQHaFj?w=206&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.ChatList.length,
                    itemBuilder: (context, index) {
                      final String currentUid =
                          FirebaseAuth.instance.currentUser!.uid;
                      return StreamBuilder<DocumentSnapshot?>(
                        stream: MessageRepo().getLasMessage(
                            currentUid, state.ChatList[index].uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                custom_chstList(),
                                SizedBox(
                                  width: 20,
                                ),
                                custom_skel(heiht: 20, width: 40)
                              ],
                            );
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          Map<String, dynamic>? chatRoomData =
                              snapshot.data?.data() as Map<String, dynamic>?;
                          String? lastMessage =
                              chatRoomData?['last_msg'] as String?;
                          bool isCurrentUser = chatRoomData!['from_id'] ==
                              FirebaseAuth.instance.currentUser!.uid;
                          Timestamp? lastTime =
                              chatRoomData['last_time'] as Timestamp?;
                          String lastMessageTime = lastTime != null
                              ? DateFormat('HH:mm').format(lastTime.toDate())
                              : '';
                              return
                               Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatsScreen(
                                            userModel: state.ChatList[index],
                                          ),
                                        ),
                                      );
                                    },
                                    leading: CircleAvatar(
                                      maxRadius: 40,
                                      backgroundImage: NetworkImage(
                                          state.ChatList[index].profile),
                                    ),
                                    title: Text(state.ChatList[index].name),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 4,
                                            ),
                                            SizedBox(
                                              width: 100,
                                              height: 30 ,
                                              child: Text('$lastMessage',
                                                  style: ThemeDataColors.roboto(
                                                      colors: isCurrentUser
                                                          ? Colors.white
                                                          : Colors.green,
                                                      fontsize: 17)),
                                            ),
                                          ],
                                        ),
                                        Text('$lastMessageTime',
                                            style: ThemeDataColors.roboto(
                                                colors: isCurrentUser
                                                    ? Colors.white
                                                    : Colors.green,
                                                fontsize: 17)),
                                      ],
                                    ),
                                  ),
                                  Divider()
                                ],
                              );
                        },
                      );
                    },
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
