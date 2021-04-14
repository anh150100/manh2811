import 'package:danhgia_app/book_information.dart';
import 'package:danhgia_app/detial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=> Book())
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController customerNameController  = TextEditingController();
  TextEditingController bookNumberController = TextEditingController();

   SharedPreferences sharedPreferences ;

  FocusNode focusNode;
  bool isVip = false;
  var bookMoney = 0 ;
  var customerNumber =0 ;
  var vipCustomerNumber = 0 ;
  var moneyTotal = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
    getInforFromDatabase();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    customerNameController.dispose();
    bookNumberController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                textWidget(
                    weightBox: MediaQuery.of(context).size.width,
                    text: "Chương trình bán sách Online",
                    colorText: Colors.white,
                    colorBox: Colors.green,
                    textAlign: TextAlign.center),
                textWidget(
                    weightBox: MediaQuery.of(context).size.width,
                    text: "Thông tin hóa đơn",
                    colorText: Colors.black,
                    colorBox: Colors.green,
                    textAlign: TextAlign.left),
                textAndTextFieldWidget(
                    text: "Tên Khách Hàng : ",
                    textController: customerNameController,
                    hintText: "Tên khách hàng",
                    keyboardType: TextInputType.text,
                    focusNode: focusNode
                ),
                textAndTextFieldWidget(
                    text: "Số lượng sách : ",
                    textController: bookNumberController,
                    hintText: "Số lượng sách ",
                    keyboardType: TextInputType.number),
                vipCheckBox(),
                textAndTextWidget(
                    titleText: "Thành Tiền : ",
                    contentText: bookMoney.toString(),
                    textContentBoxColor: Colors.black26,
                    alignContentText: TextAlign.center),
                buttons(
                    buttonText1: "TÍNH TT",
                    buttonText2: "TIẾP",
                    buttonText3: "THỐNG KÊ",
                    buttonFunction1: (){
                      setState(() {
                        bookMoney = tinhTienFunction();
                      });
                    },
                    buttonFunction2: (){
                      if(customerNameController.text !=""){
                        customerNumber ++;
                        if(isVip) vipCustomerNumber ++;
                        moneyTotal += bookMoney;
                      }
                      customerNameController.text ="";
                      bookNumberController.text = "";
                      setState(() {
                        isVip = false;
                      });
                      focusNode.requestFocus();
                      bookMoney = 0;
                      setInforToDatabase(
                          customer_total: customerNumber,
                          vip_customer: vipCustomerNumber ,
                          money_total: moneyTotal);
                    },
                    buttonFunction3: () {
                      setState(() {
                        context.read<Book>().updateInfor(
                          customerNumbe: customerNumber.toString(),
                          vipCustomerNumber: vipCustomerNumber.toString(),
                          revenue: moneyTotal.toString(),
                        );
                      });
                      var route = MaterialPageRoute(builder: (context) => DetailScreen());
                      Navigator.push(context, route);
                    }),
                textWidget(
                    text: "Thông tin thống kê",
                    colorText: Colors.black,
                    colorBox: Colors.green,
                    textAlign: TextAlign.left,
                    weightBox: MediaQuery.of(context).size.width,
                    marginBox: EdgeInsets.only(top: 10, bottom: 10)
                ),
                textAndTextWidget(
                    titleText: "Tổng số KH : ",
                    contentText: customerNumber.toString(),
                    textContentBoxColor: Colors.transparent,
                    alignContentText: TextAlign.left),
                textAndTextWidget(
                    titleText: "Tổng số KH là VIP : ",
                    contentText: vipCustomerNumber.toString(),
                    textContentBoxColor: Colors.transparent,
                    alignContentText: TextAlign.left),
                textAndTextWidget(
                    titleText: "Tổng doanh thu : ",
                    contentText: moneyTotal.toString(),
                    textContentBoxColor: Colors.transparent,
                    alignContentText: TextAlign.left),
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green,
                ),
                logoutButton()


              ],
            ),

          ),
        )
    );
  }

  setInforToDatabase({@required customer_total,@required vip_customer, @required money_total })async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt("customer_total", customer_total);
    await sharedPreferences.setInt("vip_customer", vip_customer);
    await sharedPreferences.setInt("money_total", money_total);
  }
  getInforFromDatabase()async {
    sharedPreferences = await SharedPreferences.getInstance();
    customerNumber = sharedPreferences.getInt("customer_total")?? 0;
    vipCustomerNumber = sharedPreferences.getInt("vip_customer")?? 0;
    moneyTotal = sharedPreferences.getInt("money_total")?? 0;
  }

  tinhTienFunction(){
    if(isVip) return (int.parse(bookNumberController.text==""?"0":bookNumberController.text) * 20000* 0.9).toInt();
    else
      return (int.parse(bookNumberController.text==""?"0":bookNumberController.text) * 20000);
  }

  logoutButton()
  {

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(Icons.logout),
                onPressed: (){


                  _showMyDialog();

                }),
          )
        ],
      ),
    );
  }

  clearSharedPreference()async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có muốn thoát ứng dụng không ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Đồng ý'),
              onPressed: () {
                clearSharedPreference();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  buttons({@required buttonText1, @required buttonText2, @required buttonText3, @required buttonFunction1,   @required buttonFunction2,  @required buttonFunction3,})
  {
    return Container(
      margin: EdgeInsets.only(right: 5, left: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                color: Colors.grey,
                padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                child: Text(buttonText1, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              onTap: buttonFunction1,
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                color: Colors.grey,
                padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                child: Text(buttonText2, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              onTap: buttonFunction2,
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(

                color: Colors.grey,
                padding: EdgeInsets.only( left: 20, top: 10, bottom: 10),
                child: Text(buttonText3, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              onTap: buttonFunction3,
            ),

          ),
        ],
      ),
    );
  }


  Widget textWidget({@required text, @required colorText, @required colorBox, @required textAlign, @required weightBox, marginBox})
  {
    return Container(
      margin: marginBox,
      width: weightBox,
      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: colorBox
      ),
      child: Text(text,
        textAlign: textAlign,
        style: TextStyle(
          color:colorText,
        ),),
    );
  }

  Widget textAndTextFieldWidget({@required text, @required textController, @required hintText, @required keyboardType , focusNode}){
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(text),
          ),
          Expanded(
              flex: 3,
              child: TextField(
                  controller: textController,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    hintText: hintText,
                  )
              ))
        ],
      ),
    );
  }

  Widget textAndTextWidget({@required titleText, @required contentText, @required textContentBoxColor, @required alignContentText  })
  {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(titleText),
          ),
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                color: textContentBoxColor,
                child: Text(contentText,
                  textAlign: alignContentText,
                ),
              )
          )
        ],
      ),
    );
  }

  vipCheckBox(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Container()),
          Expanded(
              flex: 3,
              child: CheckboxListTile(
                title: Text("Khách hàng Vip"),
                value: isVip,
                contentPadding: EdgeInsets.only(left: 0),
                activeColor: Colors.red,
                onChanged: (newValue) {
                  setState(() {
                    isVip = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              ))
        ],
      ),
    );
  }




}