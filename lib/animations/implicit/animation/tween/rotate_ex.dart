import 'package:flutter/material.dart';

/// 회전 애니메이션
class RotateEx extends StatefulWidget {
  const RotateEx({super.key});
  @override
  State<RotateEx> createState() => _RotateExState();
}

class _RotateExState extends State<RotateEx>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 360).animate(_controller);
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
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value / 180,
                child: Container(width: 300, height: 300, color: Colors.red),
              );
            },
          ),

          ElevatedButton(
            onPressed: () {
              _controller.forward();
            },
            child: Text('start(360)'),
          ),

          ElevatedButton(
            onPressed: () {
              _controller.reverse();
            },
            child: Text('reverse(0)'),
          ),
        ],
      ),
    );
  }
}
