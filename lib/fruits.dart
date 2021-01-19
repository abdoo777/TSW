import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:Tswkli/cart_td.dart';
import 'cartListBloc.dart';
import 'foodItem.dart';

class Page2 extends StatelessWidget {
  static final route = '/Page2';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]
    );
    return Home();
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  FoodItemList foodItemList = FoodItemList();
  bool isLoading = true;
  initData() async {
    await foodItemList.getd();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: false,
              leading:IconButton(icon: Icon(Icons.arrow_back_ios,size: 26,), onPressed: (){
                if (Navigator.of(context).canPop()){
                  Navigator.of(context).pop();
                }else{
                  showDialog(context: context, builder: (context) => AlertDialog(content: Text(' Can not pop'),));
                }
              }),
              toolbarHeight: 46,
              actions: [
                IconButton(icon: Icon(Icons.shopping_cart,size: 26,), onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
                }),
                SizedBox(width: 10,),
              ],
              iconTheme: IconThemeData(color: Colors.red,size: 28),
              backgroundColor: Colors.white,
              elevation: 1,
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height/3.8,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: MediaQuery.of(context).size.height/3.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/m8.jpg'), fit: BoxFit.cover),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                  ),
                ),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate(
                <Widget>[
                  Container(child: Column(
                    children:[
                      !isLoading
                          ? SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var foodItem in foodItemList.fooddItems)
                              ItemContainer(foodItem: foodItem),
                    ],),
                      )
                          : Center(child: CircularProgressIndicator()),
                  ],),)
                ]
            ))
          ],
        )
    );
  }
}


class ItemContainer extends StatelessWidget{
  final FoodgItem foodItem;//__________
  ItemContainer({this.foodItem});

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  addToCart(FoodgItem foodItem){//____________
    bloc.addToList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        addToCart(foodItem);

        final snackbar = SnackBar(
          content: Text("  تم اضافة  ${foodItem.title} الى السلة "),
          duration: Duration(milliseconds: 300),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      },
      child: Items(
        itemName: foodItem.title,
        itemPrice: foodItem.userId,
        imageUrl: foodItem.body,
      ),
    );
  }
}

class Items extends StatelessWidget {

  final String itemName;
  final int itemPrice;
  final String imageUrl;

  Items({
    @required this.itemName,
    @required this.itemPrice,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 6,
        color: Colors.white,
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height / 6,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(offset: Offset(0.0, 7.0,),
                  blurRadius: 10,
                  color: Colors.black.withAlpha(600))
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 0, left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$itemName', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('$itemPrice', style: TextStyle(fontSize: 25),),
                        SizedBox(width: 10,),
                        InkWell(
                          //onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(
                                  'assets/images/pluse.png'),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(100.0)),
                              border: Border.all(color: Colors.red, width: 1),
                            ),
                            height: 30,
                            width: 30,
                          ),
                        )
                      ],
                    )
                  ],),
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 6,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(image: NetworkImage(imageUrl),),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}