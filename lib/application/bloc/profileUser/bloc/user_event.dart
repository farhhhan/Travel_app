part of 'user_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}
class GetUserEvent extends UserProfileEvent{}
  
  
