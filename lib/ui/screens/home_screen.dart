import 'package:flutter/material.dart';
import 'package:restofoods/core/models/foodModel.dart';
import 'package:restofoods/core/services/foodServices.dart';
import 'package:restofoods/ui/screens/add_screen.dart';
import 'package:restofoods/ui/screens/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restofoods"),
        leading: Icon(Icons.fastfood, color: Colors.white),
        actions: <Widget>[
          InkWell(
            child: Icon(Icons.add_circle, color: Colors.white),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => AddScreen()
              ));
            },
          )
        ],
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Daftar Menu"),
              ListMenu(),
            ],
          ),
        ));
  }
}

class ListMenu extends StatefulWidget {
  @override
  _ListMenuState createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {

  List<FoodModel> foods;

  Future<void> loadData() async {
    var _foods = foods = await FoodServices.getAll();
    setState(() {
      foods = _foods;
    });
  }

  @override
  void initState() { 
    super.initState();
    this.loadData();
  }


  @override
  Widget build(BuildContext context) {
    
    if(foods==null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: foods.length,
        itemBuilder: (context,index){

          return Padding(
            padding: EdgeInsets.only(bottom:10),
            child: Card(
              elevation: 1,
              child: InkWell(
                onTap: (){


                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      foodModel: foods[index],
                    )
                  ));


                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      //gambar
                      Container(
                        width: 64,height: 64,
                        child: Image.network(
                          foods[index].image,
                          fit: BoxFit.cover,
                        ),

                      ),

                      SizedBox(width: 10,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text(foods[index].title),
                          SizedBox(height: 5,),
                          
                          Container(
                            width:MediaQuery.of(context).size.width * 0.5,
                            child: Text(foods[index].description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,),
                          ),

                           Container(
                            width:MediaQuery.of(context).size.width * 0.6,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(foods[index].price.toString())),
                          ),                         


                        ],
                      )


                  ],),
                ),
              ),
            ),
          );


        },
      )
    );




  }
}