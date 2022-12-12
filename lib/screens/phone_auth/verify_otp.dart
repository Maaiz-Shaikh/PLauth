import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordless_auth/screens/home_screen.dart';
import 'package:passwordless_auth/screens/loading_screen.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verificationId;
  const VerifyOtpScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String otpController = '';
  bool isLoading = false;

  void verifyOTP() async {
    String otp = otpController.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        setState(() {
          isLoading = false;
        });
        if (!mounted) return;
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException {
      showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) => CupertinoAlertDialog(
              title: const Text('Invalid OTP'),
              content: const Text('please Re-Enter OTP'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Verify OTP"),
              leading: Builder(
                builder: (context) {
                  return IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_sharp));
                },
              ),
            ),
            body: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/login.png',
                        width: 300,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Verification code',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      const Text(
                        'We have sent the code verification to Your Mobile Number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Pinput(
                          length: 6,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onCompleted: (pin) async {
                            setState(() {
                              otpController = pin;
                            });
                            verifyOTP();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}



// appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Verify OTP"),
//       ),
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: otpController,
//                     maxLength: 6,
//                     decoration: const InputDecoration(
//                         labelText: "6-Digit OTP", counterText: ""),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   CupertinoButton(
//                     onPressed: () {
//                       verifyOTP();
//                     },
//                     color: Colors.blue,
//                     child: const Text("Verify"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),