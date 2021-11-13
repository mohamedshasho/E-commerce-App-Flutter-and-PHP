import 'package:ecommerce_app/componants/card_click.dart';
import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/product_Provider.dart';
import 'package:ecommerce_app/model/categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<Categories> categories;
  FilterBottomSheet({this.categories});
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String item = '0';
  double value = 0;
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Container(
        color: Color(0xFF757575),
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                lan.getText('Categories'),
              ),
              SizedBox(height: 5),
              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    CardCategory(
                      title: lan.getText('ALL'),
                      color: item == '0'
                          ? Theme.of(context).accentColor
                          : Theme.of(context).scaffoldBackgroundColor,
                      onPressed: () {
                        setState(() {
                          item = '0';
                        });
                      },
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CardCategory(
                              onPressed: () {
                                setState(() {
                                  item = widget.categories[index].id;
                                });
                              },
                              title: widget.categories[index].name,
                              color: item == widget.categories[index].id
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).scaffoldBackgroundColor,
                            ),
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(lan.getText('Price:')),
                  Text('\$0 - \$$value'),
                ],
              ),
              Slider(
                value: value,
                min: 0,
                max: 1000,
                divisions: 10,
                onChanged: (val) {
                  setState(() {
                    value = val;
                  });
                },
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 40,
                child: MaterialButton(
                  elevation: 5,
                  splashColor: primaryDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: primaryDark),
                  ),
                  animationDuration: Duration(seconds: 1),
                  color: Theme.of(context).buttonColor,
                  padding: EdgeInsets.all(10),
                  onPressed: () async {
                    await Provider.of<ProviderProducts>(context, listen: false)
                        .fetchFilter(value.toInt(), item);
                    Navigator.pop(context);
                  },
                  child: Text(lan.getText('Apply')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
