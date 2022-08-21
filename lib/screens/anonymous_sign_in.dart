import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/services/firebase_auth_methods.dart';
import "package:flutter/material.dart";

class AnonymousSignIn extends StatefulWidget {
  AnonymousSignIn({Key? key}) : super(key: key);

  @override
  State<AnonymousSignIn> createState() => _AnonymousSignInState();
}

class _AnonymousSignInState extends State<AnonymousSignIn> {
  void anonymousSignInUser() {
    FirebaseAuthMethods(FirebaseAuth.instance).anonymousSignIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Anonymous Sign In",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: anonymousSignInUser,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.white),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width / 2, 45),
                ),
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
