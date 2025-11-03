import 'package:flutter/material.dart';

class TweenEx extends StatefulWidget {
  const TweenEx({super.key});
  @override
  State<TweenEx> createState() => _TweenExState();
}

class _TweenExState extends State<TweenEx> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _sizeAnimation = Tween<double>(begin: 50, end: 200).animate(_controller);

    _opacityAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Controller vs Animation')),
      body: Column(
        children: [
          AnimatedBuilder(
            animation: _sizeAnimation,
            builder: (context, child) {
              return Container(
                width: _sizeAnimation.value,
                height: _sizeAnimation.value,
                color: Colors.blue,
              );
            },
          ),

          ElevatedButton(
            onPressed: () {
              _controller.forward();
            },
            child: Text('start(200)'),
          ),

          ElevatedButton(
            onPressed: () {
              _controller.reverse();
            },
            child: Text('reverse(50)'),
          ),

          AnimatedBuilder(
            animation: _opacityAnimation,
            builder: (context, child) {
              return SizedBox(
                width: _opacityAnimation.value,
                height: _opacityAnimation.value,
              );
            },
          ),

          ElevatedButton(
            onPressed: () {
              _controller.forward();
            },
            child: Text('start(1.0)'),
          ),

          ElevatedButton(
            onPressed: () {
              _controller.reverse();
            },
            child: Text('reverse(0.2)'),
          ),
        ],
      ),
    );
  }
}
