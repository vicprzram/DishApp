import 'package:dishapp/components/TextFields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:dishapp/database/Authentication.dart';
import 'package:dishapp/utilities/Utilities.dart';

class SignUpModel extends FlutterFlowModel<SignUpWidget> {

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailController;
  String? Function(BuildContext, String?)? emailValidator;

  // State field(s) for TextField widget.
  FocusNode? usernameFocusNode;
  TextEditingController? usernameController;
  String? Function(BuildContext, String?)? usernameValidator;

  // State field(s) for TextField widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  String? Function(BuildContext, String?)? passwordValidator;

  // State field(s) for TextField widget.
  FocusNode? passwordRepeatFocusNode;
  TextEditingController? passwordRepeatController;
  String? Function(BuildContext, String?)? passwordRepeatValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    emailFocusNode?.dispose();
    emailController?.dispose();

    usernameFocusNode?.dispose();
    usernameController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();

    passwordRepeatFocusNode?.dispose();
    passwordRepeatController?.dispose();
  }
}

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<SignUpWidget> {
  late SignUpModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool obscureText = true;
  bool obscureTextRepeat = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpModel());

    _model.emailController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.usernameController ??= TextEditingController();
    _model.usernameFocusNode ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.passwordRepeatController ??= TextEditingController();
    _model.passwordRepeatFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void createAccount(context) async {
    if(_model.passwordRepeatController.text == _model.passwordController.text){
      final message = await Authentication().registration(
          user: Usuario(_model.emailController.text.trim(),
              _model.usernameController.text.trim(),
              _model.passwordController.text.trim()));
      if(message.contains('Success')){
        Navigator.pop(context);
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message))
      );
    }else{
      SnackBar(content: Text('The passwords do not match'));
    }
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
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'lib/images/fruit_box.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(),
                child: RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: TextStyle(
                            fontSize: 45,
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
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: MainTextField(
                  isPassword: false,
                  focus: _model.emailFocusNode,
                  label: 'Email',
                  validator: _model.emailValidator,
                  controller: _model.emailController,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                child: MainTextField(
                  controller: _model.usernameController,
                  validator: _model.usernameValidator,
                  label: 'Username',
                  focus: _model.usernameFocusNode,
                  isPassword: false,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                )
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                child: MainTextField(
                  controller: _model.passwordController,
                  validator: _model.passwordValidator,
                  label: 'Password',
                  focus: _model.passwordFocusNode,
                  isPassword: true,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                )
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                child: MainTextField(
                  controller: _model.passwordRepeatController,
                  validator: _model.passwordRepeatValidator,
                  label: 'Repeat password',
                  focus: _model.passwordRepeatFocusNode,
                  isPassword: true,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                )
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    this.createAccount(context);
                  },
                  text: 'Signup',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: Color(0xff59be32),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      letterSpacing: 0,
                    ),
                    elevation: 3,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(text: TextSpan(
                          style: new TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: 'Already created?   ',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                  }),
                            new TextSpan(
                                text: 'Log in',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                  },
                                style: new TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                          ],
                        ),
                        )
                      ]
                  )
              ),

            ]
    ))));
  }
}