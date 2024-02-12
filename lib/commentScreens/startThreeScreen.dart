import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/user_login.dart';

class startThreeScreen extends StatelessWidget {
  const startThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 400,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0)),
                image: DecorationImage(
                    image: AssetImage('images/image3.png'), fit: BoxFit.fill)),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Text(
                'It’s a big world out there ',
                style: GoogleFonts.abhayaLibre(
                    fontSize: 28, fontWeight: FontWeight.w700),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' go ',
                    style: GoogleFonts.abhayaLibre(
                        fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'explore',
                    style: GoogleFonts.abhayaLibre(
                        color: Colors.orange,
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '''        To get the  best  of adaventure yo just 
   need to leave and go where you like,we are
                                waiting for you''',
            style: GoogleFonts.abhayaLibre(
                fontSize: 16, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserLoginScreen(),
                  ),
                  (route) => false);
            },
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Let's Start",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(image: AssetImage('images/logo.jpg'))),
          )
        ],
      ),
    );
  }
}
