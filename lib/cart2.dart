import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:Tswkli/student.dart';
import 'cartListBloc.dart';
import 'foodItem.dart';

class Cartttttt extends StatefulWidget {
  static final route = '/Cart2';

  final FirebaseApp app;
  Cartttttt({this.app});

  @override
  _CarttttttState createState() => _CarttttttState();
}

class _CarttttttState extends State<Cartttttt> {

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]
    );
    List<FoodgItem> foodItems;
    // TODO: implement build
    return StreamBuilder(
      stream: bloc.ListStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          foodItems = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.black12,
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  leading: Text(''),
                  floating: false,
                  toolbarHeight: 46,
                  iconTheme: IconThemeData(color: Colors.red,size: 28),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  pinned: true,
                  expandedHeight: MediaQuery.of(context).size.height,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      alignment: Alignment.center,
                      color: Colors.grey,
                      child: Container(
                            margin: EdgeInsets.fromLTRB(30, MediaQuery.of(context).size.width/3, 30, MediaQuery.of(context).size.width/3),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(40.0)),
                              border: Border.all(color: Colors.red,width: 1),
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('تم أستلام الطلبية',style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  IconButton(icon: Icon(Icons.assignment_turned_in_sharp,size: 40,color: Colors.green,), onPressed: null),
                                  Text('بنجاح', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 45, color: Colors.green),),
                                ],),
                                Expanded(child: SizedBox(height: 1,),),
                                InkWell(
                                  onTap: (){
                                    SystemNavigator.pop();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.width/6,
                                    width: MediaQuery.of(context).size.width/1.2,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage(
                                          'assets/images/frut.jpg'
                                      ),
                                          fit: BoxFit.cover),
                                      color: Colors.orange.shade400,
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      border: Border.all(color: Colors.red,width: 1),
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: MediaQuery.of(context).size.width/8.4,
                                      width: MediaQuery.of(context).size.width/1.8,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(150),
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          border: Border.all(color: Colors.black,width: 1)
                                      ),
                                      child: Text('الخروج من التطبيق',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                    ),
                                  ),
                                ),
                                Expanded(child: SizedBox(height: 1,),),
                              ],
                            ))
                          )
                    ),
                  ),
                ),
                SliverList(delegate: SliverChildListDelegate(
                    <Widget>[
                      Container(
                          height: 0,
                          color: Colors.cyanAccent,
                          child: New2(foodItems)
                      ),
                    ]
                ))
              ],
            )
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class New extends StatelessWidget {
  final referenseDatase = FirebaseDatabase.instance;
  final movieName = 'MovieTitle';
  final FoodgItem foodItem;
  New({@required this.foodItem});
  @override
  Widget build(BuildContext context) {
    Student student = ModalRoute.of(context).settings.arguments;
    final ref  = referenseDatase.reference();//هاي الي ترسل الاسماء للقاعده
    ref.child('${student.name} / ${student.phone} / ${student.location} / ${student.note}').push().child('items').set('${foodItem.userId} | ${foodItem.title} | ${foodItem.quantity}').asStream();
    print('${foodItem.userId} | ${foodItem.title} | ${foodItem.id} | ${foodItem.quantity}');
    return Container();
  }
}

class New2 extends StatelessWidget {
  final List<FoodgItem> foodItems;
  New2(this.foodItems);
  @override
  Widget build(BuildContext context) {
    Student student = ModalRoute.of(context).settings.arguments;
    print('${student.name} ????? ${student.note}');
    return Column(
        children: <Widget>[
          Expanded(
          flex: 1,
           child: foodItems.length > 0 ? foodItemsList() : Container()
    )
        ]
    );
  }
  ListView foodItemsList(){
    return ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (builder, index) {
          return New(foodItem: foodItems[index],);
        }
    );
  }
}