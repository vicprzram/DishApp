import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dishapp/components/TextFields.dart';
import 'package:dishapp/pages/SignUpFlow.dart';
import 'package:dishapp/pages/main_menu/RecipeInspect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:dishapp/database/Authentication.dart';

import 'NewRecipeFlow.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  late List<Map<String, dynamic>> items = [];
  late List<String> favourites = [];
  late List<String> documents = [];
  bool isLoaded = false;

  void saveItem(String doc) async {
    if(favourites.contains(doc)){
      setState(() {
        favourites.remove(doc);
        FirebaseFirestore.instance.collection("favourites").doc(FirebaseAuth.instance.currentUser!.displayName.toString()).update({
          "recipes": favourites
        });
      });
      return;
    }

    setState(() {
      FirebaseFirestore.instance.collection("favourites").doc(FirebaseAuth.instance.currentUser!.displayName.toString()).update({
        "recipes": FieldValue.arrayUnion([doc])
      });
      fetchFavourites();
    });

  }

  void addItems() async {
    List<Map<String, dynamic>> tempList = [];
    var data = await FirebaseFirestore.instance.collection('recipes').get();


    data.docs.forEach((element) {
      tempList.add(element.data());
      documents.add(element.id);
    });

    setState(() {
      items = tempList;
    });

    isLoaded = true;
  }

  void fetchFavourites() async {
    var data = await FirebaseFirestore.instance.collection('favourites').doc(FirebaseAuth.instance.currentUser!.displayName).get();

    for(int i = 0; i < data.data()!.values.elementAt(0).length; i++){
      favourites.add(data.data()!.values.elementAt(0)[i]);
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    fetchFavourites();
    addItems();
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
        floatingActionButton: Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(left: 0, right: 5.0),
            child: FloatingActionButton.extended(
              onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AddrecipeWidget())); },
              label: Text("New recipe"),
              icon: Icon(Icons.add),
              backgroundColor: Color(0xff59be32),
            )),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
                  child:  Container(
                    decoration: BoxDecoration(),
                    child: RichText(
                      textScaler: MediaQuery.of(context).textScaler,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome \"' + FirebaseAuth.instance.currentUser!.displayName.toString() + '\"',
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
                  ))),

              FutureBuilder(
                future: Future.delayed(Duration(milliseconds: 500)),
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
                    )) :
                Expanded(
                  child: GridView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {

                      return InkWell(
                        onTap: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context) => InspectWidget(ID: documents[index])));

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


                                  (FirebaseAuth.instance.currentUser!.displayName.toString() == items[index]["user"]) ?
                                  Container() :
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 5),
                                          child: Container(
                                            child: InkWell(
                                              child: Icon( (favourites.contains(documents[index])) ? Icons.bookmark : Icons.bookmark_border),
                                              onTap: () {
                                                saveItem(documents[index]);
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
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.90,
                    ),
                    scrollDirection: Axis.vertical,
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
