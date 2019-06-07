import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 60,
          child: IconAnimation(
            controller: _animationController,
          ),
        ),
        InputAnimation(
          controller: _animationController,
        ),
        Container(
          width: 60,
          child: FlatButton(
            onPressed: () {
              _animationController.reverse();
            },
            child: Icon(Icons.close),
          ),
        ),
      ],
    );
  }
}

class IconAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> iconSizeAnim;

  IconAnimation({this.controller})
      : iconSizeAnim = Tween(
          begin: 30.0,
          end: 15.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.1),
          ),
        );

  Widget _animate(context, child) {
    return FlatButton(
      onPressed: () {
        controller.forward();
      },
      child: Icon(
        Icons.search,
        color: Colors.pink,
        size: iconSizeAnim.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _animate,
      animation: controller,
    );
  }
}

class InputAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> containerOpacityAnim;
  final Animation<double> containerBorderRadiusAnim;
  final Animation<double> containerSizeAnim;

  InputAnimation({this.controller})
      : containerOpacityAnim = Tween(
          begin: 0.0,
          end: 0.3,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.1, 0.2),
          ),
        ),
        containerSizeAnim = Tween(
          begin: 60.0,
          end: 190.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.2, 0.3),
          ),
        ),
        containerBorderRadiusAnim = Tween(
          begin: 0.0,
          end: 30.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.25, 0.4),
          ),
        );

  Widget _animate(context, child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(containerOpacityAnim.value),
        borderRadius: BorderRadius.all(
          Radius.circular(containerBorderRadiusAnim.value),
        ),
      ),
      width: containerSizeAnim.value,
      margin: EdgeInsets.all(5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _animate,
      animation: controller,
    );
  }
}
