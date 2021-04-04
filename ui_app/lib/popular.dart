import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';

import 'detailsScreen.dart';


class ItemPopular{
  final String name;
  final String urlPhoto;
  final String releaseDate;

  ItemPopular({required this.name, required this.urlPhoto, required this.releaseDate});
}

final List<ItemPopular> listItemPopular = [
  ItemPopular(
      name: "RAYA và rồng thần cuối cùng",
      urlPhoto: "image1.jpg",
      releaseDate: "05-T3-2021"),
  ItemPopular(
      name: "Tom và Jerry: Quậy tung New York",
      urlPhoto: "image2.jpg",
      releaseDate: "26-T2-2021"),
  ItemPopular(
      name: "Chaos Walking",
      urlPhoto: "image3.jpg",
      releaseDate: "05-T3-2021"),
  ItemPopular(
      name: "Fear of Rain",
      urlPhoto: "image4.jpg",
      releaseDate: "12-T2-2021"),
  ItemPopular(
      name: "Judas and the Black Messiah",
      urlPhoto: "image5.jpg",
      releaseDate: "12-T2-2021"),
  ItemPopular(
      name: "Nomadland",
      urlPhoto: "image6.jpg",
      releaseDate: "12-T9-2021"),
];


class PopularView extends StatefulWidget {
  @override
  _PopularViewState createState() => _PopularViewState();
}




class _PopularViewState extends State<PopularView> {




  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.62,
          crossAxisCount: 2, //chia làm 2 cột con
          crossAxisSpacing: 16, //chia khoảng cách giữa các cột con
          mainAxisSpacing: 30, //chia khoảng cách giữa các cột con
        ),

        itemCount: listItemPopular.length,
        itemBuilder: (context, index) {
          return _itemPopular(listItemPopular[index]);
        }
    );
  }

  Widget _itemPopular(ItemPopular itemPopular) {
    return GestureDetector(
    onTap:() {
        var route = MaterialPageRoute(builder: (context) => DetailsScreen());
        Navigator.push(this.context, route);
    },

      child: Column(
        children: [
          Container(
            width: 250,
            height: 300,
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(itemPopular.urlPhoto),
              ),
            ),

            child: Text(
              itemPopular.releaseDate,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          SizedBox(
            width: 10,
            height: 10,
          ),
          Text(
            itemPopular.name,
          ),

        ],
      ),
    );
  }
}






