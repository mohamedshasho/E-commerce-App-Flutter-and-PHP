import 'package:ecommerce_app/data/language_provider.dart';
import '../data/product_Provider.dart';
import '../data/search_provider.dart';
import '../model/products.dart';
import '../screens/details_products.dart';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SearchScreen extends StatelessWidget {
  static const String id = 'searchScreen';
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    bool home = ModalRoute.of(context).settings.arguments;
    if (home == null) home = false;
    return SafeArea(
      child: Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  home
                      ? IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                          },
                        )
                      : const SizedBox(),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TypeAheadField(
                        loadingBuilder: (ctx) {
                          return Icon(Icons.search);
                        },
                        noItemsFoundBuilder: (ctx) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(lan.getText('no Items Found')),
                              Icon(
                                Icons.error_outline,
                                color: Theme.of(context).selectedRowColor,
                              ),
                            ],
                          );
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: home ? true : false,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: lan.getText('Search for items'),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          if (pattern.length > 1) {
                            // await Provider.of<ProviderCategories>(context,
                            //         listen: false)
                            //     .fetchAllData();
                            return await Provider.of<ProviderProducts>(context,
                                    listen: false)
                                .searchItems(pattern);
                          }
                          return null;
                        },
                        itemBuilder: (context, data) {
                          Products pro = data;
                          return ListTile(
                            leading: Icon(Icons.shopping_cart),
                            title: Text(pro.name),
                            subtitle: Text('\$${pro.price}'),
                          );
                        },
                        onSuggestionSelected: (data) {
                          Products pro = data;
                          Navigator.pushNamed(context, DetailsProduct.id,
                              arguments: pro);
                          Provider.of<SearchProvider>(context, listen: false)
                              .setSearched(pro.name);
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              Provider.of<SearchProvider>(context, listen: false)
                          .searched
                          .length !=
                      0
                  ? Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      child: Text(
                        lan.getText('recent:'),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  : Container(),
              Consumer<SearchProvider>(
                builder: (ctx, snapShot, child) {
                  List<String> search = snapShot.searched;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: search.length,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text('${search[index]}'),
                          trailing: IconButton(
                            onPressed: () {
                              Provider.of<SearchProvider>(context,
                                      listen: false)
                                  .deleteSearched(search[index]);
                            },
                            icon: Icon(Icons.remove),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
