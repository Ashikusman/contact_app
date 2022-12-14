import 'package:contact_app/screen/add_contact.dart';
import 'package:contact_app/screen/edit_contact.dart';
import 'package:contact_app/screen/view_contact.dart';
import 'package:contact_app/services/contactService.dart';
import 'package:flutter/material.dart';
import 'package:contact_app/model/Contact.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late List<Contact> _contactList =<Contact>[]; //creating variable for contact list
  final _contactService=ContactService();

  getAllContactDetails() async {
    var contacts = await _contactService.readAllContacts();
    _contactList=<Contact>[];

    contacts.forEach((contact){
      setState(() {
        var contactModel=Contact();
        contactModel.id=contact['id'];
        contactModel.name=contact['name'];
        contactModel.number=contact['number'];
        contactModel.email=contact['email'];
        _contactList.add(contactModel);
      });
    });
  }
  //when the form loads
  @override
  void initState() {
    getAllContactDetails();
    super.initState();
  }
  //displaying alert
  _displayContactSuccessSnackBar(String alert) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(alert)
        )
    );
  }
  //delete contact alert box
  _deleteContact(BuildContext context, contactId)
  {
    return showDialog(context: context, builder: (value){
      return AlertDialog(
        title: const Text('Delete contact?'),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, //text color

              ),
              onPressed: (){
                Navigator.pop(context);

              }, child: const Text('Cancel')),
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, //text color

              ),
              onPressed: () async{
                var output=await _contactService.deleteContact(contactId);
                if(output!=null){
                  Navigator.pop(context);
                  getAllContactDetails();
                  _displayContactSuccessSnackBar("Contact deleted successfully");
                }


              }, child: const Text('Delete')),
        ],
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Contents Buddy'),
      ),

      body:ListView.builder(itemCount: _contactList.length,itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewContact(contact: _contactList[index],)));
            },
            leading: const Icon(Icons.person),
            title: Text(_contactList[index].name ?? ''),
            //subtitle: Text(_contactList[index].number ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        textStyle: const TextStyle(
                          fontSize: 15,
                        )
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EditContact(contact: _contactList[index],))).then((value) {
                        if(value!=null){
                          getAllContactDetails();
                          _displayContactSuccessSnackBar("Contact updated successfully");
                        }
                      });
                    }, child: const Text("Edit")),
                TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        textStyle: const TextStyle(
                          fontSize: 15,
                        )

                    ),
                    onPressed: (){
                      _deleteContact(context, _contactList[index].id);

                    }, child: const Text("Delete"))
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddContact())).then((value) {
                if(value!=null){
                  getAllContactDetails();
                  _displayContactSuccessSnackBar("Contact added successfully");
                }
          });
        },
        child: const Icon(
            Icons.add
        ),
      ),
    );
  }
}


