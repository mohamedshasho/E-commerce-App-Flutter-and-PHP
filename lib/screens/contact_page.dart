import 'package:ecommerce_app/componants/show_toast.dart';
import 'package:ecommerce_app/data/contact_provider.dart';
import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/user_preferences.dart';
import 'package:ecommerce_app/model/contact.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatelessWidget {
  final _controller = TextEditingController();
  static const String id = "Contact_page";
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).selectedRowColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Flexible(
                child: SizedBox(
                  height: height * 0.3,
                ),
              ),
              Container(
                margin: EdgeInsets.all(height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      lan.getText('contact'),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Container(
                      height: height * 0.3,
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: lan.getText('Message'),
                          hintStyle: Theme.of(context).textTheme.headline2,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.all(height * 0.02),
                      color: Theme.of(context).buttonColor,
                      shape: StadiumBorder(),
                      child: Text(
                        lan.getText('Send'),
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      onPressed: () async {
                        if (_controller.text != '') {
                          Contact contact = Contact();
                          User user = await UserPreferences.getUser();
                          contact.username = user.email;
                          contact.msg = _controller.text;
                          var response = await Provider.of<ContactProvider>(
                                  context,
                                  listen: false)
                              .sendMsg(contact);
                          if (response == null)
                            showToast(
                                lan.getText('Please Login Or SinUp First!'));
                          else if (response['status']) {
                            showToast(response['message']);
                            _controller.text = '';
                          } else {
                            showToast(response['message']);
                          }
                        } else {
                          showToast(lan.getText('Please Enter your message!.'));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
