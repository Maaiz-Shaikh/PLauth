import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordless_auth/screens/loading_screen.dart';
import 'package:passwordless_auth/screens/phone_auth/verify_otp.dart';

class SignInWithPhone extends StatefulWidget {
  const SignInWithPhone({Key? key}) : super(key: key);

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  TextEditingController phoneController = TextEditingController();
  String countryCodeController = '+91';
  bool isLoading = false;
  // var controller;

  void sendOTP() async {
    String phone = "$countryCodeController${phoneController.text.trim()}";

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, resendToken) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => VerifyOtpScreen(
                        verificationId: verificationId,
                      )));
        },
        verificationCompleted: (credential) {},
        verificationFailed: (ex) {
          showCupertinoDialog(
            barrierDismissible: false,
            context: context,
            builder: ((context) => CupertinoAlertDialog(
                  title: const Text('Invalid Phone Number'),
                  content: const Text('please Retry.'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: const Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    Widget inputFieldWidget() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            child: TextButton(
              child: Text(
                countryCodeController,
                style: const TextStyle(fontSize: 17, color: Colors.white),
              ),
              onPressed: () {
                showCountryPicker(
                    countryListTheme: const CountryListThemeData(
                      flagSize: 25,
                      backgroundColor: Color.fromARGB(240, 29, 29, 29),
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      bottomSheetHeight: 550,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    context: context,
                    onSelect: (Country value) {
                      setState(() {
                        countryCodeController =
                            '+${value.phoneCode.toString()}';
                      });
                    });
              },
            ),
          ),
          const Text(
            '|',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              color: Color(0xff6b6b6b),
            ),
          ),
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 17),
              controller: phoneController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Phone',
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              ),
            ),
          )
        ],
      );
    }

    Widget requestOtpButton() {
      return MaterialButton(
          minWidth: double.infinity,
          height: 45.0,
          onPressed: () async {
            setState(() => isLoading = true);
            sendOTP();
            await Future.delayed(const Duration(seconds: 10));
            setState(() => isLoading = false);
          },
          color: const Color(0xFF0abb91),
          splashColor: const Color.fromARGB(255, 14, 248, 194),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: const Text(
            "Request OTP",
            style: TextStyle(color: Colors.white),
          ));
    }

    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 18),
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1d1d1d),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xffffefef),
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: inputFieldWidget(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: requestOtpButton(),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
