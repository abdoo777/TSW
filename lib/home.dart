import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Tswkli/about_us.dart';
import 'package:Tswkli/login.dart';
import 'cartListBloc.dart';
import 'fruits.dart';
import 'listStyleColorBloc.dart';


class MyHomePage extends StatefulWidget {
  static final route = '/home';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    instance.authStateChanges().listen((User user) {
      if(user == null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
        print('no user');
      } else{
        print('there is a user');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]
    );
    return BlocProvider(
        blocs: [
          Bloc ((i) => CartListBloc()),
          Bloc ((i) => ColorBloc())// هاي علمود  اللون مال العنصر يصير احمر من نخليه فرق سلة الحذف
        ],
        child: MyHomePagee()
    );
  }
}

class MyHomePagee extends StatefulWidget {
  @override
  _MyHomePageeState createState() => _MyHomePageeState();
}


class _MyHomePageeState extends State<MyHomePagee> {

  Future getd() async {
    var url = 'https://tspicture-4203f-default-rtdb.firebaseio.com/Picture.json';
    var masenger = await http.get(url);
    var mormaltext = jsonDecode(masenger.body);
    return mormaltext;
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Text('أتسوكلي', style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),),
          actions: [
            IconButton(
                icon: Icon(Icons.info, size: 27,),
                color: Colors.red[700],
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));}
            ),
          ],
        ),
        body: FutureBuilder(
        future: getd(),
    builder: (context,snapshot){
    if(snapshot.hasData){
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text('أعلانات و عروض',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
            ),
            Container(
              height: screenHeight/3.5,
              width: screenWidth,
              child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal ,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, [i]) {
                        return Info(
                          uurl: snapshot.data[i]['uurl'],
                        );
                      })
              ),
            ),
            SizedBox(height: 6,),
            Container(height: 1,width: MediaQuery.of(context).size.width,color: Colors.red,),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.width/1.2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, Page2.route);
                  },
                  child:Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.width/1.6,
                      width: MediaQuery.of(context).size.width/1.6,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black)],
                        image: DecorationImage(image: AssetImage(
                            'assets/images/frut.jpg'
                        ),
                            fit: BoxFit.cover),
                        color: Colors.red[100],
                        borderRadius: BorderRadius.all(Radius.circular(900.0)),
                        border: Border.all(color: Colors.red,width: 1),
                      ),
                      child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width/2.8,
                          width: MediaQuery.of(context).size.width/2.8,
                          decoration: BoxDecoration(
                              color: Colors.white.withAlpha(150),
                              borderRadius: BorderRadius.all(Radius.circular(900.0)),
                              border: Border.all(color: Colors.black,width: 1)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('اذهب',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 20),),
                              Text('الى التسوق',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 20),),
                            ],)
                      ),
                    ),),
                ),
              ),
            )
          ],
        );} else if(snapshot.hasError){
      return Center(child: Text('هنالك خطأ ما ... يرجي التحقق من الاتصال بالانترنت واعادة المحاوله'),);
    }
    return Center(child: CircularProgressIndicator(),);
        })//======
    );
  }
}




class Info extends StatelessWidget {
  final uurl;
  Info({this.uurl});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width / 1.3,
      height: MediaQuery
          .of(context)
          .size
          .height / 4,
      margin: EdgeInsets.only(right: 10, left: 10,top: 10),
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage('${uurl}'),
              fit: BoxFit.cover),
          color: Colors.red[100],
          borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
    );
  }
}