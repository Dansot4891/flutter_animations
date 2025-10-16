import 'package:flutter/material.dart';

/// 색상 애니메이션
class ColorTweenEx extends StatefulWidget {
  const ColorTweenEx({super.key});
  @override
  State<ColorTweenEx> createState() => _ColorTweenExState();
}

class _ColorTweenExState extends State<ColorTweenEx>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedBuilder(
              animation: _colorAnimation,
              builder: (context, child) {
                return Container(
                  width: 100,
                  height: 100,
                  color: _colorAnimation.value,
                );
              },
            ),

            ElevatedButton(
              onPressed: () {
                _controller.forward();
              },
              child: Text('start(red)'),
            ),

            ElevatedButton(
              onPressed: () {
                _controller.reverse();
              },
              child: Text('reverse(blue)'),
            ),
          ],
        ),
      ),
    );
  }
}
