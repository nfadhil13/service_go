import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/widgets/icons/service_geo.dart';

class ServiceGoIconLoading extends StatefulWidget {
  final double size;
  const ServiceGoIconLoading({super.key, required this.size});

  @override
  State<ServiceGoIconLoading> createState() => _ServiceGoIconLoadingState();
}

class _ServiceGoIconLoadingState extends State<ServiceGoIconLoading>
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
      child: ServiceGoIcon(size: widget.size),
    );
  }
}
