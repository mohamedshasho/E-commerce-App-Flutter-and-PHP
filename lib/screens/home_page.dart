import 'package:badges/badges.dart';
import 'package:ecommerce_app/data/bottom_n_bar_provider.dart';
import 'package:ecommerce_app/data/card_provider.dart';
import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/screens/search_screen.dart';
import 'package:ecommerce_app/screens/setting_screen.dart';
import 'package:flutter/rendering.dart';
import '../data/notification_provider.dart';
import '../screens/cart_screen.dart';
import '../screens/notificationid_screen.dart';

import '../wedgets/product_home_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'categories_screen.dart';
import 'drawer_page.dart';

class MyHomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _pages = [
    ProductHome(),
    CategoriesScreen(),
    SearchScreen(),
    CartScreen(),
    SettingScreen()
  ];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage message) {
        if (message != null) {
          Navigator.pushNamed(context, NotificationScreen.id);
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        Provider.of<NotificationProvider>(context, listen: false)
            .setNotification(notification.title, notification.body);
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  icon: 'launch_background',
                ),
              ));
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Provider.of<NotificationProvider>(context, listen: false).getMessage();
      Navigator.pushNamed(context, NotificationScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    var appbar = AppBar(
      title: Text(
        lan.getText('MegaStore'),
      ),
      actions: <Widget>[
        Consumer<NotificationProvider>(
          builder: (ctx, snapshot, child) {
            return IconButton(
              icon: Badge(
                badgeContent: Text('${snapshot.title.length}'),
                showBadge: snapshot.title.isEmpty ? false : true,
                child: Icon(
                  Icons.notifications,
                  color: Theme.of(context).selectedRowColor,
                ),
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, NotificationScreen.id),
            );
          },
        ),
      ],
    );
    var height =
        MediaQuery.of(context).size.height - appbar.preferredSize.height;

    BottomNavigationBarItem bottomNavigationBarItem(IconData icon,
        {int count = 0}) {
      return BottomNavigationBarItem(
        label: '',
        icon: SizedBox(
          height: height * 0.02,
          child: Badge(
            showBadge: count == 0 ? false : true,
            badgeContent: Text('$count'),
            child: Icon(icon),
          ),
        ),
      );
    }

    Provider.of<NotificationProvider>(context, listen: false).getMessage();
    int count = Provider.of<CartProvider>(context).storeProducts.length;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: appbar,
        drawer: MyDrawer(),
        bottomNavigationBar: SizedBox(
          height: height * 0.08,
          child: Consumer<BottomBarProvider>(
            builder: (ctx, data, _) => BottomNavigationBar(
              elevation: 4,
              selectedIconTheme: IconThemeData(
                color: Theme.of(context).cardColor,
                size: 26,
              ),
              backgroundColor: Theme.of(context).buttonColor,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Theme.of(context).selectedRowColor,
              currentIndex: data.page,
              onTap: (index) => data.getPage(index),
              items: [
                bottomNavigationBarItem(Icons.home),
                bottomNavigationBarItem(Icons.category_outlined),
                bottomNavigationBarItem(Icons.search),
                bottomNavigationBarItem(Icons.shopping_cart, count: count),
                bottomNavigationBarItem(Icons.settings),
              ],
            ),
          ),
        ),
        body: _pages[Provider.of<BottomBarProvider>(context).page],
      ),
    );
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);
