part of 'user_bloc.dart';

 class UserProfileState extends Equatable {
  const UserProfileState();
  
  @override
  List<Object> get props => [];
}

class  UserLoadingState extends UserProfileState{

  @override
  List<Object> get props => [];
}

class UserLodedState extends UserProfileState{
  List<UserModel> agencyData;
   UserLodedState(this.agencyData);
  @override
  List<Object> get props => [agencyData];
}
