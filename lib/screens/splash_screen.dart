import 'dart:async';

import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/card_provider.dart';
import '../data/product_Provider.dart';
import '../data/provider_categories.dart';
import '../data/search_provider.dart';
import '../data/theme_provider.dart';
import '../screens/home_page.dart';
import '../constants.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  Animation _animation;
  AnimationController _controller;
  Animation _animation2;
  AnimationController _controller2;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
    _controller.forward();

    _controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation2 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller2);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) _controller2.forward();
    });

    Timer(Duration(milliseconds: 2500), () {
      Provider.of<ProviderProducts>(context, listen: false).fetchAllData();
      Provider.of<ProviderCategories>(context, listen: false).fetchAllData();
      Provider.of<CartProvider>(context, listen: false).fetchData();
      Provider.of<ThemeNotifier>(context, listen: false).getDataTheme();
      Provider.of<SearchProvider>(context, listen: false).fetchData();
      Provider.of<LanguageProvider>(context, listen: false).getLan();
      Provider.of<UserProvider>(context, listen: false).getUser();
      Navigator.pushReplacementNamed(context, MyHomePage.id);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: _animation,
            child: Center(
              child: Image.asset('images/shop.png'),
            ),
          ),
          SizedBox(height: 20),
          FadeTransition(
            opacity: _animation2,
            child: Center(
              child: Text(
                'E-commerce App Flutter',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
