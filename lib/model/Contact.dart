class Contact {
  int? id;
  String? name;
  String? number;
  String? email;

  contactMap() {
    var mapping=Map<String,dynamic>();
    mapping['id']=id??null;
    mapping['name']=name!;//should not be null
    mapping['number']=number!;
    mapping['email']=email!;
    return mapping;
  }
}