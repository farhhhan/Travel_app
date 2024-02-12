import 'package:bloc/bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:travel_app/SignUp/bloc/country_state.dart';

import 'country_event.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc() : super(CountryState.initial()) {
    on<SelectCountryEvent>(selectedCountrys);
  }

  void selectedCountrys(SelectCountryEvent event, Emitter<CountryState> emit) {
    emit(state.copyWith(event.country));
  }
}
