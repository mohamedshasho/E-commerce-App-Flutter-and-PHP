import 'package:ecommerce_app/model/app_api.dart';
import 'package:flutter/material.dart';

class AnimationAddCard extends StatefulWidget {
  final String image;
  const AnimationAddCard(this.image);
  @override
  _AnimationAddCardState createState() => _AnimationAddCardState();
}

class _AnimationAddCardState extends State<AnimationAddCard>
    with SingleTickerProviderStateMixin {
  Animation<AlignmentGeometry> _animation;
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<AlignmentGeometry>(
      begin: Alignment.center,
      end: Alignment.bottomCenter,
    ).animate(_controller);
    _controller.forward();
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlignTransition(
      alignment: _animation,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(
              AppUrl.URL + '${widget.image}',
            ),
          ),
        ),
      ),
    );
  }
}
