import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:Tswkli/provider.dart';
import 'foodItem.dart';


class CartListBloc extends BlocBase{

  CartListBloc();

  var _listControler = BehaviorSubject<List<FoodgItem>>.seeded([]);

  CartProvider  provider = CartProvider();
  //output
  Stream<List<FoodgItem>> get ListStream => _listControler.stream;

  //input
  Sink<List<FoodgItem>> get ListSink => _listControler.sink;

  addToList(FoodgItem fooddItems) {
    ListSink.add(provider.addToList(fooddItems));
  }

  removeFromList (FoodgItem foodItem){
    ListSink.add(provider.removeFromList(foodItem));
  }

  @override
  void dispose() {// will be called automatically
    _listControler.close();
    super.dispose();
  }
}
