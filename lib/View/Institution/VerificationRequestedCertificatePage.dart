import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:guide/Controller/Contract_controller.dart';
import 'package:guide/Model/CertificateModel.dart';
import 'package:guide/View/User/listCertificateAccess.dart';
import 'package:guide/View/viewInstaProfile.dart';
import 'package:lottie/lottie.dart';
import 'package:web3dart/web3dart.dart';

class InstitutionCertificatePage extends StatefulWidget {
  InstitutionCertificatePage({Key? key, required this.certificates})
      : super(key: key);
  Certificates certificates;
  @override
  _InstitutionCertificatePageState createState() =>
      _InstitutionCertificatePageState();
}

class _InstitutionCertificatePageState
    extends State<InstitutionCertificatePage> {
  SmartContractController contractController =
      Get.find<SmartContractController>();
  List bools = [true, false, true, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            contractController.approveCertificate(
                contractController.userAddress.value ??
                    EthereumAddress.fromHex("0x"),
                widget.certificates.certificateId);
            Get.back();
          },
          child: Icon(Icons.verified, color: Colors.white)),
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
      body: dataOfCertificate(),
    );
  }

  ListView dataOfCertificate() {
    List<String> certificatetype = ["Government", "Medical", "Education"];

    return ListView(children: [
      Lottie.network(
          'https://assets7.lottiefiles.com/packages/lf20_tbwqrxnz.json'),
      widget.certificates.certType.toInt() == 1
          ? medicalData()
          : CertificateField(data: 'data: ${widget.certificates.data}'),
      GestureDetector(
          onTap: () {
            Get.to(ViewInstProfule(address: widget.certificates.issuer));
          },
          child:
              CertificateField(data: 'issuer: ${widget.certificates.issuer}')),
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
                  primary:
                      widget.certificates.isPublic ? Colors.green : Colors.red),
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
                title: Text(widget.certificates.taggedInstutions[i].toString()),
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
    ]);
  }

  ExpansionTile medicalData() {
    final body = json.decode(widget.certificates.data);
    return ExpansionTile(
        title: const Text('Medical Data'),
        trailing: const Icon(Icons.arrow_downward_rounded),
        children: [
          ListTile(
            title: Text("name : ${body["patientName"]}"),
          ),
          ListTile(
            title: Text("name : ${body["analysis"]}"),
          ),
          ListTile(
            title: Text("name : ${body["prescribtion"]}"),
          ),
          ListTile(
            title: Text("name : ${body["Comments"]}"),
          )
        ]);
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
