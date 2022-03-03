class tedaviModelfire{
  String? id;
  String? type;
  List<tedaviModel1>? subtitle; 
  
  tedaviModelfire({this.type, this.subtitle,this.id});

  factory tedaviModelfire.fromJson(Map<String, dynamic> json) {

    return tedaviModelfire(
      type: json['type'],
      id: json['id'],
      subtitle: tedaviModel1.fromJsonArray(json['value'])
    );
  }

}

class tedaviModel1 {
  String? price;
  String? name;
  String? id;
  String? skt;
  String? stok;

  tedaviModel1({this.price, this.name, this.id,this.skt,this.stok});

  factory tedaviModel1.fromJson(Map<String, dynamic> json) {

  return tedaviModel1(
      price : json['price'],
      name : json['name'],
      id : json['id'],
      skt: json['skt'],
      stok: json['stok']
    );
  }
    static List<tedaviModel1> fromJsonArray(List<dynamic> jsonArray) {
    List<tedaviModel1> subCategoriesFromJson = [];

    jsonArray.forEach((jsonData) {
      subCategoriesFromJson.add(tedaviModel1.fromJson(jsonData));
    });

    return subCategoriesFromJson;
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['skt'] = this.skt;
    data['stok'] = this.stok;
    return data;
  }


}

List<tedaviModel1>   eklenecekUstfield  =  [];
UstFiled(List<tedaviModel1>  temp){
  eklenecekUstfield = temp;
}
