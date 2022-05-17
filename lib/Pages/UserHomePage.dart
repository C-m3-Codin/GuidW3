import 'package:flutter/material.dart';
import 'package:guide/Pages/UserRequestsPage.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class CertificateList {
  String certName = 'initial';
  String certID = 'id initial';

  CertificateList(String certName, String certID) {
    this.certID = certID;
    this.certName = certName;
    print(certID + certName);
    print(certID);
  }
}

class _UserHomePageState extends State<UserHomePage> {
  List<CertificateList> items = [];
  @override
  void initState() {
    super.initState();
    items = [
      CertificateList('DRIVING LICENSE', 'XX 123 ABC 12AB'),
      CertificateList('DRIVING LICENSE', 'XX 123 ABC 12AB'),
      CertificateList('DRIVING LICENSE', 'XX 123 ABC 12AB'),
      CertificateList('DRIVING LICENSE', 'XX 123 ABC 12AB'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const ListTile(
            title: Text('NAME HERE'),
            subtitle: Text('XX XX XXXX XXXX'),
          ),
          actions: [
            TextButton(
              child: const Text('REQUESTS'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserRequestsPage()));
              },
            ),
            const TextButton(
              child: Text('REQUEST A CERTIFICATE'),
              onPressed: null,
            )
          ],
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index].certName),
              subtitle: Text(items[index].certID),
              onTap: () {},
            );
          },
        ));
  }
}
