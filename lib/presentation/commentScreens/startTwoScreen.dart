import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/presentation/themeData/themeDataColors.dart';

class startTwoScreen extends StatelessWidget {
  const startTwoScreen({super.key});

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
                image: AssetImage('images/image2.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Column(
            children: [
              Text('It’s a big world out there ',
                  style: ThemeDataColors.googleAbl(colors: Colors.white)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(' go ',
                      style: ThemeDataColors.googleAbl(colors: Colors.white)),
                  Text('explore',
                      style: ThemeDataColors.googleAbl(colors: Colors.orange))
                ],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text('''        To get the  best  of adaventure yo just 
   need to leave and go where you like,we are
                                waiting for you''',
              style: ThemeDataColors.googleAbl(
                  colors: Colors.white, fontsize: 17)),
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
                child: Text("Next",
                    style: ThemeDataColors.googleAbl(
                        colors: Colors.white, fontsize: 20)),
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
