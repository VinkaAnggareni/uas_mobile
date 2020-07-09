class Note {

//inialisasi
		int id, date;
		String title, content;

//untuk mengurutkan data menggunakan datetime
//ketika minyimpan data maka data yang pertamakali disimpan akan berada paling bawah
	setDate() {
				DateTime now = DateTime.now();
				String ds = now.year.toString() + now.month.toString() + now.day.toString() + now.hour.toString() + now.minute.toString() + now.second.toString();
				date = int.parse(ds);
		}
//konversi dari note ke Map
		Note();

		Note.fromMap(Map<String, dynamic> map) {
				id = map['id'];
				date = map['date'];
				title = map['title'];
				content = map['content'];
		}

		toMap() {
				return <String, dynamic>{
						'id': id,
						'date': date,
						'title': title,
						'content': content,
				};
		}

}