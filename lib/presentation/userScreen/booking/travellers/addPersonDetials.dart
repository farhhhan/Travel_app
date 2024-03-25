import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/application/bloc/todo_bloc/todo_bloc.dart';
import 'package:travel_app/domain/data/todo.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({required this.isInternational});
  final bool isInternational;

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
    return Scaffold(
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
                                    selectedGender = value;
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
              widget.isInternational
                  ? Card(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter passport number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 160,
                                    child: CustomTextField(
                                      controller: _expiryController,
                                      labelText: 'Expiry',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter expiry date';
                                        }
                                        return null;
                                      },
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
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _addTodo(context);
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
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _addTodo(BuildContext context) {
    if (widget.isInternational) {
      context.read<TodoBloc>().add(
            AddTodo(
              Todo(
                name: _nameController.text,
                age: _ageController.text,
                gender: selectedGender!,
                passportNumber: _passportController.text,
                expiry: _expiryController.text,
                issueingCountry: _countryController.text,
                panNumber: _panController.text,
              ),
            ),
          );
    } else {
      context.read<TodoBloc>().add(
            AddTodo(
              Todo(
                name: _nameController.text,
                age: _ageController.text,
                gender: selectedGender!,
                passportNumber: 'N\A',
                expiry: 'N\A',
                issueingCountry: 'N\A',
                panNumber: 'N\A',
              ),
            ),
          );
    }

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
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
