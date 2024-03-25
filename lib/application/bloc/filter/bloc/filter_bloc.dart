import 'dart:async';

import 'package:bloc/bloc.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterState()) {
    on<ApplySliderEevent>(_applySlider);
    on<ApplyCateEvent>(_applyCate);
    on<ApplyType>(_applyType);
  }

  FutureOr<void> _applySlider(
      ApplySliderEevent event, Emitter<FilterState> emit) {
    emit(state.copyWith(minPrice: event.minPrice, maxPrice: event.maxPrice));
  }

  FutureOr<void> _applyCate(ApplyCateEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(selectedCategory: event.selectedCategory));
  }

  FutureOr<void> _applyType(ApplyType event, Emitter<FilterState> emit) {
    emit(state.copyWith(selectedType: event.selectedtype));
  }
}
