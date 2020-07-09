import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coba_lagi/note.dart';
import 'package:coba_lagi/edit.dart';
import 'package:coba_lagi/db.dart';
//import 'package:coba_lagi/loading';

//membuat class home
class Home extends StatefulWidget {
		@override
		HomeState createState() => HomeState();
}


class HomeState extends State<Home> {

		List<Note> notes;
		bool loading = true;

		@override
		void initState() {
				super.initState();
				refresh();
		}
 //untuk mengatur bagian awal
		@override
		Widget build(BuildContext context) {
				return Scaffold(
						appBar: AppBar(
              backgroundColor: Colors.black,
								title: Text('Catatan Harian'),
						),
           
            backgroundColor: Colors.grey,
						floatingActionButton: FloatingActionButton( 
              //untuk menampilkan dan mengaktifkan tombol edit
								child: Icon(Icons.edit, color: Colors.black,),
                backgroundColor: Colors.white,
								onPressed: () {
										setState(() => loading = true);
										Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(note: new Note()))).then((v) {
												refresh();
										});
								},
						),
        //untuk menampilkan data ketika sudah disimpan atau diedit
						body: ListView.builder(
								padding: EdgeInsets.all(5.0),
								itemCount: notes.length,
								itemBuilder: (context, index) {
										Note note = notes[index];
										return Card(
												color: Colors.white70,
												child: ListTile(
														title: Text(note.title),
														subtitle: Text(
																note.content,
																maxLines: 2,
																overflow: TextOverflow.ellipsis,
														),
														onTap: () {
																setState(() => loading = true);
																Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(note: note))).then((v) {
																		refresh();
																});
														},
												),
										);
								},
						),
				);
		}

//asinkron menggunakan future
		Future<void> refresh() async {
				notes = await DB().getNotes();
				setState(() => loading = false);
		}

}