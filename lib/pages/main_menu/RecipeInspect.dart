import 'dart:io';
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
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}
