import 'package:flutter/material.dart';
import 'package:last/dbhlpr.dart';
import 'package:last/notelist.dart';
import 'package:last/page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Harian',
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var db = new DBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.black,),
        backgroundColor: Colors.white,
        onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: 
        (BuildContext context)=> new NotePage(null,true))),
      ),
      appBar: AppBar(
        title: Text('Catatan Harian', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey,

      body: FutureBuilder(
        future: db.getNote(),
        builder: (context, snapshot){
          if(snapshot.hasError)print(snapshot.error);

          var data = snapshot.data;
          return snapshot.hasData
          ? new NoteList(data)
          : Center(child: Text("Tidak ada data"),);
        },
      ),
    );
  }
}