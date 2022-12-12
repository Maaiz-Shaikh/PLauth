import 'package:flutter/material.dart';
import 'package:passwordless_auth/screens/email_auth/sign_in/sign_in_screen.dart';
import 'package:passwordless_auth/screens/phone_auth/signin_with_phone.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Text('Login',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  height: 45,
                  decoration: BoxDecoration(
                      color: const Color(0xFF1d1d1d),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TabBar(
                      indicator: BoxDecoration(
                          color: const Color(0xFF0abb91),
                          borderRadius: BorderRadius.circular(25.0)),
                      tabs: const [
                        Tab(
                          text: '📞 Phone Number',
                        ),
                        Tab(
                          text: '📩 Email',
                        )
                      ]),
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: SignInWithPhone(),
                    ),
                    Center(
                      child: SignInScreen(),
                    )
                  ],
                ),
              ),
              if (!isKeyboard) buildImageWidget(screenHeight),
              if (!isKeyboard) buildWaveWidget(screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageWidget(double screenHeight) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Image.asset(
        'assets/images/login.png',
        width: screenHeight / 2,
      ),
    );
  }

  Widget buildWaveWidget(double screenHeight) {
    return WaveWidget(
      config: CustomConfig(
        colors: [
          const Color.fromARGB(179, 223, 40, 255),
          const Color.fromARGB(200, 10, 187, 146),
          const Color.fromARGB(200, 124, 77, 255),
        ],
        durations: [
          20000,
          10000,
          15000,
        ],
        heightPercentages: [
          0.02,
          0.05,
          0.02,
        ],
      ),
      size: Size(double.infinity, screenHeight / 12),
      waveAmplitude: 40,
    );
  }
}
