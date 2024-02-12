import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:travel_app/SignUp/bloc/country_bloc.dart';
import 'package:travel_app/SignUp/bloc/country_event.dart';
import 'package:travel_app/SignUp/bloc/country_state.dart';

class UserSignUpScreen extends StatelessWidget {
  UserSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild the tree');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'Register',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Add your phone Number, we'll sent you a",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "verification  code",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<CountryBloc, CountryState>(
              builder: (context, state) {
                print('rebuild state');
                final selectedCountry = state.country;
                return TextFormField(
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    // suffixIcon: ,
                    prefixIcon: Container(
                      padding: EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                            countryListTheme:
                                CountryListThemeData(bottomSheetHeight: 500),
                            context: context,
                            onSelect: (value) {
                              CountryBloc _countryBloc =
                                  BlocProvider.of<CountryBloc>(context);
                              print(state.country);
                              _countryBloc.add(
                                SelectCountryEvent(country: value),
                              );
                            },
                          );
                        },
                        child: Text(
                            '${selectedCountry.flagEmoji}+${selectedCountry.phoneCode}'),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Enter Your Number',
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
