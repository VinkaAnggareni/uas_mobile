import 'package:flutter/material.dart';
import 'package:coba_lagi/note.dart';
import 'package:coba_lagi/db.dart';
//import 'package:coba_lagi/loading.dart';

//membuat kelas edit
class Edit extends StatefulWidget {

		final Note note;
		Edit({ this.note });

		@override
		EditState createState() => EditState();

}


class EditState extends State<Edit> {

		TextEditingController title, content;
		bool loading = false, editmode = false;

//untuk edit dan menuju ke halaman edit
//ketika ingin edit kemudian klik data sebelumnya maka akan menuju ke edit data
		@override
		void initState() {
				super.initState();
				title = new TextEditingController();
				content = new TextEditingController();
				if(widget.note.id != null) {
						editmode = true;
						title.text = widget.note.title;
						content.text = widget.note.content;
				}
		}

//untuk edit dan menuju ke halaman edit
		@override
		Widget build(BuildContext context) {
				return Scaffold(
						appBar: AppBar(
              backgroundColor: Colors.black,
								title: Text(editmode? 'EDIT' : 'BARU'),
								actions: <Widget>[
										IconButton(
												icon: Icon(Icons.save, color: Colors.white),
												onPressed: () {
														setState(() => loading = true);
														save();
												},
										),
										if(editmode) IconButton(
											icon: Icon(Icons.delete, color: Colors.white),
												onPressed: () {
														setState(() => loading = true);
														delete();
												},
										),
								],
						),
            backgroundColor: Colors.grey,
      //untuk membuat sebuah kolom dan label text pada kolom
						body : ListView(
								padding: EdgeInsets.all(13.0),
								children: <Widget>[
										TextField(
												decoration: InputDecoration(
														labelText: 'Judul', 
														border: OutlineInputBorder(
															borderRadius: BorderRadius.circular(5.0),
														)
												),
												controller: title),
										SizedBox(height: 10.0),
										TextField(
											decoration: InputDecoration(
													labelText: 'Catatan',
													border: OutlineInputBorder(
														borderRadius: BorderRadius.circular(5.0),
													)
											),
												controller: content,
										),
								],
						),
				);
		}

//untuk menyimpan note
		Future<void> save() async {
				if(title.text != '') {
						widget.note.title = title.text;
						widget.note.content = content.text;
						if(editmode) await DB().update(widget.note);
						else await DB().add(widget.note);
            	Navigator.pop(context);//berfungsi untuk mengembalikan ketampilan utama
				}
				setState(() => loading = false);
		}
//untuk menghapus note
		Future<void> delete() async {
				await DB().delete(widget.note);
				Navigator.pop(context); //berfungsi untuk mengembalikan ketampilan utama 
		}
    

}