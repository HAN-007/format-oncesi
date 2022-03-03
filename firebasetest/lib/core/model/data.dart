

import 'package:firebasetest/main.dart';
import 'package:firebasetest/main.dart';
class postModel {
  String? price;
  String? name;
  String? id;
  double? indirim;

  postModel(this.price, this.name, this.id, this.indirim);
}

late List<tedaviModel> listem;

doldur(List<tedaviModel> model) {
  listem = model;
}
