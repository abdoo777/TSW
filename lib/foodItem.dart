import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FoodItemList {
  List<FoodgItem> fooddItems = [];

  Future<List> getd() async {
    var url = 'https://tsitem-d00ba-default-rtdb.firebaseio.com/Pitem.json';
    var masenger = await http.get(url);
    List mormaltext = jsonDecode(masenger.body);
    mormaltext.forEach((json) {
      fooddItems.add(FoodgItem(json));
    });
    return mormaltext;
  }
}


class FoodgItem {
  int id;
  String title;
  int userId;
  String body;
  var quantity;

  FoodgItem(json) {
    this.id = json['id'];
    this.title = json['title'];
    this.userId = json['userId'];
    this.body = json['body'];
    this.quantity = 0.5;
  }
  void incrementQuantity( ) {
    this.quantity = this.quantity + 0.5;
  }
  void decrementQuantity( ) {
    this.quantity = this.quantity - 0.5;
  }
}




class Items extends StatelessWidget {
  final String itemPicture;
  Items({
    @required this.itemPicture,
  });
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}