import 'package:flutter/material.dart';

class Book with ChangeNotifier {
  String customerNumber = "Chưa cập nhật";
  String vipCustomerNumber = "Chưa cập nhật";
  String revenue = "Chưa cập nhật";

  Book({this.customerNumber,this.vipCustomerNumber,this.revenue});

  updateInfor({customerNumbe, vipCustomerNumber,revenue})
  {
    this.customerNumber = customerNumbe;
    this.vipCustomerNumber = vipCustomerNumber;
    this.revenue = revenue;
    notifyListeners();
  }

}