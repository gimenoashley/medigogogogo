import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PharmacyLoginPage extends StatefulWidget {
  const PharmacyLoginPage({Key? key}) : super(key: key);

  @override
  _PharmacyLoginPageState createState() => _PharmacyLoginPageState();
}

class _PharmacyLoginPageState extends State<PharmacyLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pharmacyNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _pharmacyNumberController,
              validator: (input) =>
                  input!.isEmpty ? 'Please enter the pharmacy number' : null,
              decoration: const InputDecoration(
                labelText: 'Pharmacy Number',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              validator: (input) =>
                  input!.isEmpty ? 'Please enter the password' : null,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: () => login(),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _pharmacyNumberController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Login successful, navigate to the next screen
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
