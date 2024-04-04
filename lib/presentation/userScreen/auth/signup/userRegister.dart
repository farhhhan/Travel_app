import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/application/bloc/imageBloc/bloc/img_bloc_bloc.dart';
import 'package:travel_app/infrastructure/registerRepo.dart';
import 'package:travel_app/infrastructure/firebaseStoreLogin.dart';
import 'package:travel_app/presentation/commentScreens/bottom_navigator.dart';

class UserRegister extends StatefulWidget {
  UserRegister({Key? key, required this.number, required this.isUser})
      : super(key: key);
  String number;
  bool isUser;
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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
                                      File(state.file!.path),
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
                        obscureText: true,
                        decoration: InputDecoration(
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.password_rounded),
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
                        obscureText: true,
                        decoration: InputDecoration(
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.password_rounded),
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
                            onTap: ()async {
                              if (_formKey.currentState!.validate() && state.file!=null) {
                                FireStoreUser().registerUser(
                                  images: state.file!,
                                  isUser: widget.isUser,
                                  context: context,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  phoneNumber: widget.number,
                                  username: _userNameController.text,
                                );
                              //  await FirebaseAuthentServices().signInWithEmailandPassword(email: _emailController.text, password: _passwordController.text);
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
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
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
}
