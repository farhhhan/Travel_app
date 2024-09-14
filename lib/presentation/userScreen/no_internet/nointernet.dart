import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:travel_app/presentation/commentScreens/startScreen.dart';

class NoInternetPage extends StatefulWidget {
  NoInternetPage({required this.internetResult, Key? key}) : super(key: key);
  bool internetResult;

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset('images/no_internet.gif'),
          Text(
            "No Internet Connection",
            style: GoogleFonts.aBeeZee(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              print(widget.internetResult);
           
                widget.internetResult =
                    await InternetConnectionChecker().hasConnection;
            
              if (widget.internetResult) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => StartScreen()),
                    (route) => false);
              }
            },
            child: AnimateIcon(
              key: UniqueKey(),
              onTap: () async{
                
                  widget.internetResult =
                      await InternetConnectionChecker().hasConnection;
              
                if (widget.internetResult) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => StartScreen()),
                      (route) => false);
                }
              },
              iconType: IconType.animatedOnTap,
              height: 70,
              width: 70,
              color: const Color.fromARGB(255, 110, 138, 185),
              animateIcon: AnimateIcons.refresh,
              toolTip: "Reload",
            ),
          ),
        ],
      ),
    );
  }
}
