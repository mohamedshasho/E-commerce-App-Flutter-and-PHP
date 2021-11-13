import 'package:ecommerce_app/componants/show_toast.dart';
import 'package:ecommerce_app/data/card_provider.dart';
import 'package:ecommerce_app/data/language_provider.dart';
import 'package:provider/provider.dart';

import '../componants/animation_add_card.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({this.title, this.image, this.id});
  final String title;
  final String image;
  final String id;
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: MaterialButton(
        child: Text(
          lan.getText('Add to cart'),
          style: Theme.of(context).textTheme.headline2,
        ),
        onPressed: () async {
          bool isSet = await Provider.of<CartProvider>(context, listen: false)
              .setCard(id);
          if (isSet)
            showGeneralDialog(
              context: context,
              barrierLabel: "",
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: const Duration(milliseconds: 500),
              barrierDismissible: false,
              useRootNavigator: false,
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
                return Center(
                  child: AnimationAddCard(image),
                );
              },
              transitionBuilder: (_, anim, __, child) {
                return FadeTransition(
                  opacity: anim,
                  child: child,
                );
              },
            );
          else
            showToast(lan.getText('Is Already added'));
        },
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
