import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:travel_app/presentation/themeData/themeDataColors.dart';
import 'package:travel_app/presentation/userScreen/auth/signup/userRegister.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key, required this.verificationId}) : super(key: key);
  final String verificationId;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with CodeAutoFill {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    cancel();
    super.dispose();
  }

  @override
  void codeUpdated() {
    setState(() {
      pinController.text = code!;
    });
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Colors.white;
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const CircleAvatar(
                              child: Center(
                                child: Icon(Icons.arrow_back),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          // Wrap the Column in Expanded
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Verify Your Number',
                                style: ThemeDataColors.gbowlbyone(
                                    colors: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "We sent an OTP code to your number",
                                style: ThemeDataColors.roboto(fontsize: 18),
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Enter your code",
                      style: ThemeDataColors.roboto(fontsize: 18),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: PinFieldAutoFill(
                                    controller: pinController,
                                    focusNode: focusNode,
                                    codeLength: 6,
                                    decoration: UnderlineDecoration(
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                      colorBuilder:
                                          FixedColorBuilder(Colors.white),
                                    ),
                                    currentCode: pinController.text,
                                    onCodeSubmitted: (code) {
                                      print("Code submitted: $code");
                                    },
                                    onCodeChanged: (code) {
                                      if (code!.length == 6) {
                                        formKey.currentState!.validate();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: constraints.maxHeight * 0.05),
                              InkWell(
                                onTap: () async {
                                  focusNode.unfocus();
                                  if (formKey.currentState!.validate()) {
                                    try {
                                      FirebaseAuth.instance.getRedirectResult();

                                      PhoneAuthCredential credential =
                                          PhoneAuthProvider.credential(
                                              verificationId:
                                                  widget.verificationId,
                                              smsCode: pinController.text);
                                      await FirebaseAuth.instance
                                          .signInWithCredential(credential)
                                          .then((value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UserRegister(
                                              number: FirebaseAuth.instance
                                                  .currentUser!.phoneNumber
                                                  .toString(),
                                              isUser: true,
                                            ),
                                          ),
                                        );
                                      });
                                    } catch (ex) {
                                      print(ex.toString());
                                    }
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                  ),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
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
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
