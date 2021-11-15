import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/data/product_Provider.dart';
import 'package:ecommerce_app/model/app_api.dart';
import 'package:ecommerce_app/model/products.dart';
import 'package:ecommerce_app/screens/details_products.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class ItemGridView extends StatelessWidget {
  final List<Products> products;
  final bool isHome;
  final bool isModern;
  ItemGridView({this.products, this.isHome, this.isModern = false});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GridView.builder(
        scrollDirection: isHome ? Axis.horizontal : Axis.vertical,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: constraints.maxHeight * 0.5,
          childAspectRatio:
              (constraints.maxHeight * 0.9 / constraints.maxHeight),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: isHome
            ? ((products.length > 6) ? 6 : products.length)
            : products.length,
        itemBuilder: (ctx, index) {
          if (isModern) index = products.length - index - 1;
          Future<bool> onLikeButtonTapped(bool isLiked) async {
            await Provider.of<ProviderProducts>(context, listen: false)
                .setFavorite(products[index].id);
            return !isLiked;
          }

          return GestureDetector(
            onTap: () async {
              //  await context.read<ProviderCategories>().fetchAllData();

              Navigator.pushNamed(context, DetailsProduct.id,
                  arguments: products[index]);
            },
            child: Transform.translate(
              offset: Offset(0, index.isOdd & !isHome ? 50 : 0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: isHome
                        ? BorderRadius.circular(10)
                        : BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Expanded(
                        //Expanded هامة لضبط الارتفاعات
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: isHome
                                  ? BorderRadius.circular(10.0)
                                  : BorderRadius.circular(20.0),
                              child: Hero(
                                tag: products[index].id,
                                child: CachedNetworkImage(
                                  width: constraints.maxWidth,
                                  height: isHome
                                      ? constraints.maxHeight * 0.3
                                      : constraints.maxHeight * 0.28,
                                  fit: BoxFit.fill,
                                  imageUrl:
                                      AppUrl.URL + '${products[index].image}',
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            !isHome
                                ? Positioned(
                                    left: 0,
                                    top: 0,
                                    child: LikeButton(
                                      onTap: onLikeButtonTapped,
                                      isLiked: Provider.of<ProviderProducts>(
                                              context,
                                              listen: false)
                                          .getFavorite(products[index].id),
                                      animationDuration:
                                          Duration(milliseconds: 600),
                                      likeBuilder: (value) {
                                        return Icon(
                                          value
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: value
                                              ? Colors.red
                                              : Colors.greenAccent,
                                        );
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        products[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: isHome
                          ? constraints.maxHeight * 0.01
                          : constraints.maxHeight * 0.02,
                    ),
                    Text(
                      '\$' + products[index].price,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
