import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          shadowColor: Colors.red,
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,size: 27,color: Colors.red,),
            onPressed: (){Navigator.of(context).pop();},
          ),
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height/4,
            alignment: Alignment.center,
            child: Image.asset('assets/images/logo.png',fit: BoxFit.cover),
          ),
          Text('محلات تسوكلي',style: TextStyle(fontWeight: FontWeight.w900),),
          Text('الفرع الاول : الناصرية - سوق سومر - مجاور عوده الكصاب',style: TextStyle(fontWeight: FontWeight.w900),),
          Text('الفرع الثاني : الناصرية - الشموخ - فرع حلويات الدرويش',style: TextStyle(fontWeight: FontWeight.w900),),
          Text('للتواصل والاستفسار : 07810107944',style: TextStyle(fontWeight: FontWeight.w900),),
          Expanded(child: Container(height: 10,),),
          RaisedButton.icon(
            icon: Icon(Icons.logout, size: 27,),
            label: Text('تسجيل خروج',style: TextStyle(fontWeight: FontWeight.w900),),
            color: Colors.red[200],
            onPressed: (){
              instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
