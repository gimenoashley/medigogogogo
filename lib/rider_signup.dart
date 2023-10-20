import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RiderSignUpScreen extends StatefulWidget {
  @override
  _RiderSignUpScreenState createState() => _RiderSignUpScreenState();
}

class _RiderSignUpScreenState extends State<RiderSignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String _email;
  late String _name;
  late String _address;
  late String _contactNumber;
  late String _driverLicense;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: '', // No password required
        );

        await FirebaseFirestore.instance
            .collection('riders')
            .doc(userCredential.user!.uid)
            .set({
          'name': _name,
          'email': _email,
          'address': _address,
          'contactNumber': _contactNumber,
          'driverLicense': _driverLicense,
        });

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return RiderHomeScreen();
            },
          ),
        );
      } catch (e) {
        print("Error during registration: $e");
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty || !value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  String? _validateContactNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your contact number';
    }
    return null;
  }

  String? _validateDriverLicense(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your driver license';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rider Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: _validateName,
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: _validateAddress,
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                validator: _validateContactNumber,
                onSaved: (value) {
                  _contactNumber = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Driver License'),
                validator: _validateDriverLicense,
                onSaved: (value) {
                  _driverLicense = value!;
                },
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RiderHomeScreen extends StatelessWidget {
  const RiderHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rider Home'),
      ),
      body: Center(
        child: Text('Welcome to the Rider Home Screen!'),
      ),
    );
  }
}
