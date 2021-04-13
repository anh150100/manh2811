import 'package:dictionary_app/database/memori/memori_database.dart';
import 'package:dictionary_app/database/memori/memori_model.dart';
import 'package:dictionary_app/screen/my_memorize.dart';
import 'package:flutter/material.dart';

class MemoriAddScreen extends StatefulWidget {
  @override
  _MemoriAddScreenState createState() => _MemoriAddScreenState();
}

class _MemoriAddScreenState extends State<MemoriAddScreen> {

  final memori_db = MemoriDatabase();

  TextEditingController wordController = TextEditingController();
  TextEditingController spellController = TextEditingController();
  TextEditingController meanController = TextEditingController();

  // final mark_db = MarkDatabase();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    wordController.dispose();
    spellController.dispose();
    meanController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: ()
            {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            textFieldWidget(
                controller: wordController,
                hintText: "Nhập từ",),
            textFieldWidget(
                controller: spellController,
                hintText: "Phiên âm"),
            textFieldWidget(
                controller: meanController,
                hintText: "Nghĩa của từ"),
            ElevatedButton(
                onPressed: () async {
                  MemoriModel markModel = MemoriModel(
                    word: wordController.text,
                    spell: spellController.text,
                    mean: meanController.text,
                  );

                  memori_db.addMark(markModel).then((value) {
                    // var route = MaterialPageRoute(
                    //     builder: (context) => MemoriScreen());
                    // Navigator.push(context, route);
                  });
                },
                child: Text("Thêm ghi chú")),
          ],
        ),
      ),
    );
  }
  textFieldWidget({@required controller, @required hintText})
  {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
        ),
      ),
    );
  }
}
