import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavInitialState(index: 0)) {
    on((event, emit) {
      if (event is changeEvent) {
        emit(state.copyWith(index: event.index));
      } else if (event is LogoutEvent) {
        emit(state.copyWith(index: 0));
      }
    });
  }
}
