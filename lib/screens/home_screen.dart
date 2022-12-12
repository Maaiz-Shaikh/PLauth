import 'package:flutter/material.dart';
import 'package:passwordless_auth/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RM-Auth'),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false),
                icon: const Icon(Icons.arrow_back_sharp));
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/login.png',
              width: 300,
            ),
            const SizedBox(
              height: 60,
            ),
            const Text('RM-Auth')
          ],
        ),
      ),
    );
  }
}
