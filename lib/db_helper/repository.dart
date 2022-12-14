import 'package:contact_app/db_helper/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DbConnection _dbConnection;
  Repository() {
    _dbConnection = DbConnection(); //Initialize
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _dbConnection.setDatabase();
      return _database;
    }
  }

  //Insert Contact
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Read All Contacts
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //Update Contact
  updateData(table, data) async {
    var connection = await database;
    return await connection?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete Contact
  deleteDataById(table, contactId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$contactId");
  }
}