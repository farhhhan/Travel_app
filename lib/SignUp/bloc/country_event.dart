import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object> get props => [];
}

class SelectCountryEvent extends CountryEvent {
  final Country? country;

  const SelectCountryEvent({this.country});

  @override
  List<Object> get props => [country!];
}
