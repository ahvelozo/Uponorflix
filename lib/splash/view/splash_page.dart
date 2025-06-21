import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Splash screen that mimics the popular Netflix intro but re‑branded
/// for Uponorflix.
///
/// * Black background.
/// * Bold red logo with subtle neon/glow.
/// * Smooth scale‑up + fade‑in animation.
/// * Automatic navigation to the main catalog after a short delay.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  static const _animationDuration = Duration(milliseconds: 1600);
  static const _delayBeforeNavigate = Duration(milliseconds: 2200);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _scale = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // Navigate to the next page when animation finishes (plus a short pause).
    Timer(_delayBeforeNavigate, _navigateNext);
  }

  void _navigateNext() {
    if (mounted) {
      context.go('/catalog'); // Change route as needed
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacity.value,
              child: Transform.scale(
                scale: _scale.value,
                child: child,
              ),
            );
          },
          child: const _GlowingLogo(),
        ),
      ),
    );
  }
}

/// Big glowing logo text.
///
/// Replace with an [Image.asset] if you have an actual logo file.
class _GlowingLogo extends StatelessWidget {
  const _GlowingLogo();

  @override
  Widget build(BuildContext context) {
    return Text(
      'UPONORFLIX',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w900,
        letterSpacing: -1.5,
        color: Colors.redAccent,
        shadows: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.65),
            blurRadius: 18,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}
