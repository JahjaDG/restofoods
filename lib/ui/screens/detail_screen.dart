import 'package:flutter/material.dart';
import 'package:restofoods/core/models/foodModel.dart';
import 'package:restofoods/core/services/foodServices.dart';
import 'package:restofoods/core/utils/toatsUtils.dart';
import 'package:restofoods/ui/screens/update_screen.dart';

class DetailScreen extends StatelessWidget {
  FoodModel foodModel;
  DetailScreen({this.foodModel});


  Future<void> deleteFoods(BuildContext context) async {
    FoodResponse response = await FoodServices.deleteFood(foodModel.id);
    if(response.status == 200){
      ToastUtils.show(response.message);

      Future.delayed(Duration(seconds: 1),(){
        Navigator.pushNamedAndRemoveUntil(context, "/home", (Route<dynamic> routes) => false);
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodModel.title),
        actions: <Widget>[

          InkWell(
            child: Icon(Icons.delete, color: Colors.white,),
            onTap: (){
              deleteFoods(context);
            },
          ),

          InkWell(
            child: Icon(Icons.edit, color: Colors.white,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => UpdateScreen(
                  foodModel: foodModel
                )
              ));
            },
          ),


        ],
      ),
      body: DetailBody(
        foodModel: foodModel,
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  FoodModel foodModel;
  DetailBody({this.foodModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[



          Container(
            margin:  EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width*0.9,
                      child: Image.network(
              foodModel.image,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 10,),

          DataTable(columns: [
            DataColumn(label: Text('Detail')),
            DataColumn(label: Text('Menu')),
          ], rows: [
            DataRow(cells: [
              DataCell(Text('Title')),
              DataCell(Text(': '+ foodModel.title)),
            ]),

            DataRow(cells: [
              DataCell(Text('Description')),
              DataCell(Text(': '+ foodModel.description.toString())),
            ]),

            DataRow(cells: [
              DataCell(Text('Price')),
              DataCell(Text(': Rp.  '+ foodModel.price.toString())),
            ]),



          ])
        ],
      ),
    );
  }
}