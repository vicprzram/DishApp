import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dishapp/components/TextFields.dart';

class NewRecipe extends StatefulWidget {

  const NewRecipe({super.key});

  @override
  State<StatefulWidget> createState() => _NewRecipeState();

}

class _NewRecipeState extends State<NewRecipe> {

  ///Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  List listControllersIngredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffeeddd),
      appBar: AppBar(
        backgroundColor: Color(0xfffeeddd),
        title: Text('New Recipe'),
        actions: <Widget>[
          IconButton(onPressed: () {  }, icon: Icon(Icons.save)),
          IconButton(onPressed: () {  }, icon: Icon(Icons.delete))
        ],
      ),
      body: ListView(
        children: [

          const SizedBox(height: 10),

          /// Add photos
          IconButton(onPressed: () {  }, icon: Icon(Icons.add_photo_alternate, size: 70)),

          const SizedBox(height: 35),


          const SizedBox(height: 15),


          const SizedBox(height: 15),

          Card(
            surfaceTintColor: Colors.white,
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                SizedBox(height: 5),

                Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(text: TextSpan(
                              text: 'Ingredients',
                              style: TextStyle(color: Colors.black, decoration: TextDecoration.underline, fontSize: 20),
                          ))
                        ]
                    )
                ),

                SizedBox(height: 10),

                Column(
                  children: [ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listControllersIngredients.length,
                    itemBuilder: (BuildContext context, int index) {
                      return newIngredient();
                    },
                  )]),

                FloatingActionButton(onPressed: generateIngredient),

            ],),
          ),
        ],
      )
    );
  }

  Widget newIngredient(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        SizedBox(
          height: 50,
          width: 280,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder()
            ),
          ),
        )
      ],
    );
  }

  void generateIngredient(){
    TextEditingController controller = TextEditingController();
    setState(() {
      listControllersIngredients.add(controller);
    });
  }
}