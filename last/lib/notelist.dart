import 'package:flutter/material.dart';
import 'package:last/note.dart';
import 'package:last/page.dart';

class NoteList extends StatefulWidget {
  final List<MyNote> notedata;
  NoteList(this.notedata, {Key key});
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2 : 3 //untuk mengatur potrait pada tampilan
          ),
      itemCount: widget.notedata.length == null ? 0 : widget.notedata.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new NotePage( widget.notedata[i], false)));
          } ,
                  child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(9.0),
                    width: double.infinity,
                    child: Text(
                      widget.notedata[i].title,
                      style: TextStyle(fontSize:20.0, fontWeight: FontWeight.bold),
                    )),
                //untuk scroll catatan
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(9.0),
                      child: Text(
                        widget.notedata[i].note,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Created : ${widget.notedata[i].createDate}"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text("Modified: ${widget.notedata[i].updateDate}"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
