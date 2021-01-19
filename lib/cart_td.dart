import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:Tswkli/cart2.dart';
import 'package:Tswkli/student.dart';
import 'cartListBloc.dart';
import 'foodItem.dart';
import 'listStyleColorBloc.dart';


class Cart extends StatelessWidget {
  static final route = '/Cart';
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
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Container(
                child: CartBody(foodItems),
              ),
            ),
            bottomNavigationBar: Container(color: Colors.white,height: 230,width: 50,child: Fild(),)
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class Fild extends StatefulWidget {
  @override
  _FildState createState() => _FildState();
}

class _FildState extends State<Fild> {
  var _ControlerName = new TextEditingController();
  var _ControlerPhone = new TextEditingController();
  var _ControlerLocation = new TextEditingController();
  var _ControlerNote = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(5),
        color: Colors.white,
        height: 33,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child:TextFormField(
              controller: _ControlerName,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  filled: true,
                  fillColor: Colors.black.withAlpha(300),
                  icon: Icon(Icons.account_circle,size: 28,),
                  hintText: 'الاسم الثلاثي',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  labelText: 'الاسم',
                  labelStyle: TextStyle(fontSize: 15,color: Colors.black)
              ),
            ),),
      ),
      //SizedBox(height: 6,),
      Container(
        margin: EdgeInsets.all(5),
        color: Colors.white,
        height: 33,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              controller: _ControlerPhone,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  filled: true,
                  fillColor: Colors.black.withAlpha(300),
                  icon: Icon(Icons.settings_phone_rounded,size: 28,),
                  hintText: 'ادخل رقم موبايل فعال',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  labelText: 'رقم الموبايل',
                  labelStyle: TextStyle(fontSize: 15,color: Colors.black)
              ),
            ),),
      ),
      Container(
        margin: EdgeInsets.all(5),
        color: Colors.white,
        height: 33,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child:TextFormField(
              controller: _ControlerLocation,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  filled: true,
                  fillColor: Colors.black.withAlpha(300),
                  icon: Icon(Icons.location_on_outlined,size: 28,),
                  hintText: 'العنوان',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  labelText: 'العنوان',
                  labelStyle: TextStyle(fontSize: 15,color: Colors.black)
              ),
            ),),
      ),
      Container(
        margin: EdgeInsets.all(5),
        color: Colors.white,
        height: 33,
        child: Directionality(
        textDirection: TextDirection.rtl,
         child: TextFormField(
      controller: _ControlerNote,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          filled: true,
          fillColor: Colors.black.withAlpha(300),
          icon: Icon(Icons.notes,size: 28,),
          hintText: 'قم بأدخال ملاحظه',
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
          labelText: 'ملاحظة',
          labelStyle: TextStyle(fontSize: 15,color: Colors.black)
      ),
    ),),
      ),
      Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.red,width: 3),
        ),
          child: FlatButton.icon(
              splashColor: Colors.red[300],
              icon: Icon(Icons.send_outlined),
              label:
              Text(
                'ارسال الطلبية',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 17),),
              onPressed: (){
                Navigator.
                pushReplacementNamed(context, Cartttttt.route, arguments: Student(
                    name: '${_ControlerName.text}',
                    phone: '${_ControlerPhone.text}',
                    location: '${_ControlerLocation.text}',
                    note: '${_ControlerNote.text}',
                ));})
      )
    ],);
  }
}

class BottomBar extends StatelessWidget{
  final List<FoodgItem> foodItems;
  BottomBar(this.foodItems);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(foodItems),
        ],
      ),
    );
  }
  Container totalAmount(List<FoodgItem> foodItem) {
    return Container (
      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "المجموع",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400
            ),
          ),
          Text(
            "${returnTotalAmount(foodItem)}",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 22
            ),
          )
        ],
      ),
    );
  }
  String returnTotalAmount(List<FoodgItem> foodItem,){
    double totalAmount = 0;
    for (var i =0; i < foodItem.length; i ++){
      totalAmount = totalAmount + foodItem[i].userId * foodItem[i].quantity;
    }
    return totalAmount.toStringAsFixed(2);
  }
}



