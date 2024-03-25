import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/presentation/themeData/themeDataColors.dart';
import 'package:travel_app/presentation/userScreen/auth/login/user_login.dart';

class startThreeScreen extends StatelessWidget {
  const startThreeScreen({super.key});

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
                image: AssetImage('images/image3.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Column(
            children: [
              Text(
                'It’s a big world out there ',
                style:ThemeDataColors.googleAbl(colors: Colors.white)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' go ',
                    style:ThemeDataColors.googleAbl(colors: Colors.white)
                  ),
                  Text(
                    'explore',
                    style: ThemeDataColors.googleAbl(colors: Colors.orange)
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            '''        To get the  best  of adaventure yo just 
   need to leave and go where you like,we are
                                waiting for you''',
            style: ThemeDataColors.googleAbl(colors: Colors.white,fontsize: 17)
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserLoginScreen(),
                      ),
                      (route) => false,
                    ),
                    child: CircleAvatar(
                      maxRadius: 30,
                      child: Image.asset('images/teamwork.png'),
                    ),
                  ),
                  Text(
                    'User',
                    style: ThemeDataColors.googleAbl(colors: Colors.white)
                  )
                ],
              )
            ],
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
