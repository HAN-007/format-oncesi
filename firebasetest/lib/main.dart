import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/core/model/data.dart';
import 'package:firebasetest/core/model/tedavimodel.dart';
import 'package:firebasetest/post_view.dart';
import 'package:firebasetest/service/tedaviservice.dart';
import 'package:firebasetest/yatan_hasta.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';

import 'create_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        onwill: false,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final bool onwill;
  
  HomePage({Key? key, required this.onwill}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<tedaviModelfire> tedavimodelfire = [];
  String name = "";

  final Stream<QuerySnapshot> tedaviler =
      FirebaseFirestore.instance.collection('tedaviler').snapshots();
  TextEditingController editingController = TextEditingController();
  late QuerySnapshot<Object?> data;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    if (widget.onwill == true) {
      postlist = [];
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => postDataView(
                      postData: postlist,
                    )),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(title: Text("Tedaviler",textAlign: TextAlign.center,),centerTitle: true,backgroundColor: Color(0xff7247d4),),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: TextField(
                onChanged: (value) {
                  name = value;
                  setState(() {});
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Tedavi Ara",
                    hintText: "Tedavi İsmi Yazın",
                    prefixIcon: Icon(Icons.search),
                    ),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color(0xff7247d4),
                child: Center(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: tedaviler,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Have error");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: const CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      );
                    }
                    tedavimodelfire = [];
                    data = snapshot.requireData;
                    List<tedaviModel1> eklenecek = [];
                    List<tedaviModel1> eklenecekUstfield = [];
                    for (int i = 0;i<data.size;i++){
                      for(var temp in data.docs[i]["value"]){
                         tedaviModel1 test1 = tedaviModel1(id: temp['id'].toString(),name: temp['name'].toString(),price: temp['price'].toString(),skt: temp['skt'],stok: temp['stok'].toString());
                          if(test1.name!.contains(name)&&name != ""){
                            eklenecek.add(test1);
                            debugPrint(test1.skt.toString()+"srtokkkk");
                          }
                          if(name==null||name==""){
                            eklenecek.add(test1);
                            
                          }
                          eklenecekUstfield.add(test1);
                          UstFiled(eklenecekUstfield);
                          
                      }
                      if(!eklenecek.isEmpty){
                        tedavimodelfire.add(tedaviModelfire(type: data.docs[i]['type'],subtitle: eklenecek,id: data.docs[i]['id']));
                        debugPrint(data.docs[i]['id']);
                      eklenecek = [];
                      }
                      eklenecek = [];
                      
                    }
                    for(var temp in tedavimodelfire){
                        for(int i =0;i<temp.subtitle!.length;i++){
                          debugPrint(temp.subtitle![i].skt);
                        }
                    }
                    return ListView.builder(
                      itemCount: tedavimodelfire.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            //Color.fromRGBO(136, 85, 255, 1)
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ExpansionTile(
                            title:  Container(
                                child: Center(
                                    child: Text(
                            tedavimodelfire[index].type.toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                            ))),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  //dren: currentTedavi.value!
                                  //.map((e) => Container(
                                  //      height:
                                  //          MediaQuery.of(context).size.height *
                                  //              0.05,
                                  //      color: Color(0xff7247d4),
                                  //      child: InkWell(
                                  //          onTap: () async {
                                  //            setState(() {
                                  //              onPressed = true;
                                  //            });
                                  //            await Future.delayed(
                                  //                const Duration(
                                  //                    milliseconds: 1500));
                                  //            setState(() {
                                  //              onPressed = false;
                                  //            });
                                  //          },
                                  //          child: onPressed
                                  //              ? LottieBuilder.asset(
                                  //                  "assets/animation/add-to-cart.json")
                                  //              : Container(
                                  //                  child: Center(
                                  //                      child: Text(e.name!)))),
                                  //    ))
                                  //.toList())

                                  children: _createDownList(tedavimodelfire[index].subtitle,tedavimodelfire[index].id)),
                                ),
                              
                            ],
                          ),
                        );

                        /*ExpansionTile(
                            title: Container(
                                child: Center(
                                    child: Text(
                          data.docs[index]['type'],
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ))));*/
                      },
                    );
                  },
                )),
              ),
            ),
          ],
        ),
      ),

      drawer:   Drawer(
        backgroundColor: Color(0xff7247d4) ,
        elevation: 10.0,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff7247d4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                  backgroundImage: AssetImage('assets/animation/icon.png'),
                  backgroundColor: Colors.transparent,
                  radius: 40.0,
                ),

                
                  
                ],
              ),
            ),
             ListTile(
              leading: Icon(Icons.add,color: Colors.white,),
              title: Text('Yeni Kullanıcı Ekle', style: TextStyle(fontSize: 18,color: Colors.white)),
              onTap: () {
                Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => creteUser()),
          );

              },
            ),
            ListTile(
              leading: Icon(Icons.home,color: Colors.white,),
              title: Text('Yatan Hastalar', style: TextStyle(fontSize: 18,color: Colors.white)),
              onTap: () {
                Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => yatanHasta()),
          );

              },
            ),
          ],
        ),
      ),
    );
  }

  bool onPressed = false;
  late String _selectedIndex;
  late List<tedaviModel> _listem;
  static late List<tedaviModel> postlist = [];
  _createDownList(var currentTedavi,var ustKategori) {
    List<Widget> columnContent = [];
    
    for(var i = 0;i<currentTedavi.length;i++){
      columnContent.add(Container(
        decoration: BoxDecoration(
            color: Color(0xff7247d4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white)),
        height: MediaQuery.of(context).size.height * 0.07,
        child: InkWell(
            onTap: () async {
              tedaviModel asd = tedaviModel(currentTedavi[i].price.toString(),
                  currentTedavi[i].name.toString(), currentTedavi[i].id.toString(),currentTedavi[i].skt.toString(),currentTedavi[i].stok.toString(),ustKategori);
              postlist.add(asd);
              
              setState(() {
                _selectedIndex = currentTedavi[i].name.toString();
                onPressed = true;
              });
              await Future.delayed(const Duration(milliseconds: 400));
              setState(() {
                onPressed = false;
              });
            },
            child: onPressed && currentTedavi[i].name.toString() == _selectedIndex
                ? LottieBuilder.asset(
                    "assets/animation/add-to-medic.json",
                  )
                : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                        currentTedavi[i].name.toString(),
                        style: TextStyle(color: Colors.white,fontSize: 22),
                  ),
                  Text(
                        currentTedavi[i].price.toString()+"TL",
                        style: TextStyle(color: Colors.white,fontSize: 17),
                  ),
                      ],
                    ))),
      ));
    }
    return columnContent.toList();


    /*for (var temp in currentTedavi) {
      tedaviModel asd = tedaviModel(temp['price'].toString(),
          temp['name'].toString(), temp['id'].toString());
      if(name != "" && name != null){
      if(temp['name']==name){
          model.add(asd);
        }
      }else{
        model.add(asd);
      }
        
    }
    doldur(model);

  

    for (int i = 0; i < model.length; i++) {
      columnContent.add(Container(
        decoration: BoxDecoration(
            color: Color(0xff7247d4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white)),
        height: MediaQuery.of(context).size.height * 0.07,
        child: InkWell(
            onTap: () async {
              tedaviModel asd = tedaviModel(model[i].price.toString(),
                  model[i].name.toString(), model[i].id.toString());
              postlist.add(asd);
              
              setState(() {
                _selectedIndex = model[i].name.toString();
                onPressed = true;
              });
              await Future.delayed(const Duration(milliseconds: 400));
              setState(() {
                onPressed = false;
              });
            },
            child: onPressed && model[i].name.toString() == _selectedIndex
                ? LottieBuilder.asset(
                    "assets/animation/add-to-medic.json",
                  )
                : Center(
                    child: Text(
                    model[i].name.toString(),
                    style: TextStyle(color: Colors.white),
                  ))),
      ));
    }

    return columnContent.toList();*/
  }
}

class anamodel{
  String? type;
  List<tedaviModel>? tedavileri;
  anamodel(this.type,this.tedavileri);
}

class tedaviModel {
  String? ustId;
  String? price;
  String? name;
  String? id;
  String? skt;
  String? stok;
  

  tedaviModel(this.price, this.name, this.id,this.skt,this.stok,this.ustId);
}