class CartBody extends StatelessWidget {
  final List<FoodgItem> foodItems;
  CartBody(this.foodItems);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(foodItems),
          Divider(
            height: 1,
            color: Colors.red[700],
          ),
          BottomBar(foodItems),
          title(),
          Expanded(
            flex: 1,
            child: foodItems.length > 0 ? foodItemsList() : noItemsContainer(),
          )
        ],
      ),
    );
  }

  Container noItemsContainer() {
    return Container(
      child: Center(
        child: Text(
          "لم تتم اضافة اي طلب بعد",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              fontSize: 20
          ),
        ),
      ),
    );
  }

  ListView foodItemsList(){
    return ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (builder, index) {
          return CartListItem(foodItem: foodItems[index]);
        }
    );
  }

  Widget title () {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "السلة",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 2,),
              Container(height: 1,width: 50,color: Colors.black26,)
            ],
          )
        ],
      ),
    );
  }

}

class CartListItem extends StatelessWidget {

  final FoodgItem foodItem;

  CartListItem({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Draggable(
      data: foodItem,
      maxSimultaneousDrags: 1,
      child: DraggableChild(foodItem: foodItem,),
      feedback: DraggableChildFeedback(foodItem: foodItem,),
      childWhenDragging: foodItem.quantity > 1 ? DraggableChild(foodItem: foodItem,) : Container(),
    );
  }
}


class DraggableChild extends StatelessWidget {
  const DraggableChild({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  final FoodgItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(
        foodItem: foodItem,
      ),
    );
  }
}


class DraggableChildFeedback extends StatelessWidget {
  const DraggableChildFeedback({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  final FoodgItem foodItem;

  @override
  Widget build(BuildContext context) {

    final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

    return  Opacity(
      opacity: 0.7,
      child: Material(
        child: StreamBuilder(
          stream: colorBloc.colorStream,
          builder: (context, snapshot) {
            return Container(
              margin: EdgeInsets.only(bottom: 25),
              child: ItemContent(
                foodItem: foodItem,
              ),
              decoration: BoxDecoration(
                color: snapshot.data != null ? snapshot.data : Colors.white,//__________________
              ),
            );
          },
        ),
      ),
    );
  }
}


class ItemContent extends StatelessWidget {

  final FoodgItem foodItem;

  ItemContent({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    //_________________
    final bbody = foodItem.body;//picture
    final ttitle =  foodItem.title;//name
    final pprise = foodItem.userId;//prise
    final number = foodItem.quantity;//number
    //_________________
    // TODO: implement build
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              bbody,//foodItem.body,
              fit: BoxFit.fitHeight,
              height: 55,
              width: 80,
            ),
          ),
          RichText(
            text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(text: number.toString()),
                  TextSpan(text: " X "),
                  TextSpan(text: ttitle)
                ]
            ),
          ),
          Text(
            "\$${number * pprise}",
            style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
    );
  }
}


class CustomAppBar extends StatelessWidget{
  final List<FoodgItem> foodItems;//
  CustomAppBar(this.foodItems);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(5),
            child: IconButton(icon: Icon(CupertinoIcons.back, size: 30,),
                onPressed:(){Navigator.of(context).pop();}
                )
        ),
        DragTargetWidget(),
      ],
    ),);
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

class DragTargetWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DragTargetWidgetState();
  }
}

class _DragTargetWidgetState extends State<DragTargetWidget>  {

