import 'package:contact_app/db_helper/repository.dart';
import 'package:contact_app/model/Contact.dart';

class ContactService {
  late Repository _repository;
  ContactService() {
    _repository = Repository();
  }

  //Save contact
  saveContact(Contact contact) async {
    return await _repository.insertData('contacts', contact.contactMap()); //Need mapping contact model
  }

  //Read all contacts
  readAllContacts() async{
    return await _repository.readData('contacts');

  }

  //Update contact
  updateContact(Contact contact) async {
    return await _repository.updateData('contacts', contact.contactMap());
  }

  //Delete contact
  deleteContact(contactId) async {
    return await _repository.deleteDataById('contacts', contactId);
    
  }
}