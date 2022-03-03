import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetest/core/model/data.dart';
import 'package:firebasetest/core/model/postmodel.dart';
import 'package:firebasetest/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

import 'core/model/tedavimodel.dart';




class postDataView extends StatefulWidget {
  List<tedaviModel> postData;
  postDataView({required this.postData});
  @override
  _postDataViewState createState() => _postDataViewState(postData);
}

class _postDataViewState extends State<postDataView> {
  List<tedaviModel> usage;
  _postDataViewState(this.usage);
  var genelToplam = 0.0;
  var tempgele = 0.0;
  RangeValues _values = RangeValues(0.3, 0.7);
  double value = 0;
  int _currentValue = 0;
  var hastaAdi = TextEditingController();
  var hayvanAdi = TextEditingController();
  List yourItemList = [];
  Autogenerated asd = Autogenerated();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < usage.length; i++) {
      var temp = double.parse(usage[i].price.toString());
      print(temp);
      genelToplam = genelToplam + temp;
      tempgele = genelToplam;
    }
    print(genelToplam.toString());
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference hastalar =
        FirebaseFirestore.instance.collection("hastalar");
        CollectionReference yatanHastalar =
        FirebaseFirestore.instance.collection("yatanHastalar");
        CollectionReference tedavilerinst =
        FirebaseFirestore.instance.collection("tedaviler");
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      onwill: false,
                    )));
        return false;
     
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              
              heroTag: null,
              child: Text("Yatan"),
              onPressed: () {
                DateTime now = DateTime.now();
                String formattedDate = "2022-02-12";
                asd.hastaAdi = hastaAdi.text.toString();
                asd.hayvanAdi = hayvanAdi.text.toString();
                asd.toplamFiyat = genelToplam.toString();
                asd.yatisZamani = formattedDate;
                List<Tedaviler> qweqwe = [];
                //conver json
                for (int i = 0; i < usage.length; i++) {
                  Tedaviler temptedavi = Tedaviler(
                      id: usage[i].id,
                      name: usage[i].name,
                      price: double.parse(usage[i].price.toString()),
                      skt: usage[i].skt,
                      stok: int.parse(usage[i].stok.toString()) -1,
                      ustId: usage[i].ustId
                      );
                  
                 
                  getData(temptedavi);
                  //debugPrint(yourItemList.toString());
                  qweqwe.add(temptedavi);
                  // asd.tedaviler?.add(temptedavi);
                  //debugPrint(temptedavi.name.toString() + "sdadasd");
                }
                asd.tedaviler = qweqwe;
                var tempjson = asd.toJson();
               // debugPrint(asd.tedaviler![0].name.toString() + "gönderiler");
                yatanHastalar.add(tempjson);
                
              },
            ),
            
            FloatingActionButton(
              heroTag: null,
              child: Text("Hızlı"),
              onPressed: () {
                DateTime now = DateTime.now();
                String formattedDate = "2022-02-12";
                asd.hastaAdi = hastaAdi.text.toString();
                asd.hayvanAdi = hayvanAdi.text.toString();
                asd.toplamFiyat = genelToplam.toString();
                asd.yatisZamani = formattedDate;
                List<Tedaviler> qweqwe = [];
                //conver json
                for (int i = 0; i < usage.length; i++) {
                  Tedaviler temptedavi = Tedaviler(
                      id: usage[i].id,
                      name: usage[i].name,
                      price: double.parse(usage[i].price.toString()),
                      skt: usage[i].skt,
                      stok: int.parse(usage[i].stok.toString()) -1,
                      ustId: usage[i].ustId
                      );
                  
                 
                  getData(temptedavi);
                  //debugPrint(yourItemList.toString());
                  qweqwe.add(temptedavi);
                  // asd.tedaviler?.add(temptedavi);
                  //debugPrint(temptedavi.name.toString() + "sdadasd");
                }
                asd.tedaviler = qweqwe;
                var tempjson = asd.toJson();
               // debugPrint(asd.tedaviler![0].name.toString() + "gönderiler");
                hastalar.add(tempjson);
                
              },
            ),
          ],
          
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Hasta Bilgileri",
            style: TextStyle(
              color: Color(0xff7247d4),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: hastaAdi,
                  decoration: InputDecoration(
                    hintText: "Müşteri Adı",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          BorderSide(color: Color(0xff7247d4), width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          BorderSide(color: Color(0xff7247d4), width: 3),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: hayvanAdi,
                  decoration: InputDecoration(
                    hintText: "Hayvan İsmi",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          BorderSide(color: Color(0xff7247d4), width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          BorderSide(color: Color(0xff7247d4), width: 3),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                    child: Center(
                        child: ListView.builder(
                  itemCount: usage.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Color(0xff7247d4),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white)),
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Center(
                          child: Text(
                        usage[index].name.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                    );
                  },
                ))),
              ),
              Expanded(
                  flex: 1,
                  child: Text(
                    "Toplam Fiyat :" + genelToplam.toStringAsFixed(2),
                    style: TextStyle(fontSize: 20),
                  )),
              Expanded(
                flex: 2,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      if (value != "") {
                       
                          genelToplam = tempgele + int.parse(value);
                        
                      } else {
                        genelToplam = tempgele;
                      }
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Kar",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          BorderSide(color: Color(0xff7247d4), width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          BorderSide(color: Color(0xff7247d4), width: 3),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(),)
            ],
          ),
        ),
      ),
    );
  }
}
CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('tedaviler');

Future<void> getData(Tedaviler temptedavi) async {
    // Get docs from collection reference1
    

    //DocumentReference docRef = FirebaseFirestore.instance.collection("tedaviler").doc(temptedavi.ustId);
    //docRef.update({"value.${temptedavi.id}.stok" : int.parse(temptedavi.stok.toString()) - 1},);
    //FirebaseFirestore.instance.collection("tedaviler").doc(temptedavi.ustId);
  debugPrint(eklenecekUstfield.length.toString());
  List<dynamic> templist = [];
  for(int i = 0;i<eklenecekUstfield.length;i++){
    if(temptedavi.id == eklenecekUstfield[i].id){
        eklenecekUstfield[i].stok = (int.parse(eklenecekUstfield[i].stok.toString()) - 1).toString();
    }
    templist.add(eklenecekUstfield[i].toJson());
  }
  
  FirebaseFirestore.instance.collection("tedaviler").doc(temptedavi.ustId).update({"value":templist});
 //List<dynamic> elements = [];
 //elements.add(temptedavi);
 //FirebaseFirestore.instance.collection("tedaviler").doc(temptedavi.ustId).update({'value.${temptedavi.id}.stok': temptedavi.stok });
 //FirebaseFirestore.instance.collection('tedaviler').where("id",arrayContains: temptedavi.ustId).where(field)
  //FirebaseFirestore.instance.collection("tedaviler").doc(temptedavi.ustId).update("value", FieldValue.arrayUnion(Tedaviler(stok: int.parse(temptedavi.stok) -1)));

  
  

}
