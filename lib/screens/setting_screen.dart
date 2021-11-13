import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/user_preferences.dart';
import 'package:ecommerce_app/data/user_provider.dart';
import 'package:ecommerce_app/wedgets/item_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'about_app.dart';
import 'contact_page.dart';
import 'login_screen.dart';

class SettingScreen extends StatelessWidget {
  static const String id = 'setting';

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    var auth = Provider.of<LanguageProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lan.getText('Setting'),
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),

            //const SizedBox() افضل للعناصر الفارغة
            Consumer<UserProvider>(
              builder: (ctx, data, _) {
                if (data.user != null && data.user.email != null)
                  return BuildListTile(
                    title: lan.getText('My Profile'),
                    icondata: Icons.person,
                  );
                else
                  return BuildListTile(
                    title: lan.getText('Log in'),
                    icondata: Icons.login,
                    onClick: () => Navigator.pushNamed(context, Login.id),
                  );
              },
            ),
            BuildListTile(
              title: lan.getText('Contact'),
              icondata: Icons.contacts,
              onClick: () => Navigator.pushNamed(context, ContactPage.id),
            ),
            BuildListTile(
              title: lan.getText('Share App'),
              icondata: Icons.share,
            ),
            BuildListTile(
              title: lan.getText('About app'),
              icondata: Icons.info,
              onClick: () => Navigator.pushNamed(context, AboutAppScreen.id),
            ),
            Consumer<UserProvider>(
              builder: (ctx, data, _) {
                if (data.user != null && data.user.email != null)
                  return BuildListTile(
                    title: lan.getText('Logout'),
                    icondata: Icons.logout,
                    onClick: () {
                      UserPreferences.removeUser();
                      Provider.of<UserProvider>(context, listen: false)
                          .delUser();
                      Navigator.pushNamedAndRemoveUntil(
                          context, Login.id, (_) => false);
                    },
                  );
                else
                  return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
