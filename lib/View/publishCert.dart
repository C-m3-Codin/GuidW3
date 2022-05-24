import 'package:flutter/material.dart';
import 'package:guide/firebase_auth.dart';
import 'package:guide/firestore_functions.dart';

class PublishCertificate extends StatefulWidget {
  const PublishCertificate({Key? key}) : super(key: key);

  @override
  _PublishCertificateState createState() => _PublishCertificateState();
}

class _PublishCertificateState extends State<PublishCertificate> {
  final GlobalKey<FormState> _publishCertFormKey = GlobalKey<FormState>();
  final TextEditingController _certificateIDController =
      TextEditingController();
  final TextEditingController _issuedAgainstController =
      TextEditingController();
  final TextEditingController _certTypeController = TextEditingController();
  final TextEditingController _dateIssueController = TextEditingController();
  final TextEditingController _dateExpiryController = TextEditingController();
  final TextEditingController _certificateDataController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPublic = false;
  String _issuedAgainstPublicKey = 'the key of the recepient here';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Publish Certificate')),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _publishCertFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              publishFormField(_certificateIDController, 'Certificate ID'),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[800],
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  title: Text(auth.currentUser != null
                      ? auth.currentUser!.email!
                      : 'currently signed in user'),
                  subtitle: Text(auth.currentUser != null
                      ? getPublicKeyFromEmail(auth.currentUser!.email!)
                      : 'public key of current user'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[800],
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          _issuedAgainstPublicKey = getPublicKeyFromEmail(
                              _issuedAgainstController.text);
                        });
                      },
                      icon: Icon(Icons.check)),
                  title: TextFormField(
                    controller: _issuedAgainstController,
                    decoration: InputDecoration(
                        labelText: 'issued against', border: InputBorder.none),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                  subtitle: Text(auth.currentUser != null
                      ? auth.currentUser!.email!
                      : 'currently signed in user'),
                ),
              ),
              publishFormField(_certTypeController, 'Certificate Type'),
              publishFormField(_dateIssueController, 'Date of Issue'),
              publishFormField(_dateExpiryController, 'Date of Expiry'),
              publishFormField(_certificateDataController, 'DATA'),
              _isPublicRadio()
            ],
          ),
        ),
      ),
    );
  }

  Container _isPublicRadio() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[800],
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Flexible(
              child: ListTile(
            title: Text('Public'),
            leading: Radio(
                value: true,
                groupValue: _isPublic,
                onChanged: (bool? value) {
                  setState(() {
                    _isPublic = value!;
                  });
                }),
          )),
          Flexible(
              child: ListTile(
            title: Text('Private'),
            leading: Radio(
                value: false,
                groupValue: _isPublic,
                onChanged: (bool? value) {
                  setState(() {
                    _isPublic = value!;
                  });
                }),
          ))
        ],
      ),
    );
  }

  Container publishFormField(
      TextEditingController _editingController, String? label) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[800],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: _editingController,
        decoration: InputDecoration(labelText: label, border: InputBorder.none),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Required';
          }
          return null;
        },
      ),
    );
  }
}
