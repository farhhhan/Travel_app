import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/presentation/themeData/themeDataColors.dart';

class startOneScreen extends StatelessWidget {
  const startOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
              image: DecorationImage(
                image: AssetImage('images/image1.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Column(
            children: [
              Text(
                'Life is short and the',
                style: GoogleFonts.abhayaLibre(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' world is',
                    style:ThemeDataColors.googleAbl()
                  ),
                  Text(
                    ' wide',
                    style:ThemeDataColors.googleAbl()
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            '''             Ar Friends and  travel, we customize 
   reliable and trutworthy educational tours to 
                  destinations all over the world''',
            style:ThemeDataColors.googleAbl(fontsize: 17,colors: Colors.white)
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Get Started",
                  style:ThemeDataColors.googleAbl(fontsize: 22,colors:Colors.white)
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
           CircleAvatar(
            maxRadius: 30,
            backgroundImage: AssetImage('images/logo.jpg'),
          )
        ],
      ),
    );
  }
}
