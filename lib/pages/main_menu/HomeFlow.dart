import 'package:dishapp/components/TextFields.dart';
import 'package:dishapp/pages/SignUpFlow.dart';
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
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  List<String> PRUEBA = ["caca", "caca1", "caca3", "caca4", "caca5", "caca6", "caca7", "caca8"];

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

                SizedBox(height: 10,),

                Expanded(
                  child: GridView.builder(
                    itemCount: PRUEBA.length,
                    itemBuilder: (BuildContext context, int index) {

                      return Container(
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff59be32)),
                            borderRadius: BorderRadius.circular(29),
                            color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Row(children: [
                              SizedBox(width: 20,),
                              Text("Usuario")
                            ],),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                ),
                                child: FittedBox(
                                  child: Image.asset("lib/images/upload_image.png"),
                                  fit: BoxFit.fill,
                                )
                              ),),
                            Row(children: [
                              Text("Las otras cosas")
                            ],)
                          ],

                        ),
                      );


                    },
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    scrollDirection: Axis.vertical,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
