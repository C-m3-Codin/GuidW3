import 'package:flutter/material.dart';
import 'package:guide/Model/CertificateModel.dart';
import 'package:guide/View/User/CertificateAccess.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CertificatePage extends StatefulWidget {
  CertificatePage({Key? key, required this.certificates}) : super(key: key);
  Certificates certificates;
  @override
  _CertificatePageState createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  List bools = [true, false, true, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CertificateAccessList(
                    certificates: widget.certificates,
                  ),
                ),
              );
            }),
            icon: const Icon(Icons.folder_shared))
      ]),
      body: ListView(children: [
        CertificateField(data: 'Issuer: ${widget.certificates.data}'),
        CertificateField(
            data: 'Issued against:  ${widget.certificates.issedAgainst}'),
        CertificateField(
            data: 'Date of issue:  ${widget.certificates.dateIssue}'),
        CertificateField(
            data: 'Certificate ID:  ${widget.certificates.certificateId}'),
        CertificateField(
            data: 'Date of Expiry:  ${widget.certificates.dateExpire}'),
        CertificateField(
            data: 'Certificate Type:  ${widget.certificates.certType}'),
        Row(
          children: [
            CertificateField(data: 'isPublic: '),
            ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              activeBgColors: [
                [Colors.green[800]!],
                [Colors.red[800]!]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 1,
              totalSwitches: 2,
              labels: ['True', 'False'],
              radiusStyle: true,
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
            Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.grey,
            )
          ],
        ),
        ExpansionTile(
            title: const Text('Tagged Institutions'),
            trailing: const Icon(Icons.arrow_downward_rounded),
            children: [
              for (var i = 0;
                  i < widget.certificates.taggeInstitutionApproved.length;
                  i++)
                ListTile(
                  title:
                      Text(widget.certificates.taggedInstutions[i].toString()),
                  trailing:
                      widget.certificates.taggeInstitutionApproved == "true"
                          ? const Icon(
                              Icons.verified,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.error,
                              color: Colors.grey,
                            ),
                )
            ])
      ]),
    );
  }
}

class CertificateField extends StatelessWidget {
  final String data;
  const CertificateField({Key? key, required this.data}) : super(key: key);

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
