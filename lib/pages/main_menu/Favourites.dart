import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavouritesModel extends FlutterFlowModel<FavouritesWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}


class FavouritesWidget extends StatefulWidget {
  const FavouritesWidget({super.key});

  @override
  State<FavouritesWidget> createState() => _FavouritesWidgetState();
}

class _FavouritesWidgetState extends State<FavouritesWidget> {
  late FavouritesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> items = [];
  List<String> documents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FavouritesModel());

    addItem();
  }

  @override
  void dispose() {
    _model.dispose();
    items = [];
    documents = [];

    super.dispose();
  }
  
  void deleteItem(String doc, int index){
    setState(() {
      documents.remove(doc);
      items.removeAt(index);
      FirebaseFirestore.instance.collection("favourites").doc(FirebaseAuth.instance.currentUser!.displayName.toString()).update({
        "recipes": documents
      });
    });

  }

  void addItem() async {

    var data = await FirebaseFirestore.instance.collection('favourites').doc(FirebaseAuth.instance.currentUser!.displayName).get();
    var data2;

    print(data.data()?.values.elementAt(0).length);
    print(data.data()?.values.length);

    for(int i = 0; i < data.data()!.values.elementAt(0).length; i++){
      print(data.data()!.values.elementAt(0)[i]);
      documents.add(data.data()!.values.elementAt(0)[i]);
    }

    documents.forEach((element) async {
      print("F: " + element.toString());
      data2 = await FirebaseFirestore.instance.collection('recipes').doc(element.toString()).get();
      items.add(data2.data());
    });

    setState(() {
      isLoading = false;
      print("cargo");
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xfffeeddd),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Favourites',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Ginger_Cat',
                      letterSpacing: 0,
                      fontWeight: FontWeight.w100,
                      useGoogleFonts: false,
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),

                FutureBuilder(
                  future: Future.delayed(Duration(milliseconds: 300)),
                  builder: (ctx, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? CircularProgressIndicator() :
                    (items.length == 0) ? Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),

                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'lib/images/no_data.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )) : Expanded(
                    child: (isLoading) ? CircularProgressIndicator() : GridView.builder(
                      itemBuilder: (context, index) {

                        return  InkWell(
                          onTap: (){

                            print(documents[index]);

                          },
                          child:  Container(
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff59be32)),
                                borderRadius: BorderRadius.circular(29),
                                color: Colors.white
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                    child: RichText(
                                      text: TextSpan(text: items[index]["title"], style: TextStyle(fontFamily: 'Outfit', color: Colors.black),),
                                    ),
                                  ),),
                                Expanded(
                                  child: Container(
                                    child: Image.network(items[index]["image"], fit: BoxFit.fill),
                                  ),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 20),
                                        child: RichText(
                                          text: TextSpan(text: "@" + items[index]["user"], style: TextStyle(fontFamily: 'Outfit', color: Colors.black, fontSize: 12),),
                                        ),
                                      ),),



                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 5),
                                            child: Container(
                                              child: InkWell(
                                                child: Icon(Icons.delete_forever, color: Colors.red),
                                                onTap: () {
                                                  deleteItem(documents[index], index);
                                                },
                                              ),)
                                        )
                                    )
                                  ],)
                              ],

                            ),
                          ),
                        );


                      },
                      itemCount: items.length,
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.9,
                      ),
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
