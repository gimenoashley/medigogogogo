import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RiderLoginPage extends StatefulWidget {
  const RiderLoginPage({Key? key}) : super(key: key);

  @override
  _RiderLoginPageState createState() => _RiderLoginPageState();
}

class _RiderLoginPageState extends State<RiderLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
    _email = '';
    _password = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rider Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) =>
                  input!.isEmpty ? 'Please enter your email' : null,
              onSaved: (input) => _email = input!,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              validator: (input) => input!.length < 6
                  ? 'Your password must be at least 6 characters'
                  : null,
              onSaved: (input) => _password = input!,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => signIn(),
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        // Perform additional actions specific to the rider login
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
