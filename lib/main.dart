import 'dart:convert';

import 'package:ecommerce_app/data/bottom_n_bar_provider.dart';
import 'package:ecommerce_app/data/contact_provider.dart';
import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/provider_categories.dart';
import 'package:ecommerce_app/screens/about_app.dart';
import 'package:ecommerce_app/screens/categories_screen.dart';
import 'package:ecommerce_app/screens/products_page.dart';
import 'package:ecommerce_app/screens/contact_page.dart';
import 'package:ecommerce_app/screens/details_products.dart';
import 'package:ecommerce_app/screens/favorite_page.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/screens/register_screen.dart';
import 'package:ecommerce_app/screens/search_screen.dart';
import 'package:ecommerce_app/screens/setting_screen.dart';
import 'package:ecommerce_app/theme_data.dart';
import 'package:ecommerce_app/wedgets/product_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/auth_provider.dart';
import 'data/card_provider.dart';
import 'data/notification_provider.dart';
import 'data/product_Provider.dart';
import 'data/search_provider.dart';
import 'data/theme_provider.dart';
import 'data/user_preferences.dart';
import 'data/user_provider.dart';
import 'model/app_api.dart';
import 'model/user.dart';
import 'package:http/http.dart' as http;
import 'screens/notificationid_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //first
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(); // هي قبل الكل وقبلها كمان
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  User user = await UserPreferences.getUser();
  FirebaseMessaging.instance.onTokenRefresh.listen(
    (newToken) async {
      print(newToken.toString());
      var userApi = json.decode(
          json.encode({"email": user.email, "token": newToken.toString()}));
      var response =
          await http.post(Uri.parse(AppUrl.setNewToken), body: userApi);
      print(response.body);
    },
  );

  print('main');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProviderProducts()),
      ChangeNotifierProvider(create: (_) => ProviderCategories()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ContactProvider()),
      ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),
      ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => BottomBarProvider()),
      ChangeNotifierProvider(create: (_) => LanguageProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeNotifier>(context).isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      title: 'Flutter Demo',
      theme: themeLight,
      darkTheme: themeDark,
      home: Scaffold(
        body: Splash(),
      ),
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        ProductHome.id: (context) => ProductHome(),
        DetailsProduct.id: (context) => DetailsProduct(),
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        ContactPage.id: (context) => ContactPage(),
        SettingScreen.id: (context) => SettingScreen(),
        ProductsScreen.id: (context) => ProductsScreen(),
        SearchScreen.id: (context) => SearchScreen(),
        NotificationScreen.id: (context) => NotificationScreen(),
        FavoriteScreen.id: (context) => FavoriteScreen(),
        CategoriesScreen.id: (context) => CategoriesScreen(),
        AboutAppScreen.id: (context) => AboutAppScreen(),
      },
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  SharedPreferences sp = await SharedPreferences.getInstance();
  List<String> title = sp.getStringList('title') ?? [];
  List<String> body = sp.getStringList('body') ?? [];
  title.add(message.notification.title);
  body.add(message.notification.body);
  sp.setStringList('title', title);
  sp.setStringList('body', body);
  print('Handling a background message ${message.messageId}');
}
