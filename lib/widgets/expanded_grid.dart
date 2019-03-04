import 'package:flutter/material.dart';
import 'package:nure_schedule/main.dart';
import 'package:nure_schedule/widgets/no_glow_scroll_behavior.dart';

typedef Widget ExpandedGridItemBuilder(BuildContext context, int index, double itemWidth, double itemHeight);

class ExpandedGrid extends StatelessWidget {
  final int itemCount;
  final ExpandedGridItemBuilder itemBuilder;

  ExpandedGrid({
    @required this.itemBuilder,
    @required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    log('ExpandedGrid', 'build');
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth = constraints.maxWidth;
        double itemHeight = constraints.maxHeight / itemCount;
        double aspectRatio = itemWidth / itemHeight;

        if (aspectRatio <= 0) return Container();

        return ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: aspectRatio,
            ),
            itemCount: itemCount,
            scrollDirection: Axis.vertical,
            addRepaintBoundaries: false,
            shrinkWrap: true,
            addAutomaticKeepAlives: false,
            itemBuilder: (context, index) => itemBuilder(context, index, itemWidth, itemHeight),
          ),
        );
      },
    );
  }
}
