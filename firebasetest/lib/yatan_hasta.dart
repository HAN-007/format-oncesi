import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'core/model/postmodel.dart';
import 'service/yatan_hasta_service.dart';

class yatanHasta extends StatefulWidget {
  yatanHasta({Key? key}) : super(key: key);

  @override
  State<yatanHasta> createState() => _yatanHastaState();
}

class _yatanHastaState extends State<yatanHasta> {
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7247d4),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("yatanHastalar").snapshots(),builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
         return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        
      ),
      itemCount: snapshot.data!.docs.length,

       itemBuilder: (context, index) {
         return InkWell(
           onTap: () {
            showDialog(context: context, builder: (BuildContext context) => _buildPopupDialog(context,snapshot.data?.docs[index]['tedaviler'],snapshot.data?.docs[index]['hasta_adi'].toString()));
           },
           child: Card(
             shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(20.0),
           ),
            color: Colors.white,
            child: Center(child: Text(snapshot.data?.docs[index]['hasta_adi'])),
                 ),
         );
       },);
      },),
    );
  }
  Widget _buildPopupDialog(BuildContext context, doc, String? string,) {
  return  AlertDialog(
    title:  Text(string!,textAlign: TextAlign.center,),
    content:  Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
            gettedavis(doc)
          ,
        ),
        
      ],
    ),
    
  );
}

  gettedavis(doc) {
    List<Widget> widgetlist = [];
    for (var i in doc){
      widgetlist.add(Text(i['name']));
    }
    return widgetlist;
  }
 
}

/*ListView(
        children: snapshot.data!.docs.map((document) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 6,
              child: Text("Title: " + document['hasta_adi']),
            ),
          );
        }).toList(),
      ): */