import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/application/bloc/imageBloc/bloc/img_bloc_bloc.dart';
import 'package:travel_app/application/bloc/todo_bloc/todo_bloc.dart';
import 'package:travel_app/domain/data/todo.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddTaskScreen extends StatefulWidget {
  final bool isInternational;

  AddTaskScreen({required this.isInternational});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _panController = TextEditingController();

  List<String> categories = ['Male', 'Female'];
  String? selectedGender;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    context.read<ImgBlocBloc>().add(SaveEvent());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        title: Text('Add Personal Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Card(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Traveller Details',
                          style: GoogleFonts.aBeeZee(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(),
                        CustomTextField(
                          controller: _nameController,
                          labelText: 'Name',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            } else if (!RegExp(r'^[a-zA-Z\s]+$')
                                .hasMatch(value)) {
                              return 'Please enter valid name';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          controller: _ageController,
                          labelText: 'Age',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age';
                            } else if (int.tryParse(value) == null) {
                              return 'Please enter a valid age';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text('Gender'),
                            SizedBox(width: 50),
                            SizedBox(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DropdownButtonFormField<String>(
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select a gender';
                                    }
                                    return null;
                                  },
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  hint: Center(
                                      child: const Text("Select your Type")),
                                  value: selectedGender,
                                  items: categories
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Center(child: Text(item)),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<ImgBlocBloc, ImgBlocState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      widget.isInternational
                          ? Card(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Passport Details',
                                        style: GoogleFonts.aBeeZee(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Divider(),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 160,
                                            child: CustomTextField(
                                              controller: _passportController,
                                              labelText: 'Passport Number',
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter passport number';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              child: CustomTextField(
                                                controller: _expiryController,
                                                labelText: 'Expiry',
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter expiry date';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      CustomTextField(
                                        controller: _countryController,
                                        labelText: 'Issuing Country',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter issuing country';
                                          } else if (!RegExp(r'^[a-zA-Z]+$')
                                              .hasMatch(value)) {
                                            return 'Please enter valid country name';
                                          }
                                          return null;
                                        },
                                      ),
                                      CustomTextField(
                                        controller: _panController,
                                        labelText: 'PAN Card Number',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter PAN card number';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(height: 30),
                    ],
                  );
                },
              ),
              BlocBuilder<ImgBlocBloc, ImgBlocState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      widget.isInternational
                          ? InkWell(
                              child: Container(
                                height: 180,
                                width: 360,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  image: state.file != null &&
                                          state.file!.isNotEmpty &&
                                          state.file!.isNotEmpty
                                      ? DecorationImage(
                                          image: FileImage(
                                              File(state.file![0].path)),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: state.file == null ||
                                        state.file!.isEmpty ||
                                        state.file!.isEmpty
                                    ? Center(child: Icon(Icons.add_a_photo))
                                    : null,
                              ),
                              onTap: () {
                                _showBottomSheet(context);
                              },
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 20,
                      ),
                      widget.isInternational
                          ? Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.orange[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: () {
                                    _showBottomSheet(context);
                                  },
                                  child: Row(
                                    children: [
                                      Text('Upload Image'),
                                      VerticalDivider(
                                        width: 10,
                                        color: Colors.black,
                                      ),
                                      Icon(Icons.upload),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            state.file!.isNotEmpty
                                ? _addTodo(context, state.file![0])
                                : _addTodo(context, null);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
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
                                    "Book Now",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 30),
              SizedBox(height: 40),
            ],
          ),
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
                  title: Text('Take From Camera'),
                ),
                ListTile(
                  onTap: () {
                    context.read<ImgBlocBloc>().add(gellaryPickerEvent());
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.browse_gallery),
                  title: Text('Take From Gallery'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _addTodo(BuildContext context, XFile? image) async {
    if (widget.isInternational) {
      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select an image'),
          ),
        );
        return;
      }
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref('${DateTime.now().millisecondsSinceEpoch.toString()}');
      firebase_storage.UploadTask uploadTask = ref.putFile(File(image.path));
      await uploadTask;
      var imageUrl = await ref.getDownloadURL();
      context.read<TodoBloc>().add(
            AddTodo(
              Todo(
                pasImage: imageUrl,
                name: _nameController.text,
                age: _ageController.text,
                gender: selectedGender.toString(),
                passportNumber: _passportController.text,
                expiry: _expiryController.text,
                issueingCountry: _countryController.text,
                panNumber: _panController.text,
              ),
            ),
          );
    } else {
      try {
        print(_nameController.text);
        print(_ageController.text);
        print(selectedGender);
        context.read<TodoBloc>().add(
              AddTodo(
                Todo(
                  name: _nameController.text,
                  age: _ageController.text,
                  gender: selectedGender!,
                  passportNumber: '',
                  expiry: '',
                  issueingCountry: '',
                  panNumber: '',
                  pasImage:
                      'https://static.vecteezy.com/system/resources/previews/023/914/428/original/no-document-or-data-found-ui-illustration-design-free-vector.jpg',
                ),
              ),
            );
      } catch (e) {
        print(e);
      }
    }
    context.read<ImgBlocBloc>().add(SaveEvent());
    Navigator.pop(context);
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
