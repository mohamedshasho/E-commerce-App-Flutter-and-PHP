import 'package:flutter/material.dart';

class CheckScreen extends StatelessWidget {
  final double check;
  const CheckScreen({@required this.check});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check'),
      ),
      body: Center(
        child: Text('$check'),
      ),
    );
  }
}
