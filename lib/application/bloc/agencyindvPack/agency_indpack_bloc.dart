import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/infrastructure/agencyPackageRepo.dart';

part 'agency_indpack_event.dart';
part 'agency_indpack_state.dart';

class AgencyIndvBloc extends Bloc<AgencyIndvEvent, AgencyIndvState> {
  AgencyindvRepo packageRepo;
  AgencyIndvBloc(this.packageRepo) : super(AgencyIndvState()) {
   on<GetAgencyIndvEvent>(_getpackage);
   on<SearchEvent>(search);
  }

  FutureOr<void> _getpackage(GetAgencyIndvEvent event, Emitter<AgencyIndvState> emit) async{
     emit(LoadingState());
       await Future.delayed(Duration(milliseconds: 500));
       try{
          final data=await packageRepo.get(event.uid);
          emit(AgencyIndvLodedstate(packageList: data));
       }catch(e){
         print(e.toString());
       }
  }
  

  FutureOr<void> search(SearchEvent event, Emitter<AgencyIndvState> emit)async {
    emit(LoadingState());
       await Future.delayed(Duration(milliseconds: 300));
       try{
          if(event.value.isNotEmpty && event.value.length>0){
          final data=await packageRepo.searchPackage(event.value,event.uid);
          emit(AgencyIndvLodedstate(packageList: data));
          }else{
             final data=await packageRepo.get(event.uid);
          emit(AgencyIndvLodedstate(packageList: data));
          }
       }catch(e){
         print(e.toString());
       }
  }

}
