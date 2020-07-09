import 'package:last/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'dart:async';
import 'package:path/path.dart';

class DBHelper{
  static final DBHelper _instance= new DBHelper.internal();
  DBHelper.internal();
  factory DBHelper() => _instance;

  static Database _db;

  Future<Database> get db async{
    if(_db!=null)return _db;
    _db= await setDB();
    return _db;
  }
  setDB()async{
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,"CatatanHarianDB");
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }
//unuk notenya
//untuk query pada database beserta field"nya
  void _onCreate(Database db, int version) async{
    //penggunaan sort digunakan untuk mengurutkan data 
    await db.execute("CREATE TABLE mynote(id INTEGER PRYMARY KEY, title TEXT, note TEXT, createDate TEXT, updateDate TEXT, sortDate TEXT)"); 
    print("DB Created");
  }
//untuk menyimpan data
  Future<int> saveNote(MyNote mynote) async{
    var dbClient = await db;
    int res=await dbClient.insert("mynote", mynote.toMap());
    print("data inserted");
    return res;
  }
//proses untuk mengambil data pada db
  Future<List<MyNote>> getNote() async{
    var dbClient = await db;
//desc digunakan untuk mengurutkan data dari yang terbaru
    List<Map> list = await dbClient.rawQuery("SELECT * FROM mynote ORDER BY sortDate DESC"); 
    List<MyNote> notedata=new List();
    for(int i=0;i<list.length;i++){
      var note = new MyNote(list[i]['title'], list[i]['note'], list[i]['createDate'] , list[i]['updateDate'], list[i]['sortDate']);
      note.setNoteId(list[i]['id']);
      notedata.add(note);
    }
    return notedata;

  }

  Future<bool> updateNote(MyNote mynote) async{
    var dbClient = await db;
    int res = await dbClient.update("mynote", mynote.toMap(),where: "id=?", whereArgs: <int>[mynote.id]);
    return res > 0 ? true:false;
  }

  Future<int> deleteNote(MyNote mynote) async{
    var dbClient = await db;
    int res = await dbClient.rawDelete("DELETE FROM mynote WHERE id= ?", [mynote.id]);
    return res;
  }
}