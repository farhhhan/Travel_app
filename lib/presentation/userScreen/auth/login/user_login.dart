import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:travel_app/presentation/themeData/themeDataColors.dart';
import 'package:travel_app/presentation/userScreen/auth/signup/mobile/user_signUp.dart';
import 'package:travel_app/infrastructure/auth.dart';
import 'package:travel_app/infrastructure/util.dart';
import 'package:travel_app/presentation/commentScreens/bottom_navigator.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({Key? key}) : super(key: key);

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuthentServices _authServices = FirebaseAuthentServices();
  bool isPasswordVisible = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/any.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(40),
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'E-mail Address',
                          hintText: 'Email',
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _passwordController,
                        obscureText: !isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          labelText: 'Password',
                          hintText: 'Password',
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              _authServices
                                  .forgetPassword(_emailController.text);
                              showSnackBar(context,
                                  "Reset Password is Shared in this Mail");
                            },
                            child: Text(
                              'Forgot Password?',
                              style: ThemeDataColors.roboto(fontsize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      InkWell(
                        onTap: () {
                          _signIn(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: (isLoading)
                                  ? LoadingAnimationWidget
                                      .horizontalRotatingDots(
                                      color: Colors.white,
                                      size: 50,
                                    )
                                  : Text(
                                      "Sign In",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.035),
                      Text(
                        'Or Login Via',
                        style: ThemeDataColors.roboto(fontsize: 15),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.034),
                      InkWell(
                        onTap: () {
                          FirebaseAuthentServices()
                              .signInWithGoogle(context, true);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              color: Colors.grey[300],
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 20,
                                        backgroundImage: AssetImage(
                                          'images/google.png',
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),
                                      Text(
                                        'Continue With Google',
                                        style: ThemeDataColors.normalText(
                                            colors: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? "),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserPhoneScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signIn(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;
    setState(() {
      isLoading = true;
    });
    await _authServices
        .signInWithEmailandPassword(email: email, password: password)
        .then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => UserBottomNavScreen()));

      utils().showToast('Login Succesfully');
      setState(() {
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      utils().showToast(error.toString());
      setState(() {
        isLoading = false;
      });
    });
  }

  void showSnackBar(BuildContext context, String content) {
    final snackBar = SnackBar(
      content: Container(
        height: 50.0, // Set your desired height here
        alignment: Alignment.center,
        child: Text(content,style: TextStyle(color: Colors.white),),
      ),
      elevation: 5,
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating, // Makes the SnackBar float
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
