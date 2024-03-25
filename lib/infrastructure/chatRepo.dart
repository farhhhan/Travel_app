import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_app/domain/chat_message/chatModel.dart';
import 'package:travel_app/domain/userModel/userModel.dart';
import 'package:uuid/uuid.dart';

class MessageRepo extends ChangeNotifier {
  final _fireAuth = FirebaseAuth.instance;
  Future<void> sendMessage(
      String receiverId, String message, UserModel agency) async {
    print(receiverId);
    final String currentUid = _fireAuth.currentUser!.uid;
    final currentemail = _fireAuth.currentUser!.email;
    DateTime dateTime = DateTime.now();
    final messageId = const Uuid().v1();
    Message newMessage = Message(
        sendEmail: currentemail!,
        message: message,
        messageId: messageId,
        senderId: currentUid,
        receiverId: receiverId,
        dateTime: dateTime,
        seen: false,
        messageType: 'text');
    print(currentUid);
    print(receiverId);
    List<String> ids = [currentUid, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    await FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());
    List<UserModel> usersList = [];
    final datas = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: _fireAuth.currentUser!.uid)
        .get();
    datas.docs.forEach((element) {
      usersList.add(UserModel.fromJson(element.data()));
    });
    final chatListSnapshot = await FirebaseFirestore.instance
        .collection('chat_list_user')
        .doc(currentUid)
        .collection('chatrooms')
        .where('receiver', isEqualTo: agency.uid)
        .limit(1)
        .get();
    final chatReciverList = await FirebaseFirestore.instance
        .collection('chat_list_user')
        .doc(receiverId)
        .collection('chatrooms')
        .where('sender', isEqualTo: receiverId)
        .limit(1)
        .get();
    if (chatListSnapshot.docs.isEmpty) {
      final data1 = {
        'receiver_name': agency.name,
        'receiver': receiverId,
        'sender_Model': agency.toJson(),
        'sender': currentUid
      };
      await FirebaseFirestore.instance
          .collection('chat_list_user')
          .doc(currentUid)
          .collection('chatrooms')
          .add(data1);
      if (chatReciverList.docs.isEmpty) {
        final data2 = {
          'receiver_name': usersList[0].name,
          'receiver': receiverId,
          'reciver_Model': usersList[0].toJson(),
          'sender': currentUid
        };
        await FirebaseFirestore.instance
            .collection('chat_list_agency')
            .doc(receiverId)
            .collection('chatrooms')
            .add(data2);
      } 
    }
     int count=0;
     await FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomId).set(
          {
            'from_id':currentUid,
            'to_id':receiverId,
            'last_msg':message,
            'last_time':DateTime.now(),
            'msg_num':count,
          }
        );
  }

  Future<void> markMessagesAsSeen(String receiverId) async {
  final String currentUid = _fireAuth.currentUser!.uid;
  List<String> ids = [currentUid, receiverId];
  ids.sort();
  String chatRoomId = ids.join('_');
  QuerySnapshot messagesSnapshot = await FirebaseFirestore.instance
      .collection('chat_rooms')
      .doc(chatRoomId)
      .collection('message')
      .get();
  for (QueryDocumentSnapshot messageSnapshot in messagesSnapshot.docs) {
    Map<String, dynamic>? messageData = messageSnapshot.data() as Map<String, dynamic>?;
    String? messageSenderId = messageData?['send_id'] as String?;
    if (messageSenderId != currentUid) {
      await messageSnapshot.reference.update({'seen_time': true});
    }
  }
}

  Future<UserModel> getUserModelById(String? uid) async {
    final snapshot =
        await FirebaseFirestore.instance.collection("Users").doc(uid).get();

    UserModel user =
        UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return user;
  }

  Future<List<UserModel>> getChatUsers(String searchQuery) async {
    final String currentUid = _fireAuth.currentUser!.uid;
    final List<UserModel> chatUsersList = [];
    try {
      QuerySnapshot chatListSnapshot;
      if (searchQuery.isNotEmpty) {
        print(searchQuery);
        chatListSnapshot = await FirebaseFirestore.instance
            .collection('chat_list_user')
            .doc(currentUid)
            .collection('chatrooms')
            .where('receiver_name', isEqualTo: searchQuery)
            .startAt([searchQuery]).endAt(
                [searchQuery + '\uf8ff']).get(); // Use lowercase 'name'
      } else {
        chatListSnapshot = await FirebaseFirestore.instance
            .collection('chat_list_user')
            .doc(currentUid)
            .collection('chatrooms')
            .get();
      }
      chatListSnapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);
        if (data != null) {
          final userModelJson = data['sender_Model'];
          final userModel = UserModel.fromJson(userModelJson);
          chatUsersList.add(userModel);
        }
      });
      print(chatUsersList[0].name);
      return chatUsersList;
    } catch (e) {
      // Handle error
      print('Error getting chat users: $e');
      return []; // Return empty list in case of error
    }
  }

  Future<void> deleteUser(String chatroomid) async {
    final String currentUid = _fireAuth.currentUser!.uid;
    final List<UserModel> chatUsersList = [];
    await FirebaseFirestore.instance
        .collection('chat_list_user')
        .doc(currentUid)
        .collection('chatrooms')
        .where('sender', isEqualTo: currentUid)
        .get();
  }
 Stream<DocumentSnapshot> getLasMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return  FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomId)
        .snapshots(); 
  }
 
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('send_time', descending: false)
        .snapshots();
  }
}
