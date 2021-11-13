import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/provider_categories.dart';
import 'package:ecommerce_app/model/categories.dart';
import 'package:ecommerce_app/model/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildColumnSliver extends StatelessWidget {
  const BuildColumnSliver({
    @required this.products,
  });
  final Products products;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    var mqHeight = MediaQuery.of(context).size.height;
    var mqWidth = MediaQuery.of(context).size.width;

    String getCategory(String index) {
      List<Categories> category =
          Provider.of<ProviderCategories>(context, listen: false).categories;
      Categories c = category.firstWhere((element) => element.id == index);
      return c.name;
    }

    ListTile buildListTile(String title, String trailing) {
      return ListTile(
        leading: Text(title),
        trailing: Text(trailing),
      );
    }

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Center(
              child: Text(products.name),
            ),
          ),
          buildListTile(lan.getText('Price'), "\$" + products.price.toString()),
          Container(
            padding: EdgeInsets.all(mqHeight * 0.02),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  lan.getText("Description"),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: mqHeight * 0.03),
                Text(products.description),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(mqHeight * 0.02),
            // height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  lan.getText("Specification"),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: mqHeight * 0.02,
                ),
                buildListTile(lan.getText('Product type:'),
                    getCategory(products.categoryId)),
                buildListTile(
                    lan.getText('Main Material:'), lan.getText('Man')),
                buildListTile(lan.getText('Capacity:'), 'm-L-xl-xxl'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
