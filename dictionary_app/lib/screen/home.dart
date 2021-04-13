
import 'package:dictionary_app/database/search_word/dictionary_database.dart';
import 'package:dictionary_app/screen/String.dart';
import 'package:dictionary_app/screen/detail.dart';
import 'package:dictionary_app/screen/memori_add.dart';
import 'package:dictionary_app/screen/my_memorize.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>with TickerProviderStateMixin {
  final db = DictionaryDatabase();
  TextEditingController searchController = TextEditingController();

   @override
   void dispose() {
     // TODO: implement dispose
     super.dispose();
     searchController.dispose();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            searchBar(),
            SizedBox(
              height: 150,
            ),
            _itemMemorize(),
            SizedBox(
              height: 10,
            ),
            _itemMusic(),
            SizedBox(
              height: 10,
            ),
            _itemStudy(),
            SizedBox(
              height: 10,
            ),
            _itemHistory(),
          ],
      ),
    ),
            );
  }

  searchBar(){
    return Container(
      child:  Row(
          children: [
            Expanded(
              flex: 8,
              child:  searchWiget(),),
            Expanded(
              flex: 2,
              child: iconWiget(),
            ),
          ],
        )
    );
  }
  searchWiget() {
    return
      TextField(
        decoration: InputDecoration(
          hintText: "Tra từ Anh Việt",
          prefixIcon: Icon(Icons.search,),
        ),
      );
  }

  iconWiget() {
    return RaisedButton(
      child: Text('Tìm kiếm'),
      onPressed: () {
        var route = MaterialPageRoute(builder: (context)
        => DetailsScreen());
        Navigator.push(context, route);
      },
    );
  }

  Widget _itemMemorize(){
    return  RaisedButton(
          padding: EdgeInsets.only(left: 20),
              child:Row(
                children: [
                  Icon(
                      Icons.lightbulb_outline,
                      color: Colors.blueGrey,
                      size:50 ,
                  ),
                  Text(memorizeText),
              ],
              ),
        onPressed: (){
          var route = MaterialPageRoute(builder: (context)
          => MemoriScreen());
          Navigator.push(context, route);
        },
          );
  }

  Widget _itemMusic(){
    return  RaisedButton(
      padding: EdgeInsets.only(left: 20),
      child:Row(
        children: [
          Icon(
            Icons.music_note_rounded,
            color: Colors.blueGrey,
            size:50 ,
          ),
          Text(musicText),
        ],
      ),
      onPressed: (){},
    );
  }

  Widget _itemStudy(){
    return  RaisedButton(
      padding: EdgeInsets.only(left: 20),
      child:Row(
        children: [
          Icon(
            Icons.menu_book,
            color: Colors.blueGrey,
            size:50 ,
          ),
          Text(studyText),
        ],
      ),
      onPressed: (){},
    );
  }

  Widget _itemHistory(){
    return  RaisedButton(
      padding: EdgeInsets.only(left: 20),
      child:Row(
        children: [
          Icon(
            Icons.access_time_outlined,
            color: Colors.blueGrey,
            size:50 ,
          ),
          Text(hictoryText),
        ],
      ),
      onPressed: (){},
    );
  }
  
}

