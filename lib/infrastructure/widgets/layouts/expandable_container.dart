import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';

class SGExpandableContainer extends StatefulWidget {
  final Widget child;
  final String title;
  final Color? color;
  final Color? bakcgorundColor;
  final EdgeInsets? padding;
  const SGExpandableContainer(
      {super.key,
      required this.child,
      this.padding,
      required this.title,
      this.color,
      this.bakcgorundColor});

  @override
  State<SGExpandableContainer> createState() => _SGExpandableContainerState();
}

class _SGExpandableContainerState extends State<SGExpandableContainer> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? context.color.primary;
    return Container(
      decoration: BoxDecoration(
          color: widget.bakcgorundColor ?? color.withOpacity(.08),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(12)),
      padding: widget.padding ?? const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() {
              _isOpen = !_isOpen;
            }),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: context.text.labelLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(_isOpen ? Icons.arrow_drop_down : Icons.arrow_drop_up)
              ],
            ),
          ),
          if (_isOpen) widget.child
        ],
      ),
    );
  }
}
