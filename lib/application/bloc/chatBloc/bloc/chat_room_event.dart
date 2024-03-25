part of 'chat_room_bloc.dart';

sealed class ChatRoomEvent extends Equatable {
  const ChatRoomEvent();

  @override
  List<Object> get props => [];
}

class getChatListEvent extends ChatRoomEvent {
  String search;
  getChatListEvent({required this.search});
   @override
  List<Object> get props => [search];
}
