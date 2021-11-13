import 'package:ecommerce_app/componants/show_toast.dart';
import 'package:ecommerce_app/data/auth_provider.dart';
import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/user_provider.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/wedgets/validate_email.dart';
import 'package:ecommerce_app/wedgets/wedgets_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class Register extends StatefulWidget {
  static const String id = 'register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();

  String _username, _password, _confirmPassword, _email;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var lan = Provider.of<LanguageProvider>(context);
    final usernameField = TextFormField(
      autofocus: false,
      validator: (value) =>
          value.isEmpty ? lan.getText("Please enter username") : null,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration(
        lan.getText("username"),
        Icons.email,
        Theme.of(context).selectedRowColor,
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration(
        lan.getText("Email"),
        Icons.email,
        Theme.of(context).selectedRowColor,
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) =>
          value.isEmpty ? lan.getText("Please enter password") : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration(
        lan.getText("password"),
        Icons.lock,
        Theme.of(context).selectedRowColor,
      ),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) =>
          value.isEmpty ? lan.getText("Your password is required") : null,
      onSaved: (value) => _confirmPassword = value,
      obscureText: true,
      decoration: buildInputDecoration(
        lan.getText("Confirm password"),
        Icons.lock,
        Theme.of(context).selectedRowColor,
      ),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    final sinIn = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.only(left: 0.0),
          child: Text(lan.getText("Sign in"),
              style: Theme.of(context).textTheme.headline2),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Login.id);
          },
        ),
      ],
    );

    var doRegister = () async {
      final form = formKey.currentState;

      if (form.validate()) {
        form.save();
        if (_password != _confirmPassword) {
          showToast(lan.getText('Password are not same!.'));
          print("Password are not same!.");
          return;
        }
        String token;

        try {
          token = await FirebaseMessaging.instance.getToken();
          await FirebaseMessaging.instance
              .getToken()
              .then((value) => token = value.toString());
          print('Token : ' + token);
          var response =
              await auth.register(_username, _email, _password, token);

          if (response['status']) {
            User user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, MyHomePage.id);
          } else {
            Flushbar(
              title: lan.getText("Registration Failed"),
              message: response['data'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        } catch (e) {
          showToast(e.toString());
        }
      } else {
        Flushbar(
          title: lan.getText("Invalid form"),
          message: lan.getText("Please Complete the form properly"),
          duration: Duration(seconds: 3),
        ).show(context);
      }
    };

    return SafeArea(
      child: Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(height * 0.05),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.15),
                    label(lan.getText("Username")),
                    usernameField,
                    SizedBox(height: height * 0.01),
                    label(lan.getText("Email")),
                    emailField,
                    SizedBox(height: height * 0.01),
                    label(lan.getText("Password")),
                    passwordField,
                    SizedBox(height: height * 0.01),
                    label(lan.getText("Confirm Password")),
                    confirmPassword,
                    SizedBox(height: height * 0.01),
                    auth.registeredInStatus == Status.Registering
                        ? loading
                        : longButtons(lan.getText("Register"), doRegister,
                            textColor:
                                Theme.of(context).textTheme.headline2.color,
                            color: Theme.of(context).buttonColor),
                    SizedBox(height: 5.0),
                    sinIn
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
