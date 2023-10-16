import 'package:flutter/material.dart';

class AnimatedIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;

  const AnimatedIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  _AnimatedIndexedStackState createState() => _AnimatedIndexedStackState();
}

class _AnimatedIndexedStackState extends State<AnimatedIndexedStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final double _initPosition = 0.3;
  double _position = 1.0;

  @override
  void didUpdateWidget(oldWidget) {
    if (widget.index != oldWidget.index) {
      bool isRightScreen = widget.index > oldWidget.index;
      setState(() {
        _position = isRightScreen ? _initPosition : -_initPosition;
      });
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
      child: SlideTransition(
        position: Tween(
          begin: Offset(_position, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOutCubic,
          ),
        ),
        child: IndexedStack(
          index: widget.index,
          children: widget.children,
        ),
      ),
    );
  }
}
