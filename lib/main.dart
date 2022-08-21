import 'package:firebase_auth_app/screens/anonymous_sign_in.dart';
import 'package:firebase_auth_app/screens/google_signin.dart';
import 'package:firebase_auth_app/screens/login_email_password.dart';
import 'package:firebase_auth_app/screens/phone_login.dart';
import 'package:firebase_auth_app/screens/provider_sign_in.dart';
import 'package:firebase_auth_app/screens/signup_email_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: EmailPasswordSignup(),
      // home: EmailPasswordLogin(),
      // home: PhoneLogin(),
      // home: GoogleSignIn(),
      // home: AnonymousSignIn(),
      home: ProviderSignIn(),
    );
  }
}
