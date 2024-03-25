import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/application/bloc/SignUp/bloc/countery_bloc.dart';
import 'package:travel_app/application/bloc/SignUp/bloc/countery_event.dart';
import 'package:travel_app/application/bloc/SignUp/bloc/countery_state.dart';
import 'package:travel_app/presentation/userScreen/auth/signup/mobile/otpScreen.dart';
import 'package:travel_app/presentation/themeData/themeDataColors.dart';

class UserPhoneScreen extends StatefulWidget {
  UserPhoneScreen({Key? key}) : super(key: key);

  @override
  State<UserPhoneScreen> createState() => _UserPhoneScreenState();
}

class _UserPhoneScreenState extends State<UserPhoneScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = '';
  @override
  Widget build(BuildContext context) {
    print('rebuild the tree');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(children: [
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
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Register Number',
                        style:
                            ThemeDataColors.gbowlbyone(colors: Colors.white)),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "Add your phone Number, we'll sent you a",
                  style:   ThemeDataColors.normalText(colors: Colors.grey[300])
                ),
                Text(
                  "verification code",
                  style: ThemeDataColors.normalText(colors: Colors.grey[300])
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<CountryBloc, CountryState>(
                builder: (context, state) {
                  state.controller?.selection = TextSelection.fromPosition(
                    TextPosition(offset: state.controller!.text.length),
                  );
                  print('rebuild state');
                  final selectedCountry = state.country;
                  return Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          BlocProvider.of<CountryBloc>(context)
                              .add(TextValueChangedEvent(value: value));
                        },
                        controller: state.controller,
                        cursorColor: Colors.purple,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            padding: EdgeInsets.all(15),
                            child: InkWell(
                              onTap: () {
                                showCountryPicker(
                                  countryListTheme: CountryListThemeData(
                                    bottomSheetHeight: 500,
                                  ),
                                  context: context,
                                  onSelect: (value) {
                                    BlocProvider.of<CountryBloc>(context).add(
                                      SelectCountryEvent(country: value),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                '${selectedCountry!.flagEmoji} +${selectedCountry.phoneCode}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          suffixIcon: state.controller!.text.length == 10
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    child: Center(
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : null,
                          hintText: 'Enter Your Number',
                          hintStyle: TextStyle(fontWeight: FontWeight.w500),
                          fillColor: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      InkWell(
                        onTap: () async {
                          print(
                              '+${state.country!.phoneCode}${state.controller!.text}');
                          try {
                            await _auth.verifyPhoneNumber(
                              timeout: Duration(seconds: 60),
                              phoneNumber:
                                  '+${state.country!.phoneCode}${state.controller!.text}',
                              verificationCompleted:
                                  (PhoneAuthCredential credential) async {
                                await _auth.signInWithCredential(credential);
                                // Navigate to next screen upon successful verification
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtpScreen(
                                        verificationId: verificationId),
                                  ),
                                );
                              },
                              verificationFailed: (FirebaseAuthException e) {
                                print('Verification Failed: ${e.message}');
                              },
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                // Save the verification ID for later use
                                this.verificationId = verificationId;
                                // Navigate to the OTP screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtpScreen(
                                      verificationId: verificationId,
                                    ),
                                  ),
                                );
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {
                                // Handle timeout
                              },
                            );
                          } catch (e) {
                            print('Error verifying phone number: $e');
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.75,
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
