import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TooltipArrowPainter extends CustomPainter {
  final Size size;
  final Color color;
  final bool isInverted;
  final Color shadowColor;

  TooltipArrowPainter({
    required this.size,
    required this.color,
    required this.isInverted,
    this.shadowColor = Colors.black,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    if (isInverted) {
      path.moveTo(0.0, size.height);
      path.lineTo(size.width / 2, 0.0);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0.0, 0.0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0.0);
    }

    path.close();

    canvas.drawShadow(path, shadowColor, 4.0, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TooltipArrow extends StatelessWidget {
  final Size size;
  final ThemeData theme;
  final bool isInverted;

  const TooltipArrow({
    super.key,
    this.size = const Size(16.0, 16.0),
    required this.theme,
    this.isInverted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-size.width / 2, 0.0),
      child: CustomPaint(
        size: size,
        painter: TooltipArrowPainter(
          size: size,
          color: theme.canvasColor.withOpacity(0.5),
          isInverted: isInverted,
          shadowColor: theme.shadowColor.withOpacity(0.5),
        ),
      ),
    );
  }
}

// A tooltip with text, action buttons, and an arrow pointing to the target.
class AnimatedTooltip extends StatefulWidget {
  final Widget content;
  final GlobalKey? targetGlobalKey;
  final ThemeData? theme;
  final Widget? child;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;

  const AnimatedTooltip({
    super.key,
    required this.content,
    this.targetGlobalKey,
    this.theme,
    this.child,
    this.onEnter,
    this.onExit,
  }) : assert(child != null || targetGlobalKey != null,
            "child or targetGlobalKey must be provided");

  @override
  State<StatefulWidget> createState() => AnimatedTooltipState();
}

class AnimatedTooltipState extends State<AnimatedTooltip> {
  late double? _tooltipTop;
  late double? _tooltipBottom;
  late Alignment _tooltipAlignment;
  // late Alignment _transitionAlignment;
  late Alignment _arrowAlignment;
  bool _isInverted = false;

  final _arrowSize = const Size(16.0, 6.0);
  final _tooltipMinimumHeight = 140;

  final _arrowBottonPadding = 15.0;

  final _overlayController = OverlayPortalController();

  void _toggle() {
    if (_overlayController.isShowing) {
      _overlayController.hide();
    } else {
      _updatePosition();
      _overlayController.show();
    }
  }

  void _updatePosition() {
    final Size contextSize = MediaQuery.of(context).size;
    final BuildContext? targetContext = widget.targetGlobalKey != null
        ? widget.targetGlobalKey!.currentContext
        : context;
    final targetRenderBox = targetContext?.findRenderObject() as RenderBox;
    final targetOffset = targetRenderBox.localToGlobal(Offset.zero);
    final targetSize = targetRenderBox.size;
    // Try to position the tooltip above the target,
    // otherwise try to position it below or in the center of the target.
    final tooltipFitsAboveTarget = targetOffset.dy - _tooltipMinimumHeight >= 0;
    final tooltipFitsBelowTarget =
        targetOffset.dy + targetSize.height + _tooltipMinimumHeight <=
            contextSize.height;
    _tooltipTop = tooltipFitsAboveTarget
        ? null
        : tooltipFitsBelowTarget
            ? targetOffset.dy + targetSize.height
            : null;
    _tooltipBottom = tooltipFitsAboveTarget
        ? (contextSize.height - targetOffset.dy) + _arrowBottonPadding
        : tooltipFitsBelowTarget
            ? null
            : targetOffset.dy + targetSize.height / 2;
    // If the tooltip is below the target, invert the arrow.
    _isInverted = _tooltipTop != null;
    // Align the tooltip horizontally relative to the target.
    _tooltipAlignment = Alignment(
      (targetOffset.dx) / (contextSize.width - targetSize.width) * 2 - 1.0,
      _isInverted ? 1.0 : -1.0,
    );
    // Center the arrow horizontally on the target.
    _arrowAlignment = Alignment(
      (targetOffset.dx + targetSize.width / 2) /
              (contextSize.width - _arrowSize.width) *
              2 -
          1.0,
      _isInverted ? 1.0 : -1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    // If no theme is provided,
    // use the opposite brightness of the current theme to make the tooltip stand out.
    final theme = widget.theme ??
        ThemeData(
          useMaterial3: true,
          brightness: Theme.of(context).brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
        );

    return OverlayPortal.targetsRootOverlay(
      controller: _overlayController,
      child: widget.child != null
          ? MouseRegion(
              onEnter: (event) {
                _toggle();
                widget.onEnter?.call(event);
              },
              onExit: (event) {
                _toggle();
                widget.onExit?.call(event);
              },
              child: widget.child)
          : null,
      overlayChildBuilder: (context) {
        return Positioned(
          top: _tooltipTop,
          bottom: _tooltipBottom,
          // Provide a transition alignment to make the tooltip appear from the target.
          child: Theme(
            data: theme,
            // Don't allow the tooltip to get wider than the screen.
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isInverted)
                    Align(
                      alignment: _arrowAlignment,
                      child: TooltipArrow(
                        size: _arrowSize,
                        isInverted: true,
                        theme: theme,
                      ),
                    ),
                  Align(
                    alignment: _tooltipAlignment,
                    child: IntrinsicWidth(
                      child: Material(
                        elevation: 4.0,
                        color: theme.canvasColor.withOpacity(0.5),
                        shadowColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: widget.content,
                        ),
                      ),
                    ),
                  ),
                  if (!_isInverted)
                    Align(
                      alignment: _arrowAlignment,
                      child: TooltipArrow(
                        size: _arrowSize,
                        isInverted: false,
                        theme: theme,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
