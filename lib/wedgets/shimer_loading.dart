import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  final bool isListView;

  const ShimmerList({this.isListView = true});
  @override
  Widget build(BuildContext context) {
    var mqHeight = MediaQuery.of(context).size.height;
    var mqWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: isListView
          ? ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Shimmer.fromColors(
                      highlightColor: Colors.white,
                      baseColor: Colors.grey[300],
                      child: ShimmerLayoutList(),
                      // period: Duration(milliseconds: time),
                    ));
              },
            )
          : GridView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: mqHeight * 0.3,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Shimmer.fromColors(
                    highlightColor: Colors.white,
                    baseColor: Colors.grey[300],
                    child: ShimmerLayoutGrid(),
                  ),
                );
              },
            ),
    );
  }
}

class ShimmerLayoutGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mqHeight = MediaQuery.of(context).size.height;
    var mqWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      height: mqHeight * 0.1,
      width: mqWidth * 0.2,
      color: Colors.grey,
    );
  }
}

class ShimmerLayoutList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mqHeight = MediaQuery.of(context).size.height;
    var mqWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: mqHeight * 0.1,
            width: mqWidth * 0.2,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: mqHeight * 0.02,
                width: mqWidth * 0.5,
                color: Colors.grey,
              ),
              SizedBox(height: mqHeight * 0.02),
              Container(
                height: mqHeight * 0.02,
                width: mqWidth * 0.7,
                color: Colors.grey,
              ),
              SizedBox(height: mqHeight * 0.02),
              Container(
                height: mqHeight * 0.02,
                width: mqWidth * 0.2,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
