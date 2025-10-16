import 'package:flutter/material.dart';
import 'package:flutter_animations/animations/expilcit/animated_container/animated_container_ex.dart';
import 'package:flutter_animations/animations/expilcit/animated_default_text_style/animated_default_text_style_ex.dart';
import 'package:flutter_animations/animations/expilcit/animated_opacity/animated_opacity_ex.dart';
import 'package:flutter_animations/animations/expilcit/animated_positioned/animated_positioned_ex.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimatedContainerEx(),
                  ),
                );
              },
              child: Text('AnimatedContainerEx'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimatedDefaultTextStyleEx(),
                  ),
                );
              },
              child: Text('AnimatedDefaultTextStyleEx'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimatedOpacityEx()),
                );
              },
              child: Text('AnimatedOpacityEx'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimatedPositionedEx(),
                  ),
                );
              },
              child: Text('AnimatedPositionedEx'),
            ),
          ],
        ),
      ),
    );
  }
}
