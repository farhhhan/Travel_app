import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:travel_app/application/bloc/imageBloc/bloc/img_bloc_bloc.dart';
import 'package:travel_app/application/bloc/profileUser/bloc/user_bloc.dart';
import 'package:travel_app/domain/userModel/userModel.dart';

class UserProfileEdit extends StatefulWidget {
  UserProfileEdit({required this.agency, Key? key}) : super(key: key);
  final UserModel agency;

  @override
  State<UserProfileEdit> createState() =>
      _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController.text = widget.agency.name;
    emailController.text = widget.agency.email;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(color: Colors.black),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              right: 10,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(40),
                ),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => _showBottomSheet(context),
                            child: BlocBuilder<ImgBlocBloc, ImgBlocState>(
                              builder: (context, state) {
                                return CircleAvatar(
                                  maxRadius: 70,
                                  backgroundImage: state.file != null
                                      ? FileImage(
                                          File(state.file!.path),
                                        )
                                      : null,
                                  child: state.file == null
                                      ? ClipOval(
                                          child: Image.network(
                                            widget.agency.profile,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        )
                                      : null,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: nameController,
                      style: TextStyle(color: Colors.black), // Set text color to black
                      decoration: InputDecoration(
                        hintText: 'Name',
                        labelText: 'Name', // Use 'labelText' instead of 'label'
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      readOnly: true,
                      style: TextStyle(color: Colors.black), // Set text color to black
                      decoration: InputDecoration(
                        hintText: 'Email',
                        labelText: 'Email', // Use 'labelText' instead of 'label'
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<ImgBlocBloc, ImgBlocState>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () async {
                                 showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child:CircularProgressIndicator()
                                      );
                                    });
                                await _updateAgency(state.file!);
                                showSnackBar(
                                    context, 'Profile Update Succesfully');
                                context.read<ImgBlocBloc>().add(SaveEvent());
                                context.read<UserBloc>().add(GetUserEvent());
                                
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
                                      "Update",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet<dynamic>(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return BlocBuilder<ImgBlocBloc, ImgBlocState>(
            builder: (context, state) {
              return ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () {
                      context.read<ImgBlocBloc>().add(camerPickerEvent());
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.camera),
                    title: Text('Take Form Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      context.read<ImgBlocBloc>().add(gellaryPickerEvent());
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.browse_gallery),
                    title: Text('Take Form Gellary'),
                  ),
                ],
              );
            },
          );
        });
  }

  Future<void> _updateAgency(XFile imageFile) async {
    widget.agency.name = nameController.text;
    if (imageFile != null) {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/foldername' + '1224');
      firebase_storage.UploadTask uploadTask =
          ref.putFile(File(imageFile.path));
      await uploadTask;
      String newUrl = await ref.getDownloadURL();
      print(widget.agency.profile);
      widget.agency.profile = newUrl ?? widget.agency.profile;
      print(widget.agency.profile);
    }
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.agency.uid)
        .update(widget.agency.toJson());
        Navigator.pop(context);
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      elevation: 10,
      backgroundColor: Colors.white,
      content: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
