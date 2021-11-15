import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/product_Provider.dart';
import 'package:ecommerce_app/model/products.dart';
import 'package:ecommerce_app/screens/products_page.dart';
import 'package:ecommerce_app/screens/search_screen.dart';
import 'package:ecommerce_app/wedgets/shimer_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import '../componants/item_gridview.dart';

class ProductHome extends StatelessWidget {
  static const String id = 'productHome';

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    var mqHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, SearchScreen.id,
                    arguments: true),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  color: Theme.of(context).primaryColor,
                  shape: StadiumBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          lan.getText('search'),
                        ),
                        Icon(
                          Icons.search,
                          color: Theme.of(context).selectedRowColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: mqHeight * 0.2,
                child: Swiper(
                  autoplay: true,
                  duration: 500,
                  loop: true,
                  scale: 0.8,
                  viewportFraction: 0.8,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      "images/pic${index + 1}.jpg",
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: 3,
                  pagination: SwiperPagination(),
                ),
              ),
              Divider(color: Theme.of(context).dividerColor),
              Container(
                padding: EdgeInsets.all(mqHeight * 0.01),
                height: mqHeight * 0.08,
                child: BuildRowHome(
                  mqHeight: mqHeight,
                  title: lan.getText('Products'),
                  onPress: () =>
                      Navigator.pushNamed(context, ProductsScreen.id),
                ),
              ),
              Container(
                height: mqHeight * 0.4,
                width: double.infinity,
                child: Consumer<ProviderProducts>(
                  builder: (ctx, value, child) {
                    List<Products> pro = value.getProducts;
                    if (pro.isEmpty)
                      return ShimmerList(
                        isListView: false,
                      );
                    else
                      return ItemGridView(
                        isHome: true,
                        products: pro,
                      );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(mqHeight * 0.01),
                height: mqHeight * 0.08,
                child: BuildRowHome(
                  mqHeight: mqHeight,
                  title: lan.getText('Modern'),
                  onPress: () =>
                      Navigator.pushNamed(context, ProductsScreen.id),
                ),
              ),
              Container(
                height: mqHeight * 0.4,
                width: double.infinity,
                child: Consumer<ProviderProducts>(
                  builder: (ctx, value, child) {
                    List<Products> pro = value.getProducts;
                    if (pro.isEmpty)
                      return ShimmerList(
                        isListView: false,
                      );
                    else
                      return ItemGridView(
                        isHome: true,
                        products: pro,
                        isModern: true,
                      );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildRowHome extends StatelessWidget {
  const BuildRowHome({
    @required this.title,
    @required this.onPress,
    @required this.mqHeight,
  });

  final double mqHeight;
  final String title;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Container(
                height: mqHeight * 0.03,
                width: 5,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Text(' $title'),
            ],
          ),
          GestureDetector(
            onTap: onPress,
            child: Text(
              lan.getText('Show more'),
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
