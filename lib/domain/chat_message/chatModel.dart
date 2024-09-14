import 'package:flutter/foundation.dart' show immutable;

@immutable
class Message {
  final String sendEmail; 
  final String message;
  final String messageId;
  final String senderId;
  final String receiverId;
  final DateTime dateTime; 
  final bool seen;
  final String messageType;

  const Message({
    required this.sendEmail,
    required this.message,
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.seen,
    required this.messageType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'send_Email': sendEmail,
      'messege_content': message,
      "messege_id": messageId,
      'send_id': senderId,
      'recive_id': receiverId,
      'send_time': dateTime.millisecondsSinceEpoch,
      'seen_time': seen,
      'messege_type': messageType,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      sendEmail: map['send_Email'] as String, 
      message: map['messege_content'] as String,
      messageId: map["messege_id"] as String,
      senderId: map['send_id'] as String,
      receiverId: map['recive_id'] as String, 
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['send_time'] as int),
      seen: map['seen_time'] as bool,
      messageType: map['messege_type'] as String,
    );
  }
}
