
import 'package:dictionary_app/database/memori/memori_database.dart';
import 'package:dictionary_app/database/memori/memori_model.dart';
import 'package:dictionary_app/screen/String.dart';
import 'package:dictionary_app/screen/home.dart';
import 'package:dictionary_app/screen/memori_add.dart';
import 'package:flutter/material.dart';

class MemoriScreen extends StatefulWidget {
  @override
  _MemoriScreenState createState() => _MemoriScreenState();
}

class _MemoriScreenState extends State<MemoriScreen> {
  final memori_db = MemoriDatabase();
  Future<List<MemoriModel>> memoriList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMemoriDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(memorizeText),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: ()
            {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: memoriList,
            builder: (context, snapshot)
            {
              if((snapshot.hasError)||(!snapshot.hasData))
                return Center(
                  child: CircularProgressIndicator(),
                );
              List<MemoriModel> list = snapshot.data;
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return itemListView(list[index]);
                  }
              );

            }
        ),

      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add,),
          onPressed: () {
            var route = MaterialPageRoute(
                builder: (context) => MemoriAddScreen());
            Navigator.push(context, route);
          }),
    );
  }


  textAndText({@required lablel, @required content}) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Text(
                lablel, style: TextStyle(fontWeight: FontWeight.bold),)),
          Expanded(
              flex: 2,
              child: Text(content))
        ],
      ),
    );
  }

  itemListView(MemoriModel memoriModel) {
    return Container(
      //padding: EdgeInsets.all(10),
      child:Column(
        children: [
          textAndText(lablel: "Từ", content: memoriModel.word),
          textAndText(lablel: "Phiên âm", content: memoriModel.spell),
          textAndText(lablel: "Nghĩa", content: memoriModel.mean),
          Divider(),
        ],
      ),
    );
  }

  loadMemoriDatabase() {
    memoriList = memori_db.fetchAll();
  }

}

