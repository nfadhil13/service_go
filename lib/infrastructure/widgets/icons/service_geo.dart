import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/styles/color.dart';

class ServiceGoIcon extends StatelessWidget {
  final double size;
  const ServiceGoIcon({super.key, this.size = 200});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final fontsize = size * 0.17;
    final borderSize = size * 0.045;
    return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              radius: .7,
              colors: [
                Colors.white,
                color.primary,
                color.primary,
              ],
            )),
        child: SizedBox(
          width: size * 0.87,
          height: size * 0.87,
          child: Container(
            padding: EdgeInsets.all(borderSize)
                .copyWith(bottom: 0, top: borderSize * 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: color.primaryContainer, width: borderSize),
                color: Colors.white,
                shape: BoxShape.circle),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: "Service",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      fontSize: fontsize),
                ),
                TextSpan(
                  text: "GO",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: color.primary,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      fontSize: fontsize),
                ),
              ]),
            ),
          ),
        ));
  }
}
