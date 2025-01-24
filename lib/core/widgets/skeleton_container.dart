import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonContainer extends StatelessWidget {
  static const Color gray = Color.fromRGBO(224, 224, 224, 1);
  static const Color grayLight = Color.fromRGBO(247, 247, 247, 1);

  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Color? bgColor;

  const SkeletonContainer._({
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    super.key,
    this.bgColor = grayLight,
  });

  const SkeletonContainer.square({
    required double width,
    required double height,
    Color bgColor = gray,
    Key? key,
  }) : this._(width: width, height: height, bgColor: bgColor, key: key);

  const SkeletonContainer.rounded({
    required double width,
    required double height,
    Color bgColor = gray,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(4)),
    Key? key,
  }) : this._(
          width: width,
          height: height,
          borderRadius: borderRadius,
          bgColor: bgColor,
          key: key,
        );

  const SkeletonContainer.circular({
    required double width,
    required double height,
    Color bgColor = gray,
    Key? key,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(80)),
  }) : this._(width: width, height: height, borderRadius: borderRadius, bgColor: bgColor, key: key);

  @override
  Widget build(BuildContext context) => SkeletonAnimation(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: borderRadius,
          ),
        ),
      );
}
