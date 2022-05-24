import 'package:flutter/material.dart';
import 'package:guide/Model/CertificateModel.dart';

class CertificateAccessList extends StatefulWidget {
  CertificateAccessList({Key? key, required this.certificates})
      : super(key: key);

  Certificates certificates;

  @override
  _CertificateAccessListState createState() => _CertificateAccessListState();
}

class _CertificateAccessListState extends State<CertificateAccessList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sharing'),
        ),
        body: ListView.builder(
          itemCount: widget.certificates.accessGranted.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(widget.certificates.accessGranted[index].toString()),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: TextField(),
                    actions: [
                      TextButton(
                          onPressed: (() {
                            Navigator.pop(context);
                          }),
                          child: Text('CANCEL')),
                      TextButton(onPressed: () {}, child: Text('ADD')),
                    ],
                  );
                });
          },
          child: Icon(Icons.person_add),
        ));
  }
}
