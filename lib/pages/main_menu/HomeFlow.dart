import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dishapp/components/TextFields.dart';
import 'package:dishapp/pages/SignUpFlow.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late List<String> documents = [];
  bool isLoaded = false;

  void saveItem(String doc) async {
    DatabaseReference refRealtime = FirebaseDatabase.instance.ref("users");


    await refRealtime.set({
      FirebaseAuth.instance.currentUser?.displayName.toString() : {
        "recipes": {
          doc,
        }
      }
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

  @override
  void initState() async {
    super.initState();
    _model = createModel(context, () => HomeModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    Timer miTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      addItems();
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
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


                Expanded(
                  child: (isLoaded && items.length > 0) ? GridView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {

                      return InkWell(
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
                                              child: Icon(Icons.bookmark_border),
                                              onTap: () {

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
                  ) : Text("No data")
                ),
            ],
          ),
        ),
      ),
    );
  }
}
