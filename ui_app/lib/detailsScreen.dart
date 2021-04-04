
import 'dart:html';
import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // cho phép phần thân nằm ở lớp phía dưới của AppBar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            "image1.jpg",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.8),
          ),
        _body(context),
        ],
      ),
    );
  }

  _body(BuildContext context){
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        SizedBox(
          height: 20,
        ),
        _header(),
        SizedBox(
          height: 20,
        ),
        _cast(),
        SizedBox(
          height: 20,
        ),
        _overview(),
      ],
    );
  }

  _header(){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
          width: 100,
          height: 150,
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.bottomRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("image1.jpg"),
            ),
          ),
          ),
            Container(
              padding: EdgeInsets.all(20.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                "RAYA và rồng thần cuối cùng",
                style: TextStyle( fontSize: 24),
                ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                  "Xuất bản: 05-T3-2021",
                  style: TextStyle( fontSize: 12),
                ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text("Thể loại:  ",
                        style: TextStyle( fontSize: 12),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Phim Hoạt Hình, Phim",
                            style: TextStyle( fontSize: 12),
                          ),
                          Text("Phiêu Lưu, Phim Giả Tượng, ",
                            style: TextStyle( fontSize: 12),
                          ),
                          Text("Phim Gia Đình, Phim Hành ",
                            style: TextStyle( fontSize: 12),
                          ),
                          Text("Động",
                            style: TextStyle( fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),

                ],
              ),
              ),
          ],


        ),
    );
  }

  _cast(){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Cast"),
          SizedBox(
            height: 20,
            width: 20,
          ),
          Container(
          height: 160,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: listItemCast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return _itemCast(listItemCast[index]);
              },),
          ),
        ],
      ),
    );
  }

  _itemCast(ItemCast itemCast){
    return Container(
      padding: EdgeInsets.only(left: 5.0,right: 5.0),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 130,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(itemCast.urlPhoto),
              ),
            ),

          ),
          SizedBox(
            width: 10,
            height: 10,
          ),
          Text(
            itemCast.name,
          ),

        ],
      ),
    );
  }

  _overview(){
    return Padding(
        padding:const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Overview",
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Raya và Rồng Thần Cuối Cùng kể về một vương quốc huyền bí có tên là Kumandra – vùng đất mà loài rồng và con người sống hòa thuận với nhau. Nhưng rồi một thế lực đen tối bỗng đe dọa bình yên nơi đây, loài rồng buộc phải hi sinh để cứu lấy loài người. 500 năm sau, thế lực ấy bỗng trỗi dậy và một lần nữa, Raya là chiến binh duy nhất mang trong mình trọng trách đi tìm Rồng Thần cuối cùng trong truyền thuyết nhằm hàn gắn lại khối ngọc đã vỡ để cứu lấy vương quốc. Thông qua cuộc hành trình, Raya nhận ra loài người cần nhiều hơn những gì họ nghĩ, đó chính là lòng tin và sự đoàn kết.",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}

class ItemCast{
  String name;
  String charater;
  String urlPhoto;
  ItemCast({required this.name,required this.charater,required this.urlPhoto});
}

final List<ItemCast> listItemCast = [
  ItemCast(
      name: "Kelly Marie Tran",
      charater: "Raya (voice)",
      urlPhoto: "image1.jpg"),
  ItemCast(
      name: "Awkwafina",
      charater: "Sisu (voice)",
      urlPhoto: "image1.jpg"),
  ItemCast(
      name: "Izaac Wang",
      charater: "Boun (voice)",
      urlPhoto: "image1.jpg"),
  ItemCast(
      name: "Gemma Chan",
      charater: "Namaari (voice)",
      urlPhoto: "image1.jpg"),
 ];
