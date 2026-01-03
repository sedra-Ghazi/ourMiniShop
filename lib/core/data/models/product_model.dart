import 'dart:convert';


class ProductModel {
  String? category;
  String? name;
  String? desciption;
  int? price;
  int? count;
  String? image;
  bool? isavilable;
  String? id;

  ProductModel(
      {this.category,
      this.name,
      this.desciption,
      this.price,
      this.count,
      this.image,
      this.isavilable,
      this.id,});

  ProductModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    name = json['name'];
    desciption = json['desciption'];
    price = json['price'];
    count = json['count'];
    image = json['image'];
    isavilable = json['isavilable'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['name'] = this.name;
    data['desciption'] = this.desciption;
    data['price'] = this.price;
    data['count'] = this.count;
    data['image'] = this.image;
    data['isavilable'] = this.isavilable;
    return data;

  }


  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      category: map['category'] ?? '',
      name: map['name'] ?? '',
      desciption: map['desciption'] ?? '',
      price: map['price'],
      count: map['count'],
      image: map['image']??"assets/aurathexplaura.jpg",
      isavilable: map['isavilable'],
      id: map['id']?.toString()?? '',

    );
  }
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'name': name,
      'description': desciption,
      'price': price,
      'count': count,
      'image': image,
      'isavilable': isavilable,
      'id': id,
    };
  }
   static String encode(List<ProductModel> list) {
    return jsonEncode(
      list.map((item) => item.toMap()).toList(),
    );
  }

 
  static List<ProductModel> decode(String jsonString) {
   
      final List<dynamic> decodedList = jsonDecode(jsonString);
      return decodedList
          .map((item) => ProductModel.fromMap(item as Map<String, dynamic>))
          .toList();
    
  }
}
