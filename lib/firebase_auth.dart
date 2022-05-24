// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:guide/Constants/Constants.dart';
import 'package:guide/Controller/Contract_controller.dart';
import 'package:guide/View/HomePage.dart';
import 'package:guide/View/User/UserHomePage.dart';
import 'package:guide/firebase_options.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  SmartContractController contractController =
      Get.put(SmartContractController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Auth'),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return Row(
                children: [
                  user != null
                      ? Container()
                      : FlatButton(
                          onPressed: () {
                            print('register clicked');

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        _RegisterEmailSection()));
                          },
                          textColor: Theme.of(context).buttonColor,
                          child: const Text('Register'),
                        ),
                  FlatButton(
                    child: const Text('Sign out'),
                    textColor: Theme.of(context).buttonColor,
                    onPressed: () async {
                      if (user == null) {
//6
                        Scaffold.of(context).showSnackBar(const SnackBar(
                          content: Text('No one has signed in.'),
                        ));
                        return;
                      }
                      await auth.signOut();
                      final String uid = user!.uid;
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(uid + ' has successfully signed out.'),
                      ));
                    },
                  ),
                ],
              );
            })
          ],
        ),
        body: _EmailPasswordForm());
  }
}

//Form to get email ID and password for login
class _EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool? _success;
  String? _userEmail;

  void _signInWithEmailAndPassword() async {
    final User? user = (await auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
        print(user.email);
      });
      getPrivateKey();
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _signInWithEmailAndPassword();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _success == null
                    ? ''
                    : (_success!
                        ? 'Successfully signed in ' + _userEmail!
                        : 'Sign in failed'),
                style: const TextStyle(color: Colors.red),
              ),
            ),
            user == null
                ? Container()
                : Center(
                    child: RaisedButton(
                      onPressed: getPrivateKey,
                      child: Text('GetPrivateKey'),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

//Form to register a user in Firebase Auth
class _RegisterEmailSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterEmailSectionState();
}

class _RegisterEmailSectionState extends State<_RegisterEmailSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
// ignore: prefer_final_fields
  bool _success = false;
  String? _userEmail;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    final User? user = (await auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
        FirebaseFirestore.instance.collection('users').doc(user.email).set({
          'privateKey': user.uid,
          'email': user.email,
        });
      });
    } else {
      setState(() {
        _success = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Register Email'),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _register();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(_success == null
                      ? ''
                      : _success
                          ? 'Successfully registered ' + _userEmail!
                          : 'Registration failed')),
            ],
          ),
        ),
      ),
    );
  }
}

getPrivateKey() async {
  DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.email)
      .get();

  if (doc.exists) {
    print(" exists docs ");
    print(doc.get("privateKey"));
    privateKey = doc.get("privateKey");

    Get.to(HoemPage());
  }
}
