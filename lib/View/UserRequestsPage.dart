import 'package:flutter/material.dart';

class UserRequestsPage extends StatefulWidget {
  const UserRequestsPage({Key? key}) : super(key: key);

  @override
  _UserRequestsPageState createState() => _UserRequestsPageState();
}

class RequestList {
  String certName = 'initial';
  String certID = 'id initial';

  RequestList(String certName, String certID) {
    this.certID = certID;
    this.certName = certName;
    print(certID + certName);
    print(certID);
  }
}

class _UserRequestsPageState extends State<UserRequestsPage> {
  List<RequestList> items = [];
  @override
  void initState() {
    super.initState();
    items = [
      RequestList('DRIVING LICENSE', 'XX 123 ABC 12AB'),
      RequestList('DRIVING LICENSE', 'XX 123 ABC 12AB'),
      RequestList('DRIVING LICENSE', 'XX 123 ABC 12AB'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const ListTile(
            title: Text('NAME HERE'),
            subtitle: Text('XX XX XXXX XXXX'),
          ),
          actions: const [
            TextButton(
              child: Text('REQUESTS'),
              onPressed: null,
            ),
            TextButton(
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
