import 'package:flutter/material.dart';

class GenieEffect extends StatefulWidget {
  final bool isMinimized;
  final Widget child;
  const GenieEffect(
      {required this.isMinimized, required this.child, super.key});

  @override
  State<GenieEffect> createState() => _GenieEffectState();
}

class _GenieEffectState extends State<GenieEffect>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _minimizeWindow() async {
    await _controller.forward();
  }

  Future<void> _restoreWindow() async {
    await _controller.reverse();
  }

  @override
  void didUpdateWidget(covariant GenieEffect oldWidget) {
    if (widget.isMinimized != oldWidget.isMinimized) {
      if (widget.isMinimized) {
        _minimizeWindow();
      } else {
        _restoreWindow();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 - (_scaleAnimation.value * _animation.value),
          child: Transform.translate(
            offset: Offset(
              _animation.value / MediaQuery.of(context).size.width,
              _animation.value * MediaQuery.of(context).size.height,
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
