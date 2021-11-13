import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/data/notification_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  static const String id = 'NotificationScreen';
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    Widget buildContainer(Alignment al) {
      return Container(
        padding: EdgeInsets.all(5),
        alignment: al,
        child: Icon(
          Icons.remove_circle_outline,
          color: Theme.of(context).selectedRowColor,
        ),
        color: Theme.of(context).errorColor,
      );
    }

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getText('Notification')),
        ),
        body: Consumer<NotificationProvider>(
          builder: (context, snapshot, _) {
            var title = snapshot.title;
            var body = snapshot.body;
            return ListView.builder(
              itemCount: snapshot.title.length,
              itemBuilder: (ctx, index) {
                return Dismissible(
                  key: Key(title[index]),
                  onDismissed: (val) {
                    Provider.of<NotificationProvider>(context, listen: false)
                        .deleteNot(title[index], body[index]);
                  },
                  background: buildContainer(Alignment.centerLeft),
                  secondaryBackground: buildContainer(Alignment.centerRight),
                  child: ExpansionTile(
                    expandedAlignment: Alignment.centerRight,
                    tilePadding: EdgeInsets.all(5),
                    title: Text(
                      title[index],
                      textAlign: TextAlign.right,
                    ),
                    childrenPadding: EdgeInsets.all(8),
                    children: [
                      Text(
                        body[index],
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
