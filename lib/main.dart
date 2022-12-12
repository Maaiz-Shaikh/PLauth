import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:passwordless_auth/screens/login_screen.dart';
import 'firebase_options.dart';
import 'screens/email_auth/data/services/auth/auth_service.dart';
import 'screens/email_auth/data/services/auth/sp_service.dart';
import 'screens/email_auth/data/utils/app_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppLoader.init();
  await SPService.init();
  Get.put(AuthService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.black),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(),
      ),
      routes: {
        '/': (context) => const LoginScreen(),
      },
      builder: EasyLoading.init(),
    );
  }
}
