import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PharmacySignUpPage extends StatefulWidget {
  const PharmacySignUpPage({Key? key}) : super(key: key);

  @override
  _PharmacySignUpPageState createState() => _PharmacySignUpPageState();
}

class _PharmacySignUpPageState extends State<PharmacySignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) =>
                  input!.isEmpty ? 'Please enter the pharmacy name' : null,
              decoration: const InputDecoration(
                labelText: 'Pharmacy Name',
              ),
            ),
            TextFormField(
              validator: (input) =>
                  input!.isEmpty ? 'Please enter the pharmacy number' : null,
              decoration: const InputDecoration(
                labelText: 'Pharmacy Number',
              ),
            ),
            TextFormField(
              validator: (input) =>
                  input!.isEmpty ? 'Please enter your email' : null,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              validator: (input) =>
                  input!.isEmpty ? 'Please enter the address' : null,
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
            ),
            TextFormField(
              validator: (input) =>
                  input!.isEmpty ? 'Please enter the contact number' : null,
              decoration: const InputDecoration(
                labelText: 'Contact Number',
              ),
            ),
            ElevatedButton(
              onPressed: () => signUp(),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Perform signup logic for pharmacy
        // You can access the entered values using _formKey.currentState!.value
        // For example: _formKey.currentState!.value['pharmacyName']
      } catch (e) {
        if (e is FirebaseAuthException) {
          _showErrorDialog(e.message!);
        } else {
          _showErrorDialog('An error occurred');
        }
      }
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
