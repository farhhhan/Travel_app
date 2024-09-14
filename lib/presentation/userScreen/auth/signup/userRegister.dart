import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:travel_app/application/bloc/imageBloc/bloc/img_bloc_bloc.dart';
import 'package:travel_app/infrastructure/registerRepo.dart';
import 'package:travel_app/infrastructure/firebaseStoreLogin.dart';

class UserRegister extends StatefulWidget {
  UserRegister({Key? key, required this.number, required this.isUser})
      : super(key: key);
  final String number;
  final bool isUser;

  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoadingProfile = false;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: BlocBuilder<ImgBlocBloc, ImgBlocState>(
            builder: (context, state) {
              return ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              child: Center(
                                child: Icon(Icons.arrow_back),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Sign Up for a',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'New Account',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Please Register to continue our app',
                        style: GoogleFonts.abel(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => RegisterRepo().ShowBottoms(context),
                            child: CircleAvatar(
                              maxRadius:
                                  MediaQuery.of(context).size.width * 0.2,
                              backgroundImage: state.file != null
                                  ? FileImage(
                                      File(state.file![0].path),
                                    )
                                  : null,
                              child: state.file == null
                                  ? Icon(
                                      Icons.person,
                                      size: MediaQuery.of(context).size.width *
                                          0.15,
                                    )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.verified_user),
                          ),
                          labelText: 'User Name',
                          hintText: 'User Name',
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.mail),
                          ),
                          labelText: 'E-mail Address',
                          hintText: 'Email',
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // Add your email validation logic here if needed
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.password_rounded),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
                              });
                            },
                          ),
                          labelText: 'Password',
                          hintText: 'Password',
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.password_rounded),
                          ),
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
                          labelText: 'Confirm Password',
                          hintText: 'Confirm Password',
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              setState(() {
                                isLoadingProfile = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                if (state.file != null && state.file!.isNotEmpty) {
                                  registerUser(context, state.file![0]);
                                } else {
                                  showSnackBar(context, 'Please select a profile picture.');
                                  setState(() {
                                    isLoadingProfile = false;
                                  });
                                }
                              } else {
                                showSnackBar(context, 'Please make sure all fields are complete.');
                                setState(() {
                                  isLoadingProfile = false;
                                });
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Center(
                                child: isLoadingProfile
                                    ? LoadingAnimationWidget.horizontalRotatingDots(
                                        color: Colors.white,
                                        size: 30,
                                      )
                                    : Text(
                                        "Register",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void registerUser(BuildContext context, XFile file) {
    FireStoreUser().registerUser(
      images: file,
      isUser: widget.isUser,
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      phoneNumber: widget.number,
      username: _userNameController.text,
    ).then((_) {
      setState(() {
        isLoadingProfile = false;
      });
    }).catchError((error) {
      showSnackBar(context, 'Registration failed: $error');
      setState(() {
        isLoadingProfile = false;
      });
    });
  }

  void showSnackBar(BuildContext context, String content) {
    final snackBar = SnackBar(
      content: Container(
        height: 80.0, // Set your desired height here
        alignment: Alignment.center,
        child: Text(content),
      ),
      elevation: 5,
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
      behavior: SnackBarBehavior.floating, // Makes the SnackBar float
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
