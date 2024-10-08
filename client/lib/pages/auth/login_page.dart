import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/models/login/login_request_model.dart';
import 'package:resumecraft/api_services/user_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/utils/helpers/dialog_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isApicallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#283B71'),
        body: ProgressHUD(
          inAsyncCall: isApicallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                //topLeft: Radius.circular(100),
                //topRight: Radius.circular(150),
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/resumecraftLogo.png",
                    fit: BoxFit.contain,
                    width: 165,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          // FormHelper.inputFieldWidget(context, keyName, hintText, onValidate, onSaved)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(context, "username", "Username",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'Must input a username';
              }
              return null;
            }, (onSavedVal) {
              username = onSavedVal;
            },
                borderFocusColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(context, "password", "Password",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'Must input a password';
              }
              return null;
            }, (onSavedVal) {
              password = onSavedVal;
            },
                borderFocusColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
                obscureText: hidePassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Colors.white,
                    icon: Icon(hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility))),
          ),

          SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton("Login", () async {
              if (validateAndSave()) {
                setState(() {
                  isApicallProcess = true;
                });
                LoginRequestModel model =
                    LoginRequestModel(username: username!, password: password!);
                try {
                  final loginResponse = await UserAPIService.login(model);
                  setState(() {
                    isApicallProcess = false;
                  });
                  if (loginResponse.token != null) {
                    await UserSharedPrefs.setLoginResponse(loginResponse);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  } else {
                    DialogHelper.displayDialog(
                        context, "Invalid username/password");
                  }
                } catch (e) {
                  setState(() {
                    isApicallProcess = false;
                  });
                  DialogHelper.displayDialog(
                      context, "An error occurred. Please try again.");
                }
              }
            },
                btnColor: HexColor("#283B71"),
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "OR",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                children: <TextSpan>[
                  TextSpan(text: "Don't have an account?"),
                  TextSpan(
                      text: 'Sign Up',
                      style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/register");
                        }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
