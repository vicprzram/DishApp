import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dishapp/database/Authentication.dart';
import 'package:dishapp/components/TextFields.dart';
import 'package:dishapp/database/RecipeManagement.dart';
import 'package:dishapp/utilities/Utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InpectModel extends FlutterFlowModel<InspectWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
  FFUploadedFile(bytes: Uint8List.fromList([]));

  // Title
  FocusNode? titleFocusNode;
  TextEditingController? titleController;
  String? Function(BuildContext, String?)? titleValidator;

  // Description
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionController;
  String? Function(BuildContext, String?)? descriptionValidator;

  // Total time
  FocusNode? timeFocusNode;
  TextEditingController? timeController;
  String? Function(BuildContext, String?)? timeValidator;

  // Timer
  List<String> dropdownItems = ["Hours", "Minutes", "Seconds"];
  late String dropdownValue = dropdownItems[2];

  // Diners
  FocusNode? dinersFocusNode;
  TextEditingController? dinersController;
  String? Function(BuildContext, String?)? dinersValidator;

  // Ingredients
  List<TextEditingController?> ingredientsController = [];
  List<Widget> ingredientFields = [];

  // Steps
  List<TextEditingController?> stepsController = [];
  List<Widget> stepsFields = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    titleController?.dispose();
    titleFocusNode?.dispose();

    descriptionFocusNode?.dispose();
    descriptionController?.dispose();
  }
}

class InspectWidget extends StatefulWidget {
  final String ID;

  InspectWidget({
    required this.ID
  });

  @override
  State<StatefulWidget> createState() => _InspectWidgetState(ID: ID);
}

class _InspectWidgetState extends State<InspectWidget> {
  late InpectModel _model;
  final String ID;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Recipe2? recipe = null;

  _InspectWidgetState({
    required this.ID
  });

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InpectModel());

    getData();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void getData() async {

    String timer, time, image, diners, description, title, user;
    List<String> ingredients = [];
    List<String> steps = [];

    var data = await FirebaseFirestore.instance.collection('recipes').doc(this.ID).get();

    ingredients.add("Ingredients");
    for(int i = 0; i < data.data()!["ingredients"].length; i++){
      ingredients.add(data.data()!["ingredients"][i]);
    }

    steps.add("Steps");
    for(int i = 0; i < data.data()!["steps"].length; i++){
      steps.add(data.data()!["steps"][i]);
    }

    timer = data.data()!["timer"];
    image = data.data()!["image"];
    diners = data.data()!["diners"];
    description = data.data()!["description"];
    time = data.data()!["time"];
    title = data.data()!["title"];
    user = data.data()!["user"];

    setState(() {
      recipe = Recipe2(user, image, title, description, time, timer, diners, ingredients, steps);
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        backgroundColor: Color(0xFFFEEDDD),
        body: SafeArea(
          top: true,
          child: (recipe == null) ? Container() :
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(alignment: Alignment.center,
                    child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: RichText(text: TextSpan(text: recipe!.title, style: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Outfit',
                        letterSpacing: 0,
                        fontSize: 35,
                        color: Colors.black
                    )))),
                ),

                Align(alignment: AlignmentDirectional(0, 0),
                    child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          height: 230,
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                recipe!.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                    )
                ),

                Row(

                  children: [

                    Padding(padding: EdgeInsetsDirectional.fromSTEB(40, 10, 20, 0),
                      child: Text("Duration: ${recipe!.time} ${recipe!.timer}", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),)),

                    SizedBox(width: 50),

                    Padding(padding: EdgeInsetsDirectional.fromSTEB(30, 10, 20, 0),
                        child: Text("Diners: ${recipe!.diners}", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),)),
                  ],
                ),

                Padding(padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                child: Text(recipe!.description, style: TextStyle(color: Colors.black, fontSize: 15),),),

                Expanded(child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0), child: GridView(

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,

                  children: [

                    ListView.builder(
                      itemCount: recipe!.ingredients.length,
                      itemBuilder: (context, index) {

                        return Align(
                          alignment: Alignment.center,
                          child: (recipe!.ingredients[index] == "Ingredients") ? Text(recipe!.ingredients[index], style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)) :
                          Text("${recipe!.ingredients[index]}", style: TextStyle(color: Colors.black, fontSize: 15),),
                        );
                      },
                    ),

                    ListView.builder(
                      itemCount: recipe!.steps.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: Alignment.center,
                          child: (recipe!.steps[index] == "Steps") ? Text(recipe!.steps[index], style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)) :
                          Text("${index}ª ${recipe!.steps[index]}\n", style: TextStyle(color: Colors.black, fontSize: 15),),
                        );
                      },
                    )

                  ],
                ))),

              ],
            ),
          ),
    ));
  }

}
