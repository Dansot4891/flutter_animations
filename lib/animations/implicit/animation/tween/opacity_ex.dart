import 'package:flutter/material.dart';

class OpacityEx extends StatefulWidget {
  const OpacityEx({super.key});
  @override
  State<OpacityEx> createState() => _OpacityExState();
}

class _OpacityExState extends State<OpacityEx>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

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
            animation: _opacityAnimation,
            builder: (context, child) {
              return Container(
                width: 400,
                height: 400,
                color: Colors.blue.withValues(alpha: _opacityAnimation.value),
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
