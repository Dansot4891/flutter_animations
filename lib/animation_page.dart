import 'package:flutter/material.dart';
import 'package:flutter_animations/animations/expilcit/animated_container/animated_container_ex.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation Page')),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnimatedContainerEx()),
              );
            },
            child: Text('AnimatedContainerEx'),
          ),
        ],
      ),
    );
  }
}
