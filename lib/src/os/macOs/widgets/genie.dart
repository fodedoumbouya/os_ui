import 'package:flutter/material.dart';

class GenieEffect extends StatefulWidget {
  bool isMinimized;
  Widget child;
  GenieEffect({required this.isMinimized, required this.child, super.key});

  @override
  State<GenieEffect> createState() => _GenieEffectState();
}

class _GenieEffectState extends State<GenieEffect>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  // final bool _isMinimizing = false;
  // late Animation<Offset> _translationAnimation;
  late Animation<double> _scaleAnimation;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 400),
  //   );
  //   _animation = CurvedAnimation(
  //     parent: _controller,
  //     curve: Curves.easeOut,
  //   );
  // }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut, //fastEaseInToSlowEaseOut
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastEaseInToSlowEaseOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _minimizeWindow() async {
    // _isMinimizing = true;
    // rebuildState();

    await _controller.forward();

    // _isMinimizing = false;
    // rebuildState();
  }

  Future<void> _restoreWindow() async {
    await _controller.reverse();

    // rebuildState();
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

        // Transform.translate(
        //   offset: Offset(
        //     _animation.value / MediaQuery.of(context).size.width,
        //     _animation.value * MediaQuery.of(context).size.height,
        //   ),
        //   child: child,
        // );

        // Transform.scale(
        //   // scaleY: 1 - _animation.value,
        //   scaleX: 1 - _animation.value,
        //   // scale: 1 - _animation.value,
        //   child: child,
        // );
      },
      child: widget.child,
    );
  }
}
