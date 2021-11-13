import 'package:ecommerce_app/data/bottom_n_bar_provider.dart';
import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/theme_provider.dart';
import 'package:ecommerce_app/screens/favorite_page.dart';
import 'package:ecommerce_app/wedgets/Language_mode.dart';
import 'package:ecommerce_app/wedgets/item_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'products_page.dart';
import 'home_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    var mqHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Drawer(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Image.asset(
                    'images/shop.png',
                    width: MediaQuery.of(context).size.height * 0.2,
                    height: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),
                // Text('Developed by mohamed shasho'),
                Divider(color: Colors.black54),
                SizedBox(
                  height: mqHeight * 0.01,
                ),
                BuildListTile(
                  title: lan.getText('Home'),
                  icondata: Icons.home,
                  onClick: () {
                    Navigator.pushReplacementNamed(context, MyHomePage.id);
                  },
                ),
                BuildListTile(
                  title: lan.getText('Favorite'),
                  icondata: Icons.favorite,
                  onClick: () {
                    Navigator.pushNamed(context, FavoriteScreen.id);
                  },
                ),
                BuildListTile(
                  title: lan.getText('Products'),
                  icondata: Icons.category,
                  onClick: () =>
                      Navigator.pushNamed(context, ProductsScreen.id),
                ),
                Text(lan.getText("Setting")),
                BuildListTile(
                  title: lan.getText("Setting"),
                  icondata: Icons.settings,
                  onClick: () {
                    Provider.of<BottomBarProvider>(context, listen: false)
                        .getPage(4);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.brightness_2,
                    color: Theme.of(context).selectedRowColor,
                  ),
                  title: Text(lan.getText('Mode Night')),
                  trailing: Switch(
                    value: Provider.of<ThemeNotifier>(context).isDarkMode,
                    onChanged: (val) {
                      Provider.of<ThemeNotifier>(context, listen: false)
                          .updateTheme(val);
                    },
                  ),
                ),
                Language(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
