import 'package:ecommerce_app/data/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Language extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    String selectCurrency = lan.isEn ? 'English' : 'العربية';
    return DropdownButtonHideUnderline(
      //اخفاء الخط
      child: DropdownButton(
        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
        value: selectCurrency,
        onChanged: (value) {
          selectCurrency = value;
          if (value == "English")
            lan.changeLan(true);
          else
            lan.changeLan(false);
        },
        items: [
          DropdownMenuItem(
            value: 'English',
            child: Text(
              'English',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          DropdownMenuItem(
            value: 'العربية',
            child: Text(
              'العربية',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ],
      ),
    );
  }
}
