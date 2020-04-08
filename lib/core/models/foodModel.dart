import 'package:dio/dio.dart';

class FoodModel{
  String id;
  String title;
  String description;
  String full_description;
  int price;
  String image;
  MultipartFile imageFile;

  FoodModel({
    this.id,
    this.title,
    this.description,
    this.full_description,
    this.price,
    this.image,
    this.imageFile
  });

  factory FoodModel.fromJson(Map<String, dynamic> json){
    return FoodModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      full_description: json['full_description'],
      price: int.parse(json['price'].toString()),
      image: json['image']
    );
  }

  Map<String,dynamic> toMap(){
    var map = Map<String, dynamic>();

    if(id!=null){ map['id'] = id; }

    map['title'] = title;
    map['description'] = description;
    map['full_description'] = full_description;
    map['price'] = price;
    map['image'] = imageFile;

    return map;
  }



}


class FoodResponse{
  int status;
  String message;

  FoodResponse({ this.status, this.message });


  factory FoodResponse.fromJson(Map<String, dynamic> json){
    return FoodResponse(
      status: json['status'],
      message: json['message'],
    );
  }

}