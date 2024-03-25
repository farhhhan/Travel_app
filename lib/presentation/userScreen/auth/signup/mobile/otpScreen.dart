import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:travel_app/presentation/themeData/themeDataColors.dart';
import 'package:travel_app/presentation/userScreen/auth/signup/userRegister.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.verificationId});
  String verificationId;
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Colors.white;
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        height: 50,
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                child: Center(
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: 50,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify Your Number',
                style:  ThemeDataColors.gbowlbyone(colors: Colors.white)
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We sent to OTP code in Number",
                style: ThemeDataColors.roboto(fontsize: 18)
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ],
      ),
      Text(
        "Enter your code",
        style: ThemeDataColors.roboto(fontsize: 18)
      ),
      SizedBox(height: 40,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Directionality(
                    // Specify direction if desired
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      length: 6,
                      controller: pinController,
                      focusNode: focusNode,
                      animationCurve: Curves.bounceIn,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      listenForMultipleSmsOnAndroid: true,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 5),
                      validator: (value) {
                        return (value!.length == 6) ? null : 'Pin is incorrect';
                      },
                      onClipboardFound: (value) {
                        debugPrint('onClipboardFound: $value');
                        pinController.setText(value);
                      },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                      },
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(19),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () async {
                      focusNode.unfocus();
                      formKey.currentState!.validate();
                      try {
                        FirebaseAuth.instance.getRedirectResult();
                      
                        PhoneAuthCredential credential =
                            await PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: pinController.text.toString());
                        FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserRegister(number:    FirebaseAuth.instance.currentUser!.phoneNumber.toString(),isUser: true,)));
                        });
                      } catch (ex) {
                        print(ex.toString());
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Login",
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
              )),
        ],
      )
    ]));
  }
}
