import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/core/model/data.dart';
import 'package:firebasetest/post_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';

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
  final Stream<QuerySnapshot> tedaviler =
      FirebaseFirestore.instance.collection('tedaviler').snapshots();
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: TextField(
                onChanged: (value) {},
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Tedavi Ara",
                    hintText: "Sınavı olduğun tarihi yaz",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
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
                    final data = snapshot.requireData;
                    return ListView.builder(
                      itemCount: data.size,
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
                            title: Container(
                                child: Center(
                                    child: Text(
                              data.docs[index]['type'],
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

                                  children: _createDownList(
                                      data.docs[index]["value"]),
                                ),
                              )
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
    );
  }

  bool onPressed = false;
  late String _selectedIndex;
  late List<tedaviModel> _listem;
  static late List<tedaviModel> postlist = [];
  _createDownList(var currentTedavi) {
    List<Widget> columnContent = [];
    List<tedaviModel> model = [];
    for (var temp in currentTedavi) {
      tedaviModel asd = tedaviModel(temp['price'].toString(),
          temp['name'].toString(), temp['id'].toString());
      model.add(asd);
    }
    doldur(model);

    debugPrint(model[0].name.toString());

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
              debugPrint(postlist.toString());
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

    return columnContent.toList();
  }
}

class tedaviModel {
  String? price;
  String? name;
  String? id;

  tedaviModel(this.price, this.name, this.id);
}
