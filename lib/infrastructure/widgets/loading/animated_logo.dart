import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/widgets/icons/service_geo.dart';

class SGIconLoading extends StatefulWidget {
  final double size;
  const SGIconLoading({super.key, required this.size});

  @override
  State<SGIconLoading> createState() => _SGIconLoadingState();
}

class _SGIconLoadingState extends State<SGIconLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: SGIcon(size: widget.size),
    );
  }
}
