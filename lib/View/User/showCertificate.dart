import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:guide/Controller/Contract_controller.dart';
import 'package:guide/Model/CertificateModel.dart';
import 'package:guide/View/User/listCertificateAccess.dart';
import 'package:guide/View/viewInstaProfile.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CertificatePage extends StatefulWidget {
  CertificatePage({Key? key, required this.certificates}) : super(key: key);
  Certificates certificates;
  @override
  _CertificatePageState createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  SmartContractController contractController =
      Get.find<SmartContractController>();
  // List bools = [true, false, true, false];
  @override
  Widget build(BuildContext context) {
    List<String> certificatetype = ["Government", "Medical", "Education"];

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
            data:
                'Certificate Type:  ${certificatetype[widget.certificates.certType.toInt() % 3]}'),
        Row(
          children: [
            CertificateField(data: 'isPublic: '),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: widget.certificates.isPublic
                        ? Colors.green
                        : Colors.red),
                onPressed: () {
                  contractController
                      .toggleIsPublic(widget.certificates.certificateId);
                  widget.certificates.isPublic = !widget.certificates.isPublic;
                  setState(() {});
                },
                child: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                ))
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
                  onTap: () {
                    Get.to(ViewInstProfule(
                        address: widget.certificates.taggedInstutions[i]));
                  },
                  title:
                      Text(widget.certificates.taggedInstutions[i].toString()),
                  trailing:
                      widget.certificates.taggeInstitutionApproved[i] == true
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
