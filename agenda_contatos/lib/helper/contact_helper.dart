import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String contactTable = "contactTable";
final String idcolumn = "idcolumn";
final String namecolumn = "namecolumn";
final String emailcolumn = "emailcolumn";
final String phonecolumn = "phonecolumn";
final String imgcolumn = "imgcolumn";

class Contacthelper {
  static final Contacthelper _instance = Contacthelper.internal();

  factory Contacthelper() => _instance;

  Contacthelper.internal();

  Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contacts.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable($idcolumn INTEGER PRIMARY KEY, $namecolumn TEXT, $emailcolumn TEXT,"
          "$phonecolumn TEXT, $imgcolumn TEXT)");
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbcontact = await db;
    contact.id = await dbcontact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbcontact = await db;
    List<Map> maps = await dbcontact.query(contactTable,
        columns: [idcolumn, namecolumn, emailcolumn, phonecolumn, imgcolumn],
        where: "$idcolumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  deleteContact(int id) async {
    Database dbcontact = await db;
    dbcontact.delete(contactTable, where: "$idcolumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbcontact = await db;
    return await dbcontact.update(contactTable, contact.toMap(),
        where: "$idcolumn = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContact() async {
    Database dbcontact = await db;
    List listMap = await dbcontact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = List();
    for (Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future<int> getNumber() async {
    Database dbcontact = await db;
    return Sqflite.firstIntValue(
        await dbcontact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  close() async {
    Database dbcontact = await db;
    dbcontact.close();
  }
}

class Contact {
  int id;
  String name;
  String email;
  String phone;
  String img;
  Contact();
  Contact.fromMap(Map map) {
    id = map[idcolumn];
    name = map[namecolumn];
    email = map[emailcolumn];
    phone = map[phonecolumn];
    img = map[imgcolumn];
  }
  Map toMap() {
    Map<String, dynamic> map = {
      namecolumn: name,
      emailcolumn: email,
      phonecolumn: phone,
      imgcolumn: img,
    };
    if (id != null) {
      map[idcolumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contactid  : $id, name: $name, email: $email, phone: $phone, img: $img ";
  }
}
