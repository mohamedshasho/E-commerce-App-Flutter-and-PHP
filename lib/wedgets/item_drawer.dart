import 'package:flutter/material.dart';

class BuildListTile extends StatelessWidget {
  final String title;
  final Function onClick;
  final IconData icondata;
  BuildListTile({this.title, this.onClick, this.icondata});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: ListTile(
        onTap: onClick,
        leading: Icon(
          icondata,
          color: Theme.of(context).selectedRowColor,
        ),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
