import "package:flutter/material.dart";
import 'package:firebase_auth_app/utils/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // <-------------- Email Password - Signup --------------------->

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification(context);
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(context, e.message!);
    }
  }

  // <-------------- Email Password - SignIn/Login --------------------->

  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!_auth.currentUser!.emailVerified) {
        await sendEmailVerification(context);
        // transition to another page instead of home screen
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // <-------------- Email Verification --------------------->

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email Verification sent!');
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
