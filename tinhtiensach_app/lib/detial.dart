

import 'package:danhgia_app/book_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thống kê"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
            margin: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                textWidget(
                    title: "Tổng số KH: ",
                    content: context.read<Book>().customerNumber),
                textWidget(
                    title: "Tổng số KH là VIP: ",
                    content: context.read<Book>().vipCustomerNumber),
                textWidget(
                    title: "Tổng doanh thu: ",
                    content: context.read<Book>().revenue),
              ],
            ),
          ),
    );
  }

  textWidget({@required title, @required content}) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(title),
          ),
          Expanded(
            child: Text(content),
          )
        ],
      ),
    );
  }
}
