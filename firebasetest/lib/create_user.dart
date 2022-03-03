import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class creteUser extends StatefulWidget {
  creteUser({Key? key}) : super(key: key);

  @override
  State<creteUser> createState() => _creteUserState();
}

class _creteUserState extends State<creteUser> {
  bool _switchValue=true;
  String name = "";
  String password = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passcontraller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference kullanicilar =
        FirebaseFirestore.instance.collection("kullanıcılar");
    return Scaffold(
      appBar: AppBar(title: Text("Kullanıcı"),backgroundColor: Color(0xff7247d4),centerTitle: true,),
      backgroundColor: Color(0xff7247d4),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text(
                          "Kullanıcı Oluştur",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(height: 30,),
                        Container(
              child: TextField(
                onChanged: (value) {
                  name = value;
                  setState(() {});
                },
                
                controller: namecontroller,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
      borderSide: new BorderSide(color: Colors.teal)
    ),
                    
                    hintText: "Kullancı Adı",
                    prefixIcon: Icon(Icons.search),
                    ),
              ),
            ),

            SizedBox(height: 30,),

            Container(
              child: TextField(
                onChanged: (value) {
                  password = value;
                  setState(() {});
                },
                controller: passcontraller,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
      borderSide: new BorderSide(color: Colors.white)
    ),
                    
                    hintText: "Şifre",
                    prefixIcon: Icon(Icons.search),
                    ),
              ),
            ),

            SizedBox(height: 30,),
             Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
               Text("Kullanıcı Yönetici Yetkisi :"),
               CupertinoSwitch(
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            )
             ],),
            SizedBox(height: 30,),
            RaisedButton(
  color: Color(0xff7247d4), // background
  textColor: Colors.white, // foreground
  onPressed: () {
    var bytes1 = utf8.encode(passcontraller.text);
    var test = sha256.convert(bytes1); 
    var postData = {'kullanici_adi' : namecontroller.text,'sifre': test.toString(),'yetki' :_switchValue};
    kullanicilar.add(postData);

   },
  child: Text('Kaydet'),
  
  
)
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}