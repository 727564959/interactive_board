library pushable_button;

import 'package:flutter/material.dart';

/// A widget to show a "3D" pushable button
class PushableButton extends StatefulWidget {
  const PushableButton({
    super.key,
    this.child,
    required this.hslColor,
    required this.height,
    this.elevation = 8.0,
    this.shadow,
    this.onPressed,
  }) : assert(height > 0);

  /// child widget (normally a Text or Icon)
  final Widget? child;

  /// Color of the top layer
  /// The color of the bottom layer is derived by decreasing the luminosity by 0.15
  final HSLColor hslColor;

  /// height of the top layer
  final double height;

  /// elevation or "gap" between the top and bottom layer
  final double elevation;

  /// An optional shadow to make the button look better
  /// This is added to the bottom layer only
  final BoxShadow? shadow;

  /// button pressed callback
  final VoidCallback? onPressed;

  @override
  State<PushableButton> createState() => _PushableButtonState();
}

class _PushableButtonState extends State<PushableButton> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  bool _isDragInProgress = false;
  Offset _gestureLocation = Offset.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _gestureLocation = details.localPosition;
    _animationController.forward().then((_) => _animationController.reverse());
    widget.onPressed?.call();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_isDragInProgress && mounted) {
        _animationController.reverse();
      }
    });
  }

  void _handleDragStart(DragStartDetails details) {
    _gestureLocation = details.localPosition;
    _isDragInProgress = true;
    _animationController.forward();
  }

  void _handleDragEnd(Size buttonSize) {
    //print('drag end (in progress: $_isDragInProgress)');
    if (_isDragInProgress) {
      _isDragInProgress = false;
      _animationController.reverse();
    }
    if (_gestureLocation.dx >= 0 &&
        _gestureLocation.dx < buttonSize.width &&
        _gestureLocation.dy >= 0 &&
        _gestureLocation.dy < buttonSize.height) {
      widget.onPressed?.call();
    }
  }

  void _handleDragCancel() {
    if (_isDragInProgress) {
      _isDragInProgress = false;
      _animationController.reverse();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _gestureLocation = details.localPosition;
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = widget.height + widget.elevation;
    return SizedBox(
      height: totalHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonSize = Size(constraints.maxWidth, constraints.maxHeight);
          return GestureDetector(
            onTapDown: _handleTapDown,
            // onTapUp: _handleTapUp,
            // onTapCancel: _handleTapCancel,
            // onHorizontalDragStart: _handleDragStart,
            // onHorizontalDragEnd: (_) => _handleDragEnd(buttonSize),
            // onHorizontalDragCancel: _handleDragCancel,
            // onHorizontalDragUpdate: _handleDragUpdate,
            // onVerticalDragStart: _handleDragStart,
            // onVerticalDragEnd: (_) => _handleDragEnd(buttonSize),
            // onVerticalDragCancel: _handleDragCancel,
            // onVerticalDragUpdate: _handleDragUpdate,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final top = _animationController.value * widget.elevation;
                final hslColor = widget.hslColor;
                final bottomHslColor = hslColor.withLightness(hslColor.lightness - 0.15);
                return Stack(
                  children: [
                    // Draw bottom layer first
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: totalHeight - top,
                        decoration: BoxDecoration(
                          color: bottomHslColor.toColor(),
                          boxShadow: widget.shadow != null ? [widget.shadow!] : [],
                          borderRadius: BorderRadius.circular(widget.height / 2),
                        ),
                      ),
                    ),
                    // Then top (pushable) layer
                    Positioned(
                      left: 0,
                      right: 0,
                      top: top,
                      child: Container(
                        height: widget.height,
                        decoration: ShapeDecoration(
                          color: hslColor.toColor(),
                          shape: const StadiumBorder(),
                        ),
                        child: Center(child: widget.child),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
