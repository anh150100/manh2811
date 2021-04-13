import 'package:dictionary_app/database/search_word/dictionary_database.dart';
import 'package:flutter/material.dart';
class DetailsScreen extends StatefulWidget {
  final db = DictionaryDatabase();
  TextEditingController searchController = TextEditingController();


  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchDetailWiget(),
      ),
      body: Container(
      ),
    );
  }

  searchDetailWiget() {
    return
      TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Tra từ Anh Việt",
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
          prefixIcon: Icon(Icons.search,color: Colors.white,),

        ),
      );
  }
}
