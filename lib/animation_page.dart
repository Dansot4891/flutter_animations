import 'package:flutter/material.dart';
import 'package:flutter_animations/animations/expilcit/animated_container/animated_container_ex.dart';
import 'package:flutter_animations/animations/expilcit/animated_default_text_style/animated_default_text_style_ex.dart';
import 'package:flutter_animations/animations/expilcit/animated_opacity/animated_opacity_ex.dart';
import 'package:flutter_animations/animations/expilcit/animated_positioned/animated_positioned_ex.dart';
import 'package:flutter_animations/animations/expilcit/tween_animation_builder/tween_animation_builder_ex.dart';
import 'package:flutter_animations/animations/implicit/animated_builder/animated_builder_ex.dart';
import 'package:flutter_animations/animations/implicit/animation/tween/opacity_ex.dart';
import 'package:flutter_animations/animations/implicit/animation/tween/rotate_ex.dart';
import 'package:flutter_animations/animations/implicit/animation_controller/animation_controller_ex.dart';
import 'package:flutter_animations/animations/implicit/animation/tween/tween_ex.dart';
import 'package:flutter_animations/animations/implicit/animation/tween/color_tween_ex.dart';
import 'package:flutter_animations/animations/implicit/animation/curve/curve_ex.dart';

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
            textButton(context, 'AnimatedContainerEx', AnimatedContainerEx()),
            textButton(
              context,
              'AnimatedDefaultTextStyleEx',
              AnimatedDefaultTextStyleEx(),
            ),
            textButton(context, 'AnimatedOpacityEx', AnimatedOpacityEx()),
            textButton(context, 'AnimatedPositionedEx', AnimatedPositionedEx()),
            textButton(
              context,
              'TweenAnimationBuilderEx',
              TweenAnimationBuilderEx(),
            ),
            Divider(),
            textButton(
              context,
              'AnimationControllerEx',
              AnimationControllerEx(),
            ),
            textButton(context, 'AnimatedBuilderEx', AnimatedBuilderEx()),
            textButton(context, 'TweenEx', TweenEx()),
            textButton(context, 'ColorTweenEx', ColorTweenEx()),
            textButton(context, 'CurveEx', CurveEx()),
            textButton(context, 'OpacityEx', OpacityEx()),
            textButton(context, 'RotateEx', RotateEx()),
          ],
        ),
      ),
    );
  }

  TextButton textButton(BuildContext context, String text, Widget widget) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      },
      child: Text(text, style: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }
}
