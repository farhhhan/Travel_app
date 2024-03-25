import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/domain/userModel/userModel.dart';
import 'package:travel_app/infrastructure/profileAuth.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfile agencyrepositry;
  UserBloc(this.agencyrepositry) : super(UserProfileState()) {
    on<GetUserEvent>((event, emit)async {
       emit(UserLoadingState());
       await Future.delayed(Duration(milliseconds: 500));
       try{
          final data=await agencyrepositry.get();
          print(data);
          emit(UserLodedState(data));
       }catch(e){
         print(e.toString());
       }
    });
  }
}
