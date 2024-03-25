import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/domain/bookedModel/bookeModel.dart';
import 'package:travel_app/infrastructure/bookedRepo.dart';

part 'package_event.dart';
part 'package_state.dart';

class BookedBloc extends Bloc<BookedEvent, BookedState> {
   BookedRepo bookedRepo;
  BookedBloc(this.bookedRepo) : super(BookedState()) {
   on<GetBookedEvent>(_getpackage);
  }

  FutureOr<void> _getpackage(GetBookedEvent event, Emitter<BookedState> emit) async{
     emit(LoadingState());
       await Future.delayed(Duration(milliseconds: 500));
       try{
          List<BookedModel> data=await bookedRepo.get();
          print(data);
          emit(LoadedState(bookedList: data));
       }catch(e){
         print(e.toString());
       }
  }
  

  // FutureOr<void> search(SearchEvent event, Emitter<PackageState> emit)async {
  //   emit(LoadingState());
  //      await Future.delayed(Duration(milliseconds: 300));
  //      try{
  //         if(event.value.isNotEmpty && event.value.length>0){
  //         // final data=await bookedRepo.searchPackage(event.value);
  //         emit(LoadedState(packageList: data));
  //         }else{
  //            final data=await bookedRepo.get();
  //         emit(LoadedState(packageList: data));
  //         }
  //      }catch(e){
  //        print(e.toString());
  //      }
  // }

}
