import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsletter/auth/auth_page.dart';
import 'package:newsletter/intoduction_screens/main_intro.dart';
import 'package:newsletter/pages/change_page.dart';
import 'package:newsletter/pages/home_page.dart';
import 'package:newsletter/pages/login_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChangePage();
          } else {
            return AuthPage();
            // return MainIntro();
          }
        },
      ),
    );
  }
}
