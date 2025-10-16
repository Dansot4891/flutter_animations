import 'package:flutter/material.dart';
import 'package:flutter_animations/animations/expilcit/animated_container/animated_container_ex.dart';
import 'package:flutter_animations/animations/expilcit/animated_default_text_style/animated_default_text_style_ex.dart';
import 'package:flutter_animations/animations/expilcit/animated_opacity/animated_opacity_ex.dart';
import 'package:flutter_animations/animations/expilcit/animated_positioned/animated_positioned_ex.dart';
import 'package:flutter_animations/animations/expilcit/animated_scale/animated_scale_ex.dart';
import 'package:flutter_animations/animations/expilcit/animated_rotation/animated_rotation_ex.dart';
import 'package:flutter_animations/animations/expilcit/tween_animation_builder/tween_animation_builder_ex.dart';
import 'package:flutter_animations/animations/screen_transitions/hero/hero_animation_ex.dart';
import 'package:flutter_animations/animations/screen_transitions/transitions/custom_page_transition_ex.dart';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              titleText('Explicit Animation'),
              textButton(context, 'AnimatedContainerEx', AnimatedContainerEx()),
              textButton(
                context,
                'AnimatedDefaultTextStyleEx',
                AnimatedDefaultTextStyleEx(),
              ),
              textButton(context, 'AnimatedOpacityEx', AnimatedOpacityEx()),
              textButton(
                context,
                'AnimatedPositionedEx',
                AnimatedPositionedEx(),
              ),
              textButton(context, 'AnimatedScaleEx', AnimatedScaleEx()),
              textButton(context, 'AnimatedRotationEx', AnimatedRotationEx()),
              textButton(
                context,
                'TweenAnimationBuilderEx',
                TweenAnimationBuilderEx(),
              ),
              Divider(),
              titleText('Implicit Animation'),
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
              Divider(),
              titleText('화면 전환 애니메이션'),
              textButton(context, 'HeroAnimationEx', HeroAnimationEx()),
              textButton(
                context,
                'CustomPageTransitionEx',
                CustomPageTransitionEx(),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  ElevatedButton textButton(BuildContext context, String text, Widget widget) {
    return ElevatedButton(
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
