import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/presentation/userScreen/auth/login/user_login.dart';
import 'package:travel_app/presentation/commentScreens/comen_text.dart';
import 'package:travel_app/presentation/commentScreens/startThreeScreen.dart';
import 'package:travel_app/presentation/commentScreens/startTwoScreen.dart';
import 'package:travel_app/presentation/commentScreens/stratoneScreen.dart';


class ScreenIndicator extends StatefulWidget {
    ScreenIndicator({super.key});

  @override
  State<ScreenIndicator> createState() => _ScreenIndicatorState();
}

class _ScreenIndicatorState extends State<ScreenIndicator> {
  final _controller = PageController();

  bool isLastPage = false;
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                isLastPage = (value == 2);
                isFirst = (value == 0);
              });
            },
            controller: _controller,
            children: [
              startOneScreen(),
              startTwoScreen(),
              startThreeScreen(),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: JumpingDotEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    verticalOffset: 20,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 30,
            child: InkWell(
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>UserLoginScreen()), (route) => false);
              },
              child: custom_orangeText(contents: isLastPage? '' :'Skip >'))),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.0,
            left: MediaQuery.of(context).size.width * 0.06,
            right: MediaQuery.of(context).size.width * 0.0 ,
            top:  MediaQuery.of(context).size.height * 0.6,
            child: Row(
              children: [
                SizedBox(width:   MediaQuery.of(context).size.width * 0.03),
                isFirst? Container():InkWell(
                  onTap: (){
                      _controller.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                  },
                  child: CircleAvatar(
                        maxRadius: MediaQuery.of(context).size.width * 0.05,
                        backgroundColor: Colors.grey[400],
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.black,
                          ),
                        ),
                      ),
                ),
                    SizedBox(width:  MediaQuery.of(context).size.width * 0.6,),
                   isLastPage ?Container():Row(
                    children: [
                     isFirst? SizedBox(width:MediaQuery.of(context).size.width * 0.1, ):Container(),
                      InkWell(
                        onTap: (){
                           _controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                        },
                        child: CircleAvatar(
                        maxRadius: MediaQuery.of(context).size.width * 0.05,
                        backgroundColor:  Colors.grey[400],
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.black,
                          ),
                        ),
                                            ),
                      ),
                    ],
                   ),
                 
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
