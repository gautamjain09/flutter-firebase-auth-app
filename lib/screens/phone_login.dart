import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/services/firebase_auth_methods.dart';
import 'package:firebase_auth_app/utils/custom_textfield.dart';
import 'package:flutter/material.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final TextEditingController phoneController = TextEditingController();

  void phoneSignIn() {
    FirebaseAuthMethods(FirebaseAuth.instance).phoneSignIn(
      context,
      phoneController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: CustomTextField(
                controller: phoneController,
                hintText: 'Enter phone number',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              phoneSignIn();
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 45),
              ),
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
