import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/product_Provider.dart';
import 'package:ecommerce_app/model/app_api.dart';
import 'package:ecommerce_app/wedgets/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static const String id = 'favoritePage';
  @override
  Widget build(BuildContext context) {
    var mqWidth = MediaQuery.of(context).size.width;
    var mqHeight = MediaQuery.of(context).size.height;
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getText('Favorite')),
        ),
        body: Consumer<ProviderProducts>(
          builder: (ctx, data, _) {
            //data.delFavoriteProducts();
            return data.favorite.length == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        lan.getText('No Added favorite yet!.'),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      Image.asset(
                        'images/favorite.jpg',
                        fit: BoxFit.cover,
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: <Widget>[
                            Text('${data.favorite.length} '),
                            Text(lan.getText('items')),
                          ],
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).dividerColor,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.favorite.length,
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () async {
                                        await Provider.of<ProviderProducts>(
                                                context,
                                                listen: false)
                                            .setFavorite(data.favorite[index]);
                                      },
                                      icon: Icon(Icons.remove_circle_outline),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CachedNetworkImage(
                                        width: mqWidth * 0.3,
                                        height: mqHeight * 0.2,
                                        fit: BoxFit.fill,
                                        imageUrl: AppUrl.URL +
                                            '${data.getProFav(data.favorite[index]).image}',
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(data
                                            .getProFav(data.favorite[index])
                                            .name),
                                        SizedBox(height: mqHeight * 0.02),
                                        Text(
                                            '\$${data.getProFav(data.favorite[index]).price}'),
                                        SizedBox(height: mqHeight * 0.02),
                                        CustomDialog(
                                          title: lan.getText('Add to card'),
                                          image: data
                                              .getProFav(data.favorite[index])
                                              .image,
                                          id: data
                                              .getProFav(data.favorite[index])
                                              .id,
                                        ),
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
