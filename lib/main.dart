import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Tswkli/cart2.dart';
import 'package:Tswkli/login.dart';
import 'cart_td.dart';
import 'fruits.dart';
import 'package:Tswkli/home.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اتسوكلي',
      theme: ThemeData(
        primarySwatch: Colors.red,
        //fontFamily: 'Cairo'
          fontFamily: 'Changa'
      ),
      initialRoute: MyHomePage.route,
      routes: {
        MyHomePage.route : (context) =>AnimatedSplashScreen(
            duration: 2000,
            splash: Container(
              height: 500,
              width: 500,
              //height: MediaQuery.of(context).size.height/4,
              alignment: Alignment.center,
              child: Image.asset('assets/images/logo.png',fit: BoxFit.cover),
    ),
            nextScreen: MyHomePage(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white
        ),
        Page2.route : (context) => Page2(),
        Cart.route : (context) => Cart(),
        Cartttttt.route : (context) => Cartttttt(),
        Login.route : (context) => Login(),


      },
    );
  }
}
