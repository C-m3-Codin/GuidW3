import 'package:flutter/material.dart';
import 'package:guide/firebase_auth.dart';
import 'package:guide/firestore_functions.dart';
import 'package:intl/intl.dart';
import 'package:web3dart/credentials.dart';

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
  final TextEditingController _certificateDataController =
      TextEditingController();
  final TextEditingController _newTagInstController = TextEditingController();

  bool _isPublic = false;
  String _issuedAgainstPublicKey = 'the key of the recepient here';
  DateTime? _dateIssue = DateTime.now();
  DateTime? _dateExpiry = DateTime.now().add(const Duration(days: 365));
  List<EthereumAddress> _taggedInstitutions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Publish Certificate')),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _publishCertFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // publishFormField(_certificateIDController, 'Certificate ID'),
                issuerField(),
                issuedAgainstField(),
                publishFormField(_certTypeController, 'Certificate Type'),
                certIssueDate(context),
                certExpiry(context),
                publishFormField(_certificateDataController, 'DATA'),
                _isPublicRadio(),
                _tagInstitutions(context),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('PUBLISH'))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _tagInstitutions(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[800],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
          initiallyExpanded: true,
          title: const Text('Tag Institutions'),
          trailing: IconButton(
            icon: const Icon(Icons.add_business),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: TextFormField(
                        controller: _newTagInstController,
                        decoration: const InputDecoration(
                          labelText: 'ID of institution',
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: (() {
                              Navigator.pop(context);
                            }),
                            child: Text('CANCEL')),
                        TextButton(
                            onPressed: () {
                              print(_newTagInstController.text);
                              setState(() {
                                _taggedInstitutions.add(EthereumAddress.fromHex(
                                    _newTagInstController.text.toString()));
                              });
                              _newTagInstController.clear();
                              Navigator.pop(context);
                            },
                            child: const Text('ADD')),
                      ],
                    );
                  });
            },
          ),
          children: _taggedInstitutions
              .map((e) => ListTile(
                    title: Text(e),
                  ))
              .toList()),
    );
  }

  Container certIssueDate(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[800],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        title: Text(
          DateFormat('dd/MM/yyyy').format(_dateIssue!),
        ),
        subtitle: const Text('Date of Issue'),
        trailing: const Icon(Icons.date_range_sharp),
        onTap: (() {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2023))
              .then((_pickedDate) {
            setState(() {
              _dateIssue = _pickedDate;
            });
          });
        }),
      ),
    );
  }

  Container certExpiry(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[800],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        title: Text(
          DateFormat('dd/MM/yyyy').format(_dateExpiry!),
        ),
        subtitle: const Text('Date of Expiry'),
        trailing: const Icon(Icons.date_range_sharp),
        onTap: (() {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2023))
              .then((_pickedDate) {
            setState(() {
              _dateExpiry = _pickedDate;
            });
          });
        }),
      ),
    );
  }

  Container issuedAgainstField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[800],
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        trailing: IconButton(
            onPressed: () async {
              print(await getPublicKeyFromEmail('cyril199897@gmail.com'));
              getPublicKeyFromEmail(_issuedAgainstController.text).then((key) {
                setState(() {
                  _issuedAgainstPublicKey = key;
                });
              });
            },
            icon: Icon(Icons.check)),
        title: TextFormField(
          controller: _issuedAgainstController,
          decoration: const InputDecoration(
              labelText: 'issued against', border: InputBorder.none),
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        subtitle: Text(_issuedAgainstPublicKey),
      ),
    );
  }

  Container issuerField() {
    return Container(
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
        // subtitle: Text(auth.currentUser != null
        //     ? getPublicKeyFromEmail(auth.currentUser!.email!)
        //     : 'public key of current user'),
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
