import 'package:flutter/material.dart';

class UserReqCert extends StatefulWidget {
  const UserReqCert({Key? key}) : super(key: key);

  @override
  _UserReqCertState createState() => _UserReqCertState();
}

class _UserReqCertState extends State<UserReqCert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: const [
          RequestFields(label: 'Name'),
        ],
      )),
    );
  }
}

class RequestFields extends StatelessWidget {
  const RequestFields({
    Key? key,
    required String label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TextField(
          decoration: InputDecoration(labelText: 'label'),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
