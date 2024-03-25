import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/domain/userModel/userModel.dart';
import 'package:travel_app/infrastructure/agencyRepo.dart';

part 'agency_event.dart';
part 'agency_state.dart';

class AgencyBloc extends Bloc<AgencyEvent, AgencyState> {
  final AgencyProfoRepo agencyrepositry;
  AgencyBloc(this.agencyrepositry) : super(AgencyState()) {
    on<GetAgencyData>((event, emit)async {
       emit(AgencyLoadingState());
       await Future.delayed(Duration(milliseconds: 500));
       try{
          final data=await agencyrepositry.get(uid: event.uid);
          print(data);
          emit(AgencyLodedState(data));
       }catch(e){
         print(e.toString());
       }
    });
  }
}
