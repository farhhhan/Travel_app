import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CountryState extends Equatable {
  final Country country;

  CountryState({required this.country});

  // Providing a default country if none is provided
  factory CountryState.initial() => CountryState(
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
      ));

  CountryState copyWith(Country? country) {
    return CountryState(country: country ?? this.country);
  }

  @override
  List<Object?> get props => [country];
}
