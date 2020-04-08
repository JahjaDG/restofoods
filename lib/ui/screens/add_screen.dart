import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restofoods/core/models/foodModel.dart';
import 'package:restofoods/core/services/foodServices.dart';
import 'package:restofoods/core/utils/toatsUtils.dart';

class AddScreen extends StatelessWidget {

  FoodModel foodModel;
  AddScreen({this.foodModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Foods")
      ),
      body: AddBody(foodModel: foodModel,),

    );
  }
}

class AddBody extends StatefulWidget {

  FoodModel foodModel;
  AddBody({this.foodModel});

  @override
  _AddBodyState createState() => _AddBodyState();
}

class _AddBodyState extends State<AddBody> {

  File image;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var fullDescriptionController = TextEditingController();
  var priceController = TextEditingController();

  void imagePick()async{
    var _image = await ImagePicker.pickImage(source: ImageSource.camera);
    if(_image != null){
      setState(() {
        image = _image;
      });
    }
  }

  void createFoods()async{
    if(titleController.text.isNotEmpty){

      var foodData = FoodModel(
        title: titleController.text,
        description: descriptionController.text,
        full_description: fullDescriptionController.text,
        price: int.parse(priceController.text),
        imageFile: await MultipartFile.fromFile(image.path),
      );

      ToastUtils.show("Saving ...");

      FoodResponse response = await FoodServices.createFood(foodData);
      if(response.status==200){
        ToastUtils.show(response.message.toString());

       Future.delayed(Duration(seconds: 1),(){
        Navigator.pushNamedAndRemoveUntil(context, "/home", (Route<dynamic> routes) => false);
      });       
        
      }else{
        ToastUtils.show(response.message.toString());
      }



    }else{
      ToastUtils.show("Please fill all field");
    }
  }



  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
              child: Column(
          children: <Widget>[

            Container(
              child: InkWell(
                onTap: (){
                  imagePick();
                },
                child: image == null ?
                Icon(Icons.add_photo_alternate,size: 50,) :
                Image.file(image)
              ),
            ),


            TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "title"),
              controller: titleController,
            ),

            TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "description"),
              controller: descriptionController,
            ),

            TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "full description"),
              controller: fullDescriptionController,
            ),

            TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "price"),
              controller: priceController,
            ),

            SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width*0.9,
                          child: RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Text("Add Foods", style: TextStyle(color: Colors.white),),
                onPressed: (){
                  createFoods();
                },
              ),
            )


          ],
        ),
      ),
    );
  }
}