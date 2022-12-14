import 'package:contact_app/model/Contact.dart';
import 'package:contact_app/services/contactService.dart';
import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  final Contact contact;
  const EditContact({Key? key,required this.contact}) : super(key: key);

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  var _contactNameController=TextEditingController();
  var _contactNumberController=TextEditingController();
  var _contactEmailController=TextEditingController();
  //var _userPhotoController=TextEditingController();

  //Validating text fields
  bool _validateName = false;
  bool _validateNumber = false;
  bool _validateEmail = false;
  //To communicate with contact service
  var _contactService=ContactService();

  @override
  void initState() {
    setState(() {
      _contactNameController.text=widget.contact.name ?? '';
      _contactNumberController.text=widget.contact.number ?? '';
      _contactEmailController.text=widget.contact.email ?? '';
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Contents Buddy'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/profile_photo.jpg'), //add path under assets in pubspec.yaml
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Edit Contact',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                  color: Colors.cyan,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
                width: 100.0,
                child: Divider(
                  color: Colors.cyan.shade100,
                ),
              ),

              Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: ListTile(
                  leading: const Icon(
                      Icons.person,
                      color: Colors.black),
                  title:TextField(
                    controller: _contactNameController,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Source Sans Pro',
                      color: Colors.black,
                    ),
                    decoration:  InputDecoration(
                      hintText: "Enter your name",
                      labelText: "Name",
                      errorText: _validateName ? 'Name field required' : null,
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.phone,
                    color: Colors.black,),
                  title:TextField(
                    controller: _contactNumberController,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Source Sans Pro',
                      color: Colors.black,
                    ),
                    decoration:  InputDecoration(
                      hintText: "Enter your mobile number",
                      labelText: "Mobile",
                      errorText: _validateNumber ? 'Mobile number field required' : null,
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.email,
                    color: Colors.black,),
                  title:TextField(
                    controller: _contactEmailController,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Source Sans Pro',
                      color: Colors.black,
                    ),
                    decoration:  InputDecoration(
                      hintText: "Enter your email address",
                      labelText: "Email",
                      errorText: _validateEmail ? 'Email address field required' : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, //text color
                        backgroundColor: Colors.blue,
                        textStyle: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _contactNameController.text.isEmpty?_validateName=true:_validateName=false;
                          _contactNumberController.text.isEmpty?_validateNumber=true:_validateNumber=false;
                          _contactEmailController.text.isEmpty?_validateEmail=true:_validateEmail=false;//49.31


                        });
                        if(_validateName==false && _validateNumber==false && _validateEmail==false){
                          //print("Contact added successfully");
                          var _contact = Contact();
                          _contact.id=widget.contact.id;
                          _contact.name=_contactNameController.text;
                          _contact.number=_contactNumberController.text;
                          _contact.email=_contactEmailController.text;
                          var output = await _contactService.updateContact(_contact);
                          //print(output);
                          Navigator.pop(context,output);


                        }
                      }, child: const Text("Update")),
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, //text color
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: (){
                        _contactNameController.text = '';
                        _contactNumberController.text = '';
                        _contactEmailController.text = '';
                      }, child: const Text("Clear"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
