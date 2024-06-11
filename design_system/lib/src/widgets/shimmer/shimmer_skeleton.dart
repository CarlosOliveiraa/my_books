import 'package:flutter/material.dart';

class ShimmerSkeleton extends StatelessWidget {
  final double? height, width;

  const ShimmerSkeleton({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}
