
import 'package:bloc/bloc.dart';
import 'package:travel_app/application/bloc/SignUp/bloc/countery_event.dart';
import 'package:travel_app/application/bloc/SignUp/bloc/countery_state.dart';


class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc() : super(CountryState.initial()) {
    on<SelectCountryEvent>(_onSelectCountry);
    on<TextControllerEvent>(_onTextControllerEvent);
    on<TextValueChangedEvent>(_onTextValueChangedEvent);
  }

  void _onSelectCountry(SelectCountryEvent event, Emitter<CountryState> emit) {
    emit(CountryState(country: event.country!));
  }

  void _onTextControllerEvent(
      TextControllerEvent event, Emitter<CountryState> emit) {
    emit(CountryState(controller: event.controller));
  }

  void _onTextValueChangedEvent(
      TextValueChangedEvent event, Emitter<CountryState> emit) {
    emit(state.withController(value: event.value));
  }
}
