import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/data/card_provider.dart';
import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/product_Provider.dart';
import 'package:ecommerce_app/model/app_api.dart';
import 'package:ecommerce_app/screens/check_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    double check = 0.0;
    var mqHeight = MediaQuery.of(context).size.height;
    var mqWidth = MediaQuery.of(context).size.width;
    Provider.of<CartProvider>(context).storeProducts.forEach((element) {
      try {
        check += double.parse(
            Provider.of<ProviderProducts>(context).getProFav(element).price);
      } catch (e) {
        print(e);
      }
    });
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            check != 0.0
                ? Card(
                    elevation: 5.0,
                    shadowColor: Theme.of(context).accentColor.withOpacity(0.5),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CheckScreen(check: check);
                          },
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('${lan.getText('Check')} \$$check'),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        body: Consumer<CartProvider>(
          builder: (ctx, data, _) {
            var product = Provider.of<ProviderProducts>(context, listen: false);
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: data.storeProducts.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  data.deleteCard(data.storeProducts[index]);
                                },
                                icon: Icon(Icons.remove_circle_outline),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CachedNetworkImage(
                                  width: mqWidth * 0.25,
                                  height: mqHeight * 0.15,
                                  fit: BoxFit.fill,
                                  imageUrl: AppUrl.URL +
                                      '${context.read<ProviderProducts>().getProFav(data.storeProducts[index]).image}',
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(product
                                      .getProFav(data.storeProducts[index])
                                      .name),
                                  SizedBox(height: mqHeight * 0.02),
                                  Text(
                                      '\$${product.getProFav(data.storeProducts[index]).price}'),
                                  SizedBox(height: mqHeight * 0.02),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            color: Theme.of(context).dividerColor,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
