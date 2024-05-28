import 'package:dishapp/pages/main_menu/NewRecipeFlow.dart';
import 'package:flutter/material.dart';
import 'package:dishapp/pages/main_menu/NewRecipe.dart';

import 'a.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();

}

List<String> PRUEBA = ["caca", "caca1", "caca3", "caca4", "caca5", "caca6", "caca7", "caca8"];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(left: 0, right: 5.0),
            child: FloatingActionButton.extended(
              onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AddrecipeWidget())); },
              label: Text("New recipe"),
              icon: Icon(Icons.add),
              backgroundColor: Color(0xff59be32),
            )),
        backgroundColor: Color(0xfffeeddd),
        body: SingleChildScrollView(child: SafeArea(
          top: true,
          bottom: true,
          child: Column(children: [

            /// Search bar
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
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

            SizedBox(height: 20,),

            /// Recycler view
            Container(
              height: 650,
              child: GridView.builder(
                itemCount: PRUEBA.length,
                itemBuilder: (context, index){


                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(29)
                    ),
                    child: Column(
                      children: [
                        Row(children: [Text("Usuario")],),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(29)
                          ),
                        ),
                        Row(children: [Text("Las otras cosas")],)
                      ],
                    ),
                  );


                }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
              ),
              ),
            ),



          ])
        ))
    );
  }



}