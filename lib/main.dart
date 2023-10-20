// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medi_go/customer_login.dart';
import 'package:medi_go/customer_sign_up.dart';
import 'package:medi_go/pharmacy_signup.dart';
import 'package:medi_go/pharmacy_login.dart';
import 'package:medi_go/rider_signup.dart';
import 'package:medi_go/riderlogin.dart';

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
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SignUpScreen(),
        '/rider_signup': (context) => RiderSignUpScreen(),
        '/customer_login': (context) => LoginPage(),
        '/rider_login': (context) => RiderLoginPage(),
        '/pharmacy_signup': (context) => PharmacySignUpPage(),
        '/pharmacy_login': (context) => PharmacyLoginPage(),
      },
    );
  }
}
