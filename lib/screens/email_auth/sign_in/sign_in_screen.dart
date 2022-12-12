import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignInController>(
        init: SignInController(),
        builder: (controller) {
          return Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      focusNode: controller.focusNode,
                      controller: controller.emailTEC,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'e.g xyz.abc@mail.com',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: controller.signInWithEmailLink,
                      minWidth: double.infinity,
                      height: 45.0,
                      color: const Color(0xff0abb91),
                      splashColor: const Color.fromARGB(255, 14, 248, 194),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
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
