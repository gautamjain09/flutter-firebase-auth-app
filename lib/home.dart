import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/services/firebase_auth_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOutUser() {
    FirebaseAuthMethods(FirebaseAuth.instance).signOutt(context);
  }

  void deleteUser() {
    FirebaseAuthMethods(FirebaseAuth.instance).deleteAccount(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuthMethods(FirebaseAuth.instance).user;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (user.isAnonymous)
            const Center(child: (Text("Anaonymous User")))
          else if (user.phoneNumber != null)
            Center(child: (Text("Phone Number : " + user.phoneNumber!)))
          else if (user.email != null)
            Center(child: (Text("Email Id : " + user.email!)))
          else if (user.providerData[0].providerId != null)
            Center(
                child: (Text("Email Id : " + user.providerData[0].providerId))),
          const SizedBox(height: 10),
          Center(child: Text("UID : " + user.uid)),
          const SizedBox(height: 10),

          // Sign Out for Firebase Email/Password Authentication
          ElevatedButton(
            onPressed: signOutUser,
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
              "Sign Out",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          // Delete Account for Email/password Firebase Auth
          ElevatedButton(
            onPressed: deleteUser,
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
              "Delete Account",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
