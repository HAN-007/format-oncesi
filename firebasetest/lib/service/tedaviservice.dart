import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetest/core/model/tedavimodel.dart';
import 'package:flutter/cupertino.dart';

class TedaviService{
  FirebaseFirestore? _instance;
  List<tedaviModelfire> _tedavis = [];
  List<tedaviModelfire> getTedavis(){
    return _tedavis;
  }
  Future<void> getTedavisCollectionsFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference Tedavis = _instance!.collection('tedaviler');
    Stream<QuerySnapshot<Object?>> snapshot = await Tedavis.snapshots();
  // var data = snapshot.map((event) => null)
  // var TedavisData = data['type'] as List<dynamic>;

  // TedavisData.forEach((catData) { 
  //   tedaviModelfire cat = tedaviModelfire.fromJson(catData);
  //   _tedavis.add(cat);
  // });


  //
  
}
}