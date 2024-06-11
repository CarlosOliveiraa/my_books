import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../design_system.dart';

class BookCardShimmer extends StatelessWidget {
  const BookCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsExtensions>();
    return Shimmer.fromColors(
      baseColor: colors!.baseColorShimmer!,
      highlightColor: colors.highlightColorShimmer!,
      child: const Column(
        children: [
          ShimmerSkeleton(
            width: 120,
            height: 130,
          ),
          SizedBox(height: 10),
          ShimmerSkeleton(
            width: 100,
            height: 15,
          )
        ],
      ),
    );
  }
}
