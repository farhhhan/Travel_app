import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/SignUp/bloc/country_bloc.dart';

import 'package:travel_app/commentScreens/startScreen.dart';

void main(List<String> args) {
  runApp(MaterialsScreen());
}

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({super.key});

  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartScreen(),
      ),
    );
  }
}
