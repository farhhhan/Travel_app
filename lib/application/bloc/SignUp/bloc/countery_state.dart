// country_state.dart
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:country_picker/country_picker.dart';

@immutable
class CountryState extends Equatable {
  final Country? country;
  final TextEditingController? controller;

  const CountryState({ this.country,  this.controller});

  factory CountryState.initial() {
    return CountryState(
      country: Country(
        phoneCode: '91',
        countryCode: 'IN',
        e164Sc: 0,
        geographic: true,
        level: 1,
        name: 'India',
        example: 'India',
        displayName: 'India',
        displayNameNoCountryCode: 'IN',
        e164Key: '',
      ),
      controller: TextEditingController(),
    );
    
  }


  CountryState withController({required String value}) {
    return CountryState(
      country: this.country,
      controller: TextEditingController(text: value),
    );
  }

  @override
  List<Object?> get props => [country, controller];

 
}
