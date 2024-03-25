part of 'chat_room_bloc.dart';

 class ChatRoomState extends Equatable {
  const ChatRoomState();
  
  @override
  List<Object> get props => [];
}

final class ChatLaodingState extends ChatRoomState {}
final class ChatLoadedState extends ChatRoomState{
  final List<UserModel> ChatList;
  ChatLoadedState({required this.ChatList});
    
  @override
  List<Object> get props => [ChatList];
}