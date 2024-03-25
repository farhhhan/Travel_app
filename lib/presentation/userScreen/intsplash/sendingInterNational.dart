import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app/presentation/commentScreens/bottom_navigator.dart';

class SplashBooked extends StatefulWidget {
  const SplashBooked({super.key});

  @override
  State<SplashBooked> createState() => _SplashBookedState();
}


class _SplashBookedState extends State<SplashBooked> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    succes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
        Image.network('https://cdn.dribbble.com/users/722246/screenshots/4400319/loading_crescor_dribbble.gif'),
      ),
    );
  }
   Future<void> succes() async {
    await Future.delayed(Duration(seconds: 4));
     Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserBottomNavScreen()));
  }
}