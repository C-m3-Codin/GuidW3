import 'package:flutter/material.dart';

class InstitutionProfilePage extends StatefulWidget {
  const InstitutionProfilePage({Key? key}) : super(key: key);

  @override
  _InstitutionProfilePageState createState() => _InstitutionProfilePageState();
}

class _InstitutionProfilePageState extends State<InstitutionProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Institution Profile')),
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            InstProfileField(data: 'Verification status: '),
            InstProfileField(data: ' Institution type: '),
            InstProfileField(data: 'Main institution: '),
            InstProfileField(data: 'typeInt: '),
            InstProfileField(data: 'Verifier: '),
          ],
        ));
  }
}

class InstProfileField extends StatelessWidget {
  final String data;
  const InstProfileField({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[100],
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        data,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
