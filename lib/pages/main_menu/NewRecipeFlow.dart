
import 'dart:io';
import 'package:dishapp/database/Authentication.dart';
import 'package:dishapp/components/TextFields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddrecipeModel extends FlutterFlowModel<AddrecipeWidget> {
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

class AddrecipeWidget extends StatefulWidget {
  const AddrecipeWidget({super.key});

  @override
  State<AddrecipeWidget> createState() => _AddrecipeWidgetState();
}

class _AddrecipeWidgetState extends State<AddrecipeWidget> {
  late AddrecipeModel _model;
  List<String> dropdownItems = ["Hours", "Minutes", "Seconds"];
  late String dropdownValue = dropdownItems[2];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool executed = false;
  int step = 1;

  void _removeIngredient(TextEditingController controller) {
    setState(() {
      int index = _model.ingredientsController.indexOf(controller);
      if (index != -1) {
        _model.ingredientsController.removeAt(index);
        _model.ingredientFields.removeAt(index);
      }
    });
    controller.dispose();
  }

  void _addIngredient() {
    final controller = TextEditingController();
    _model.ingredientsController.add(controller);
    setState(() {
      _model.ingredientFields.add(
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
          child: Row(
            children: [
              Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: controller,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'New ingredient',
                        labelStyle:
                        FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily: 'Outfit',
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0,
                        ),
                        hintStyle:
                        FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily: 'Outfit',
                          letterSpacing: 0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff59be32),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF59BE32),
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,

                      ),
                    ),
                  )
              ),
              IconButton(
                icon: Icon(Icons.highlight_remove, color: Colors.red),
                onPressed: () {
                  _removeIngredient(controller);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  void _removeStep() {
    setState(() {
      int index = _model.stepsFields.length - 1;
      if (index != -1) {
        _model.stepsFields.removeAt(index);
        _model.stepsController.removeAt(index);
        step--;
      }
    });
  }

  void _addStep() {
    final controller = TextEditingController();
    _model.stepsController.add(controller);
    setState(() {
      _model.stepsFields.add(
          Container(
            child: Column(
              children: [

                Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 5),
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey[400],
                  ),),

                Padding(padding: EdgeInsetsDirectional.fromSTEB(15, 0, 25, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: RichText(text: TextSpan(
                          style: TextStyle(color: Colors.grey[900], fontSize: 20, fontStyle: FontStyle.italic),
                          text: 'Step $step'),),
                    )
                ),

                Padding(padding: EdgeInsetsDirectional.fromSTEB(50, 15, 10, 10),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: TextFormField(
                          controller: controller,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: 'Add information about the step $step',
                            labelStyle:
                            FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0,
                            ),
                            hintStyle:
                            FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'Outfit',
                              letterSpacing: 0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff59be32),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF59BE32),
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,

                          ),
                        ),
                    )
                ),


              ],
            ),
          )
      );
      step++;
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddrecipeModel());

    _model.titleController ??= TextEditingController();
    _model.titleFocusNode ??= FocusNode();

    _model.descriptionController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();

  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  late File _image = File('');
  final picker = ImagePicker();

//Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Gallery', style: TextStyle(color: Color(0xff59be32)),),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera', style: TextStyle(color: Color(0xff59be32))),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if(!executed){
      _addIngredient();
      executed = true;
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfffeeddd),
          title: Text('New Recipe', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          actions: <Widget>[
            IconButton(onPressed: () { print( FirebaseAuth.instance.currentUser?.displayName); }, icon: Icon(Icons.send, color: Colors.black,)),
            IconButton(onPressed: () {  }, icon: Icon(Icons.delete, color: Colors.black,))
          ],
        ),
        key: scaffoldKey,
        backgroundColor: Color(0xFFFEEDDD),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, -1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
                    child: Container(
                      //width: double.infinity,
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            showOptions();
                          });;
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: (_image.path == '') ? Image.asset('lib/images/upload_image.png', height: 200,) : Image.file(_image, height: 200),
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
                    child: MainTextField(
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      isPassword: false,
                      focus: _model.titleFocusNode,
                      label: 'Title',
                      validator: _model.titleValidator,
                      controller: _model.titleController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
                    child: MainTextField(
                      controller: _model.descriptionController,
                      validator: _model.descriptionValidator,
                      label: 'Add some description...',
                      focus: _model.descriptionFocusNode,
                      isPassword: false,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                    )
                  ),


                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 10, 25, 0),
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontFamily: 'Outfit', color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                              text: 'Total time: ',
                          ),
                        ),

                        SizedBox(width: 5,),

                        SizedBox(
                          width: 60,
                         height: 50,
                         child: MainTextField(
                              controller: _model.timeController,
                              focus: _model.timeFocusNode,
                              validator: _model.timeValidator,
                              label: '',
                              isPassword: false,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              textInputType: TextInputType.number),
                        ),

                        SizedBox(width: 15,),

                        DropdownButton(
                            value: dropdownValue,
                            //underline: SizedBox(),
                            items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(fontFamily: 'Outfit', fontSize: 18.0, color: Colors.black),
                                    text: value
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        }
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(32, 10, 25, 0),
                    child: Row(
                      children: [

                        RichText(
                        text: TextSpan(
                          style: TextStyle(fontFamily: 'Outfit', color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                          text: 'Diners: ',
                        ),
                      ),

                        SizedBox(width: 35,),

                        SizedBox(
                          width: 60,
                          height: 50,
                          child: MainTextField(
                              controller: _model.timeController,
                              focus: _model.timeFocusNode,
                              validator: _model.timeValidator,
                              label: '',
                              isPassword: false,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              textInputType: TextInputType.number),
                        ),

                      ],
                    )),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 15, 25, 0),
                    child: Card(
                      surfaceTintColor: Colors.white,
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          SizedBox(height: 5),

                          Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(text: TextSpan(
                                      text: 'Ingredients',
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
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
                                itemCount: _model.ingredientFields.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _model.ingredientFields[index];

                                }
                              )]),

                          Align(
                            alignment: Alignment.center,
                            child: Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  backgroundColor: Colors.grey[700],

                                ),
                                onPressed: _addIngredient,
                                child: Text("Add new ingredient"),

                              ),)



                          )

                        ],),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 15, 25, 0),
                    child: Card(
                      surfaceTintColor: Colors.white,
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      icon: Icon(Icons.add, color: Color(0xff59be32),),
                                      onPressed: () {
                                        _addStep();
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: RichText(text: TextSpan(
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                      text: 'Steps'
                                    ))),

                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        _removeStep();
                                      },
                                    ),
                                  )
                              ],
                            ),

                          SizedBox(height: 10,),

                          Column(
                              children: [ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: _model.stepsFields.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return _model.stepsFields[index];
                                  }
                              )]),

                        ]))),

                  SizedBox(height: 40,)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
