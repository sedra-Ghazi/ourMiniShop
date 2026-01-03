import 'dart:convert';

class CategoryModel {
  String? categoryname;
  String? desciption;
  int? productcount;
  String  ?id;

  CategoryModel({this.categoryname, this.desciption, this.productcount, required this.id });

  CategoryModel.fromJson(Map<String, dynamic> json) {
     categoryname = json['categoryname'];
    desciption = json['desciption'];
    productcount = json['productcount'];
    id = json["id"]?.toString()?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryname'] = this.categoryname;
    data['desciption'] = this.desciption;
    data['productcount'] = this.productcount;
    data['id'] = this.id;
    return data;
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryname: map['category'] ?? '',
      desciption: map['desciption'] ?? '',
      productcount: map['count'],
      id: map['id']?.toString()?? '',

    );
  }
  Map<String, dynamic> toMap() {
    return {
      'categoryname': categoryname,
      'description': desciption,
      'productcount': productcount,
      'id': id,
    };
  }
   static String encode(List<CategoryModel> list) {
    return jsonEncode(
      list.map((item) => item.toMap()).toList(),
    );
  }

 
  static List<CategoryModel> decode(String jsonString) {
   
      final List<dynamic> decodedList = jsonDecode(jsonString);
      return decodedList
          .map((item) => CategoryModel.fromMap(item as Map<String, dynamic>))
          .toList();
    
  }
}
