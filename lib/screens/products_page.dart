import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/product_Provider.dart';
import 'package:ecommerce_app/data/provider_categories.dart';
import 'package:ecommerce_app/model/categories.dart';
import 'package:ecommerce_app/model/products.dart';
import 'package:ecommerce_app/wedgets/filter_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../componants/item_gridview.dart';

class ProductsScreen extends StatelessWidget {
  static const String id = 'CategoriesPage';
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    print('re build category page');
    List<Categories> categories = [];
    List<Products> products;
    return SafeArea(
      child: Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(lan.getText('Products')),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () async {
                  categories = context.read<ProviderCategories>().categories;
                  showModalBottomSheet(
                    elevation: 5.0,
                    context: context,
                    builder: (
                      ctx,
                    ) {
                      return FilterBottomSheet(
                        categories: categories,
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async =>
                await Provider.of<ProviderProducts>(context, listen: false)
                    .fetchAllData(),
            child: Consumer<ProviderProducts>(
              builder: (ctx, snapShot, child) {
                // checkInternet();

                return ItemGridView(
                  isHome: false,
                  products: snapShot.productsfilter,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // checkInternet() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       print('connected');
  //     }
  //   } on SocketException catch (_) {
  //     print('not connected');
  //   }
  // }
}
