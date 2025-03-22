import 'package:flutter/material.dart';
import 'package:poruththam_app/common/widgets/shimmers/shimmer.dart';

import '../layouts/grid_layout.dart';

class TBrandShimmer extends StatelessWidget {
  const TBrandShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const TShimmerEffect(width: 300, height: 80),
    );
  }
}
