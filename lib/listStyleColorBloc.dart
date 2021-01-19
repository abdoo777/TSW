import 'dart:ui';//هذا الكلاس كله علمود اللون مال العنصر يصير احمر من نخليه فرق سلة الحذف
import 'package:bloc_pattern/bloc_pattern.dart';//كل كلاس بيه colorbloc يعني علمود اللون يتغير
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';


class ColorBloc extends BlocBase {

  ColorBloc();

  var colorController = BehaviorSubject<Color>.seeded(Colors.white);

  Stream<Color> get colorStream => colorController.stream;

  Sink<Color> get colorSink => colorController.sink;


  setColor(Color color) {
    colorSink.add(color);
  }

  @override
  void dispose() {
    colorController.close();
    super.dispose();
  }
}