import 'package:firebase_auth_app/screens/home.dart';
import 'package:firebase_auth_app/screens/login_email_password.dart';
import 'package:firebase_auth_app/utils/showOTPDialog.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth_app/utils/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EmailPasswordLogin(),
        ),
      );
    } on FirebaseException catch (e) {
      // if (e.code == 'weak-password') {
      //   print('The password provided is too weak.');
      // } else if (e.code == 'email-already-in-use') {
      //   print('The account already exists for that email.');
      // }
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
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
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

  // <---------------- Google Sign In ----------------------->

  Future<void> googleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credentiall = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credentiall);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );

        // if (userCredential.user != null) {
        //   if (userCredential.additionalUserInfo!.isNewUser) {
        //     // if you want to do specific task like storing information in firestore
        //     // only for new users using google sign in
        //   }
        // }
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // <-------------- Phone Number Sign In --------------------->

  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();

    // FOR ANDROID, IOS
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      //  Automatic handling of the SMS code
      verificationCompleted: (PhoneAuthCredential credential) async {
        // !!! works only on android !!!
        await _auth.signInWithCredential(credential);

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomePage()),
        // );
      },
      verificationFailed: (e) {
        showSnackBar(context, e.message!);
      },
      codeSent: ((String verificationId, int? resendToken) async {
        showOTPDialog(
          codeController: codeController,
          context: context,
          onPressed: () async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: codeController.text.trim(),
            );
            await _auth.signInWithCredential(credential);
            Navigator.of(context).pop(); // Remove the dialog box
          },
        );
      }),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }

  // <----------------- Anonymous Sigi In ----------------------->

  Future<void> anonymousSignIn(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
