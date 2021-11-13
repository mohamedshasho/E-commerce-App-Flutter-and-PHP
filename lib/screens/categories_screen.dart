import 'dart:math';
import 'dart:ui';

import 'package:ecommerce_app/data/provider_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  static const String id = 'categoriesScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProviderCategories>(
        builder: (ctx, data, _) => ListView.builder(
          itemCount: data.categories.length,
          itemBuilder: (ctx, index) {
            return Container(
              margin: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(
                        1,
                        Random().nextInt(255),
                        Random().nextInt(255),
                        Random().nextInt(255),
                      ).withOpacity(0.1),
                      Color.fromARGB(
                        1,
                        Random().nextInt(255),
                        Random().nextInt(255),
                        Random().nextInt(255),
                      ).withOpacity(1.0),
                    ],
                    stops: [
                      0.0,
                      1.0
                    ]),
              ),
              child: Center(
                child: Text(
                  data.categories[index].name,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
