import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/auth_provider.dart';
import 'package:ecommerce_app/data/user_preferences.dart';
import 'package:ecommerce_app/data/user_provider.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:ecommerce_app/screens/register_screen.dart';
import 'package:ecommerce_app/wedgets/validate_email.dart';
import 'package:ecommerce_app/wedgets/wedgets_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class Login extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void isLogin() async {
    print('login');
    User user = await UserPreferences.getUser();
    if (user.email != null) {
      print(user.email);
      Navigator.pushReplacementNamed(context, MyHomePage.id);
    }
  }

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  final formKey = new GlobalKey<FormState>();

  String _username, _password;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final usernameField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration(
        lan.getText("Enter Email"),
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

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(
          " Authenticating ... Please wait",
          style: Theme.of(context).textTheme.headline2,
        )
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Text(lan.getText("Skip"),
              style: Theme.of(context).textTheme.headline2),
          onPressed: () {
            Navigator.pushReplacementNamed(context, MyHomePage.id);
          },
        ),
        FlatButton(
          padding: EdgeInsets.only(left: 0.0),
          child: Text(lan.getText("Sign up"),
              style: Theme.of(context).textTheme.headline2),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Register.id);
          },
        ),
      ],
    );

    var doLogin = () {
      final form = formKey.currentState;

      if (form.validate()) {
        form.save();
        try {
          final Future<Map<String, dynamic>> successfulMessage =
              auth.login(_username, _password);

          successfulMessage.then((response) {
            if (response['status']) {
              User user = response['user'];
              Provider.of<UserProvider>(context, listen: false).setUser(user);
              Navigator.pushReplacementNamed(context, MyHomePage.id);
            } else {
              Flushbar(
                title: lan.getText("Failed Login"),
                message: response['message'].toString(),
                duration: Duration(seconds: 3),
              ).show(context);
            }
          });
        } catch (e) {
          print(e);
        }
      } else {
        print("form is invalid");
      }
    };

    return SafeArea(
      child: Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(40.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 200.0),
                    label(lan.getText("Email")),
                    SizedBox(height: 5.0),
                    usernameField,
                    SizedBox(height: 20.0),
                    label(lan.getText("Password")),
                    SizedBox(height: 5.0),
                    passwordField,
                    SizedBox(height: 20.0),
                    auth.loggedInStatus == Status.Authenticating
                        ? loading
                        : longButtons(
                            lan.getText("Login"),
                            doLogin,
                            color: Theme.of(context).buttonColor,
                            textColor:
                                Theme.of(context).textTheme.headline2.color,
                          ),
                    SizedBox(height: 5.0),
                    forgotLabel
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
