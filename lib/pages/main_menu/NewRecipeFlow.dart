
import 'dart:io';

import 'package:dishapp/components/TextFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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

  // Ingredients
  List<FocusNode?> ingredientsFocusNode = [];
  List<TextEditingController?> ingredientsController = [];
  List<String? Function(BuildContext, String?)?> ingredientsValidator = [];

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

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
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




  List<TextEditingController> _controllers = [];
  List<Widget> _textFields = [];

  void _removeTextField(TextEditingController controller) {
    setState(() {
      int index = _controllers.indexOf(controller);
      if (index != -1) {
        _controllers.removeAt(index);
        _textFields.removeAt(index);
      }
    });
    controller.dispose();
  }

  void _addTextField() {
    final controller = TextEditingController();
    _controllers.add(controller);
    setState(() {
      _textFields.add(
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
                  _removeTextField(controller);
                },
              ),
            ],
          ),
        ),
      );
    });
  }




  @override
  Widget build(BuildContext context) {



    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfffeeddd),
          title: Text('New Recipe'),
          actions: <Widget>[
            IconButton(onPressed: () {  }, icon: Icon(Icons.save)),
            IconButton(onPressed: () {  }, icon: Icon(Icons.delete))
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
                    padding: EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
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
                      maxLines: 4,
                    )
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 15, 25, 0),
                    child: Card(
                      surfaceTintColor: Colors.white,
                      elevation: 3,
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
                                itemCount: _textFields.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _textFields[index];

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
                                onPressed: _addTextField,
                                child: Text("Add new ingredient"),

                              ),)



                          )

                        ],),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
