import 'package:flutter/material.dart';

/// AnimatedScale 애니메이션 예제
class AnimatedScaleEx extends StatefulWidget {
  const AnimatedScaleEx({super.key});

  @override
  State<AnimatedScaleEx> createState() => _AnimatedScaleExState();
}

class _AnimatedScaleExState extends State<AnimatedScaleEx> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedScale Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: _scale,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Scale Animation',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Scale: ${_scale.toStringAsFixed(1)}'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _scale = 2.0;
                    });
                  },
                  child: const Text('Scale Up'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _scale = 0.5;
                    });
                  },
                  child: const Text('Scale Down'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _scale = 1.0;
                });
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