  final CartListBloc listBloc = BlocProvider.getBloc<CartListBloc>();
  final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DragTarget<FoodgItem>(
      onWillAccept: (FoodgItem foodItem) {
        colorBloc.setColor(Colors.red);
        return true;
      },
      onAccept: (FoodgItem foodItem) {
        listBloc.removeFromList(foodItem);
        colorBloc.setColor(Colors.white);
      },
      builder: (context, incoming, rejected) {
        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Icon(
              CupertinoIcons.delete,
              size: 30,
            ),
          ),
          onTap: () {},
        );
      },
    );
  }
}

//_________________________________________________________________________
/*

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:ts_d1/cart2.dart';
import 'package:ts_d1/student.dart';
import 'cartListBloc.dart';
import 'foodItem.dart';

class Cart extends StatelessWidget {
  static final route = '/Cart';
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  @override
  Widget build(BuildContext context) {
    List<FoodgItem> foodItems;
    // TODO: implement build
    return StreamBuilder(
      stream: bloc.ListStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          foodItems = snapshot.data;
          return Scaffold(
            body: Container(
              color: Colors.cyanAccent,
                child: CartBody(foodItems),
              ),
              bottomNavigationBar: Container(color: Colors.deepPurpleAccent,height: 200,width: 50,child: Fild(),)
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class Fild extends StatefulWidget {
  @override
  _FildState createState() => _FildState();
}

class _FildState extends State<Fild> {
  var _tControler1 = new TextEditingController();
  var _tControler2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      IconButton(icon: Icon(Icons.access_alarm), onPressed: (){Navigator.pushNamed(context, Cartttttt.route, arguments: Student(name: '${_tControler1.text}', age: '${_tControler2.text}'));}),
      TextField(
      controller: _tControler1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
          labelText: "Enter your name"
      ),
    ),
      TextField(
        controller: _tControler2,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            labelText: "Enter your phone Number"
        ),
      ),
    ],);
  }
}



class CartBody extends StatelessWidget {
  final List<FoodgItem> foodItems;
  CartBody(this.foodItems);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 500,
      width: 400,
      padding: EdgeInsets.fromLTRB(35, 40, 25, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(foodItems),
          Expanded(
            flex: 1,
            child: foodItems.length > 0 ? foodItemsList() : noItemsContainer(),
          )
        ],
      ),
    );
  }

  Container noItemsContainer() {
    return Container(
      child: Center(
        child: Text(
          "No more items in the cart",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              fontSize: 20
          ),
        ),
      ),
    );
  }

  ListView foodItemsList(){
    return ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (builder, index) {
          return Column(children: [
            ItemContent(foodItem: foodItems[index],),
          ],);
        }
    );
  }
}

class ItemContent extends StatelessWidget {

  final FoodgItem foodItem;

  ItemContent({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    //_________________
    final bbody = foodItem.body;//picture
    final ttitle =  foodItem.title;//name
    final pprise = foodItem.userId;//prise
    final number = foodItem.quantity;//number
    //_________________
    // TODO: implement build
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              bbody,//foodItem.body,
              fit: BoxFit.fitHeight,
              height: 55,
              width: 80,
            ),
          ),
          RichText(
            text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(text: number.toString()),//foodItem.quantity
                  TextSpan(text: " X "),
                  TextSpan(text: ttitle)//TextSpan(text: foodItem.title)
                ]
            ),
          ),
          Text(
            "\$${number * pprise}",//foodItem.userId//number
            style: TextStyle(
                color: Colors.grey[300],
                fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
    );
  }
}


class CustomAppBar extends StatelessWidget{
  final List<FoodgItem> foodItems;
  CustomAppBar(this.foodItems);
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return SingleChildScrollView(child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        //IconButton(icon: Icon(Icons.access_alarm), onPressed: (){Navigator.pushNamed(context, Cartttttt.route, arguments: Student(name: 'abdooooooooo', age: 20));}),
        Padding(
            padding: EdgeInsets.all(5),
            child: IconButton(icon: Icon(
              CupertinoIcons.back, size: 30,),
                onPressed:(){Navigator.of(context).pop();})
        ),
      ],
    ),);
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

*/

