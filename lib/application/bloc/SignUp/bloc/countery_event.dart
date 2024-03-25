// country_event.dart
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class CountryEvent extends Equatable {
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

class TextControllerEvent extends CountryEvent {
  final TextEditingController controller;

  const TextControllerEvent({required this.controller});

  @override
  List<Object> get props => [controller];
}

class TextValueChangedEvent extends CountryEvent {
  final String value;

  const TextValueChangedEvent({required this.value});

  @override
  List<Object> get props => [value];
}

