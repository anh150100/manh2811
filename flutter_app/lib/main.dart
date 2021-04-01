

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
 // String value = "";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map<String, double> pointMap = Map<String, double>();
  double tb = 0 ;
  String danhgia = "";

  TextEditingController mathController, litetureController, englishController ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    englishController = TextEditingController();
    litetureController = TextEditingController();
    mathController = TextEditingController();
   getPointFromStorage();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mathController.dispose();
    litetureController.dispose();
    englishController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int flex;
    return Scaffold(
        appBar: AppBar(
        title: Text("Đánh giá học sinh"),
        centerTitle: true,
    ),
      body: Container(
          padding : EdgeInsets.all(40),
        child: Column(
          children: [
            inputText(
                controller: mathController,
                hintText: "Nhập điểm Toán",
                labelText: "Điểm Toán"),
            Divider(
              height: 10,
            ),
            inputText(
                controller: litetureController,
                hintText: "Nhập điểm Văn",
                labelText: "Điểm Văn"),
            Divider(
              height: 10,
            ),
            inputText(
                controller: englishController,
                hintText: "Nhập điểm Anh",
                labelText: "Điểm Anh"),

            averageWidget(),
            SizedBox(
              height: 10,
              width: 10,
            ),
            //đánh giá
            adjustmentWidget(),
            SizedBox(
              height: 10,
              width: 10,
            ),
            //button
            buttonWidget(),
          ],
        )
      ),
    );
  }


  Widget inputText({@required controller, @required hintText, @required labelText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          labelText: labelText
      ),
    );
  }

  averageWidget()
  {
     return  tb != 0.0 ? Text(
        "Điểm Trung Bình: " + tb.toStringAsFixed(1).toString()
    ): Container();

  }

  double getAveragePoint(){

         return (
             double.parse(mathController.text == "" ? "0.0" : mathController.text)
             + double.parse(litetureController.text == "" ? "0.0" : litetureController.text)
             + double.parse(englishController.text == "" ? "0.0" : englishController.text)) / 3;

  }

  Widget adjustmentWidget()
  {
    return danhgia !="" ? Text(
        "Học Lưc: " + danhgia
    ): Container();
  }

  getAdjustment({@required tb})
  {
    if(tb <5 ) return "Học lực kém";
    else if (tb < 6.5) return "Học lực trung bình";
    else if (tb < 8.5) return "Học lực khá";
    else if (tb< 10) return "Học lực giỏi";
  }

  buttonWidget()
  {
    return ElevatedButton(
        onPressed:(){
          // set points
          setInforIntoStorage();
          setState(() {
            tb = getAveragePoint();
            danhgia = tb != null ? getAdjustment(tb: tb):"";
          });
        },
        child: Text("Đánh giá"));
  }
  setInforIntoStorage() async {
    SharedPreferences inforStorage = await SharedPreferences.getInstance();
    await inforStorage.setDouble('math', double.parse(mathController.text==""?"0.0": mathController.text));
    await inforStorage.setDouble('liteture', double.parse(litetureController.text==""?"0.0":litetureController.text ));
    await inforStorage.setDouble('english', double.parse(englishController.text==""?"0.0":englishController.text));

  }

  getPointFromStorage()async {
    SharedPreferences inforStorage = await SharedPreferences.getInstance();

    double math  =  inforStorage.getDouble('math')?? 0 ; //?? 0
    double liteture  =  inforStorage.getDouble('liteture')?? 0 ;
    double english  =  inforStorage.getDouble('english')?? 0 ;
    mathController.text = math.toString();
    litetureController.text = liteture.toString();
    englishController.text = english.toString();

  }
}






