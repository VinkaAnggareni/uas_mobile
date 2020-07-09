import 'package:flutter/material.dart';
import 'package:last/dbhlpr.dart';
import 'package:last/note.dart';

class NotePage extends StatefulWidget {
  //untuk menerima data-data dari catatatn
  NotePage(this._mynote, this._isNew);

  final MyNote _mynote;
  final bool _isNew;

  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String title;
  bool btnEdit=true;
  bool btnSave=false;
  bool btnDelete=true;

  MyNote mynote;
  String createDate;

  final cTitle = TextEditingController();
  final cNote = TextEditingController();

  var now = DateTime.now();

  bool _enabledTextField=true;

  Future addRecord() async {
    var db = DBHelper();
    String dateNow =
        "${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}";

    var mynote =
        MyNote(cTitle.text, cNote.text, dateNow, dateNow, now.toString());
    await db.saveNote(mynote);
    print("saved");
  }

  Future updateRecord() async {
    var db= new DBHelper();
     String dateNow =
        "${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}";
    var mynote=new MyNote(cTitle.text, cNote.text, createDate, dateNow, now.toString());

    mynote.setNoteId(this.mynote.id);
    await db.updateNote(mynote);

  }
//untuk menyimpan data
//jika terdapat data baru maka akan minambahkan dan jika diupdate maka akan terupdate
  void _saveData() {
    if (widget._isNew) {
      addRecord();
    } else {
      updateRecord();
    }
  //untuk menampilkan data saat disimpan
  Navigator.of(context).pop();
  }

  void _editData(){
    setState(() {
      _enabledTextField=true;
      btnEdit=false;
      btnSave=true;
      btnDelete=true;
      title="Edit Catatan";
    });
  }

  void delete(MyNote mynote){
    var db=new DBHelper();
    db.deleteNote(mynote);
  }

//konfirmasi delete
  void _confirmDelete(){
  AlertDialog alertDialog= AlertDialog(
    content: Text("Apakah yakin ingin menghapus?", style: TextStyle(fontSize: 18.0),),
    actions: <Widget>[
      RaisedButton(
        color: Colors.red,
        child: Text("Iya",style: TextStyle(color: Colors.black),),
        onPressed: (){
          Navigator.pop(context);
            delete(mynote);
             Navigator.pop(context);
        },
      ),
       RaisedButton(
        color: Colors.grey,
        child: Text("Tidak",style: TextStyle(color: Colors.black),),
        onPressed: (){
          Navigator.pop(context);

        },
      ),
    ],
  );
  showDialog(context: context,child: alertDialog);
  }
  @override
  void initState() {
    if(widget._mynote !=null){
      mynote = widget._mynote;
      cTitle.text=mynote.title;
      cNote.text = mynote.note;
      title="catatanku";
      _enabledTextField=false;
      createDate=mynote.createDate;
    }
    // TODO: implement initState
    super.initState();
  }
/* @override
  // TODO: implement widget
  NotePage get widget => super.widget;*/

  @override
  Widget build(BuildContext context) {
    if (widget._isNew) {
      title = "catatan";
      btnSave = true;
      btnEdit = false;
      btnDelete = false;
    }

    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 23.0),
            ),
          ),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              //untuk kembali ke halaman awal
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 28.0,
              ),
            )
          ],
        ),
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(//SingleChildScrollView agar tulisan dapat memanjang kebawah diatur untuk keseluruhan
                  child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //enebale tergantung halaman yng terbuka, antara halaman baru atau update atau halaman view
                  CreateButton(
                    icon: Icons.save,
                    enable: btnSave,
                    onpress: _saveData,
                  ),
                  CreateButton(
                    icon: Icons.edit,
                    enable: btnEdit,
                    onpress: _editData,
                  ),
                  CreateButton(
                    icon: Icons.delete,
                    enable: btnDelete,
                    onpress: _confirmDelete,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  enabled: _enabledTextField,
                  controller: cTitle,
                  decoration: InputDecoration(
                      hintText: "Judul",
                      border: InputBorder.none //untuk hilangin garis pembatas
                      ),
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: cNote,
                  enabled: _enabledTextField,
                  decoration: InputDecoration(
                      hintText: "Mulai Mencatat",
                      border: InputBorder.none //untuk hilangin garis pembatas
                      ),
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  //agar bisa melakukan enter
                  textInputAction: TextInputAction.newline,
                ),
              ),
            ],
          ),
        ));
  }
}

class CreateButton extends StatelessWidget {
  final IconData icon;
  final bool enable;
  final onpress;

  CreateButton({this.icon, this.enable, this.onpress});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: enable ? Colors.black : Colors.brown[200]),
      child: IconButton(
        icon: Icon(icon),
        color: Colors.white,
        iconSize: 19.0,
        onPressed: () {
          if (enable) {
            onpress();
          }
        },
      ),
    );
  }
}
