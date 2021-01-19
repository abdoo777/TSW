import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Tswkli/home.dart';

class Registor extends StatefulWidget {
  @override
  _RegistorState createState() => _RegistorState();
}

class _RegistorState extends State<Registor> {
  String _name, _email, _password;
  FirebaseAuth instanse = FirebaseAuth.instance;
  var loginKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: loginKey,
      appBar: AppBar(
        shadowColor: Colors.red,
        elevation: 2,
        backgroundColor: Colors.white,
        title: Text('انشاء حساب جديد',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 40),
                height: MediaQuery.of(context).size.height/4,
                alignment: Alignment.center,
                child: Image.asset('assets/images/logo.png',fit: BoxFit.cover),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    this._name = value;
                  });
                },
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    filled: true,
                    fillColor: Colors.black.withAlpha(300),
                    icon: Icon(Icons.perm_identity_outlined,size: 38,),
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    labelText: 'الاسم',
                    labelStyle: TextStyle(fontSize: 15,color: Colors.black)
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    this._email = value;
                  });
                },
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    filled: true,
                    fillColor: Colors.black.withAlpha(300),
                    icon: Icon(Icons.alternate_email_sharp,size: 38,),
                    hintText: 'تأكد من كتابة الايميل بالشكل الصحيح',
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    labelText: 'الايميل',
                    labelStyle: TextStyle(fontSize: 15,color: Colors.black)
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    this._password = value;
                  });
                },
                textCapitalization: TextCapitalization.words,
                obscureText: true,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    filled: true,
                    fillColor: Colors.black.withAlpha(300),
                    icon: Icon(Icons.vpn_key_outlined,size: 38,),
                    hintText: 'قم بكتابة كلمة مرور قويه (ستة رموز كحد ادنى)',
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    labelText: 'كلمة المرور',
                    labelStyle: TextStyle(fontSize: 15,color: Colors.black)
                ),
              ),
              Expanded(child: Container(height: 0,)),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colors.red,width: 2),
                ),
                child: FlatButton.icon(
                    splashColor: Colors.red[300],
                    icon: Icon(Icons.login),
                    label:  Text('انشاء الحساب و تسجيل الدخول',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 17)),
                    onPressed: () async{
                      try{
                        UserCredential credential =
                        await instanse.createUserWithEmailAndPassword(
                            email: this._email, password: this._password);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                      }on FirebaseAuthException catch (e){
                        if(e.code == 'weak-password'){
                          loginKey.currentState.showSnackBar(
                              SnackBar(content: Text('كلمة المرور المدخلة غير قوية'))
                          );
                        } else if(e.code == 'email_already_in_use'){
                          loginKey.currentState.showSnackBar(
                              SnackBar(content: Text('تم اسخدام هذا الايميل سابقا'))
                          );
                        }
                        loginKey.currentState.showSnackBar(
                            SnackBar(content: Text('هنالك خطأ ما حاول مجددا'))
                        );
                      }
                    }
                ),
              ),
              Expanded(child: Container(height: 0,)),
              Expanded(child: Container(height: 0,))
            ],),),
      ),
    );
  }
}