import 'package:flutter/material.dart';
import 'package:dishapp/pages/main_menu/NewRecipe.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xfffeeddd),
        body: SafeArea(
          child: Column(children: [

            /// Search bar
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none
                  ),
                  hintText: 'Search recipe',
                  prefixIcon: Icon(Icons.search),
                ),
              )
            ),

            /// Recycler view
            Container(
              height: 620,
              child: ListView(),
            ),


            /// New recipe
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(left: 0, right: 5.0),
              child: FloatingActionButton.extended(
                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => NewRecipe())); },
                label: Text("New recipe"),
                icon: Icon(Icons.add),
                backgroundColor: Color(0xff59be32),
              )),
          ])
        )
    );
  }
}