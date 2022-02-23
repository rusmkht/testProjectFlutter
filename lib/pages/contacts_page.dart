import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_1/data/contacts.dart';


class Contacts_page extends StatefulWidget {
  @override
  _Contacts_pageState createState() => _Contacts_pageState();
}

class _Contacts_pageState extends State<Contacts_page> {
  var colorBack = const Color(0xff01062B);
  var colorMain = const Color(0xff29046E);

  late Future<ContactList> contactList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactList = getContactList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBack,
      appBar: AppBar(
        title: Text(
          "Contacts",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorMain,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 5),
        child: FutureBuilder<ContactList>(
          future: contactList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  addAutomaticKeepAlives: false,
                  itemCount: snapshot.data!.contacts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "${snapshot.data!.contacts[index].name}",
                        style: TextStyle(fontSize: 18),
                      ),
                      leading: Icon(
                        Icons.person,
                        size: 32,
                        color: Colors.white60,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/contactUserPage',
                            arguments: snapshot.data!.contacts[index]);
                      },
                    );
                  });
            } else if (snapshot.hasError) {
              print("${snapshot.error}");
              return Text("Error");
            } else {
              return Center(
                  child: Text(
                "Loading...",
                style: TextStyle(fontSize: 18),
              ));
            }
          },
        ),
      ),
    );
  }
}

class ContactUserPage extends StatefulWidget {
  const ContactUserPage({Key? key}) : super(key: key);

  @override
  State<ContactUserPage> createState() => _ContactUserPageState();
}

class _ContactUserPageState extends State<ContactUserPage> {
  var colorBack = const Color(0xff01062B);
  var colorMain = const Color(0xff29046E);

  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  final _addressController = TextEditingController();
  final _websiteController = TextEditingController();
  final _zipcodeController = TextEditingController();

  @override
  void dispose() {
    _zipcodeController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _addressController.dispose();
    _websiteController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    Contact userData = settings.arguments as Contact;
    _emailController.text = "${userData.email}";
    _phoneController.text = "${userData.phone}";
    _websiteController.text = "${userData.website}";
    _addressController.text =
        "${userData.address.city},${userData.address.street},${userData.address.suite}";
    _companyController.text =
        "${userData.company.name}, ${userData.company.catchPhrase}, ${userData.company.bs}";
    _zipcodeController.text = "${userData.address.zipcode}";
    return Scaffold(
        backgroundColor: colorBack,
        appBar: AppBar(
          title: Text(
            "${userData.username}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
          backgroundColor: colorMain,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white30),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            Center(
                child: Text(
              "${userData.name}",
              style: TextStyle(fontSize: 20),
            )),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "id: ${userData.id}",
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.all(16.0),
                children: [
                  TextField(
                    controller: _emailController,
                    enabled: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle:
                          TextStyle(color: Colors.white54, fontSize: 18),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    controller: _phoneController,
                    enabled: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                      labelStyle:
                          TextStyle(color: Colors.white54, fontSize: 18),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    controller: _websiteController,
                    enabled: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Website',
                      labelStyle:
                          TextStyle(color: Colors.white54, fontSize: 18),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    controller: _addressController,
                    enabled: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle:
                          TextStyle(color: Colors.white54, fontSize: 18),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    controller: _zipcodeController,
                    enabled: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Zip Code',
                      labelStyle:
                          TextStyle(color: Colors.white54, fontSize: 18),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    maxLines: 3,
                    controller: _companyController,
                    enabled: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Company',
                      labelStyle:
                          TextStyle(color: Colors.white54, fontSize: 18),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                ],
              ),
            ),

          ]),
        ));
  }
}
