import 'package:flutter/material.dart';
import 'package:coba_lagi/home.dart';


void main() => runApp(NoteUp());

class NoteUp extends StatelessWidget {
		@override
		Widget build(BuildContext context) {
				return MaterialApp(
						debugShowCheckedModeBanner: false, //di set false untuk menghilangkan debug banner pada pojok kanan atas
						home: Home(),
				);
		}
}