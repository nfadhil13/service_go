import 'dart:async';
import 'package:flutter/material.dart';

class SGHoursSinceStartWidget extends StatefulWidget {
  final Widget Function(int hours, int minutes, int seconds) builder;
  final DateTime startDateTime;

  const SGHoursSinceStartWidget(
      {super.key, required this.startDateTime, required this.builder});

  @override
  State<SGHoursSinceStartWidget> createState() =>
      _SGHoursSinceStartWidgetState();
}

class _SGHoursSinceStartWidgetState extends State<SGHoursSinceStartWidget> {
  late Timer _timer;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateHoursSinceStart();
    });
  }

  void _updateHoursSinceStart() {
    DateTime currentDateTime = DateTime.now();
    Duration difference = currentDateTime.difference(widget.startDateTime);
    _hours = difference.inHours;
    _minutes = difference.inMinutes.remainder(60);
    _seconds = difference.inSeconds.remainder(60);
    setState(() {});
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_hours, _minutes, _seconds);
  }
}
