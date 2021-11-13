import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/product_Provider.dart';
import 'package:ecommerce_app/model/app_api.dart';
import 'package:ecommerce_app/model/products.dart';
import 'package:ecommerce_app/wedgets/colume_sliver.dart';
import 'package:ecommerce_app/wedgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class DetailsProduct extends StatelessWidget {
  static const String id = 'DetailsProduct';

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    var mqHeight = MediaQuery.of(context).size.height;
    var mqWidth = MediaQuery.of(context).size.width;
    final Products products = ModalRoute.of(context).settings.arguments;
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      await Provider.of<ProviderProducts>(context, listen: false)
          .setFavorite(products.id);
      return !isLiked;
    }

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.cancel),
                color: Theme.of(context).selectedRowColor,
                onPressed: () => Navigator.pop(context),
              ),
              actions: <Widget>[
                LikeButton(
                  onTap: onLikeButtonTapped,
                  isLiked: Provider.of<ProviderProducts>(context, listen: false)
                      .getFavorite(products.id),
                  animationDuration: Duration(milliseconds: 600),
                  likeBuilder: (value) {
                    return Icon(
                      value ? Icons.favorite : Icons.favorite_border,
                      color: value ? Colors.red : Colors.purple,
                    );
                  },
                ),
              ],
              elevation: 4,
              expandedHeight: mqHeight * 0.4,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                // title: Text(products.name),
                background: Hero(
                  tag: products.id,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: mqWidth * 0.7,
                                    height: mqHeight * 0.7,
                                    child: Hero(
                                      tag: products.id,
                                      child: InteractiveViewer(
                                        child: Image.network(
                                          AppUrl.URL + '${products.image}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                      child: Icon(
                                        Icons.cancel,
                                        color:
                                            Theme.of(context).selectedRowColor,
                                      ),
                                      onPressed: () => Navigator.pop(ctx))
                                ],
                              ),
                            );
                          });
                    },
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: AppUrl.URL + '${products.image}',
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BuildColumnSliver(products: products),
            ),
            SliverToBoxAdapter(
              child: Container(
                  height: mqHeight * 0.08,
                  width: double.infinity,
                  child: CustomDialog(
                    image: products.image,
                    id: products.id,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
