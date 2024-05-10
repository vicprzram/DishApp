import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewRecipe extends StatefulWidget {

  const NewRecipe({super.key});

  @override
  State<StatefulWidget> createState() => _NewRecipeState();

}

class _NewRecipeState extends State<NewRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfffeeddd),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('New recipe'),
              backgroundColor: Color(0xfffeeddd),
              actions: [
                IconButton(
                    onPressed: () {  },
                    icon: Icon(Icons.save)),
                IconButton(
                    onPressed: () {  } ,
                    icon: Icon(Icons.delete))
              ],
            ),
            SliverFixedExtentList(
              itemExtent: 150.0,
              delegate: SliverChildListDelegate(
                [
                  /// Add photos
                  Container(
                    child: IconButton(
                      onPressed: () {  },
                      icon: Icon(Icons.add_photo_alternate, size: 100,),

                    ),
                  ),

                  

                  Container(color: Colors.green),
                  Container(color: Colors.orange),
                  Container(color: Colors.yellow),
                  Container(color: Colors.pink),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}