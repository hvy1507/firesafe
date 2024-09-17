import 'dart:math';

import 'package:firesafe_vnex/utils/extensions/list.ext.dart';
import 'package:flutter/material.dart';

/// specify the ordering of [StaticGrid].
enum StaticGridLayoutOrder {
  /// Left -> right -> top -> bottom
  lrtb,

  /// Top -> bottom -> left -> right
  tblr,
}

class StaticGrid extends StatelessWidget {
  /// Create a static grid with predefined [column] and [row] count. One of them can be omitted.
  ///
  /// If [column] is omitted, [children] will be ordered as top -> bottom -> left -> right.
  ///
  /// If [row] is omitted, [children] will be ordered as left -> right -> top -> bottom.
  ///
  /// If both are specified, order must also be specified and the number of children cannot exceed the number of
  /// cell in the grid ([row]*[column]).
  ///
  /// [rowSpacing] specify the spacing between each row.
  ///
  /// [columnSpacing] specify the spacing between each column. if [columnSpacing] is
  /// less than 0, a dynamic spacing will be placed between them.
  const StaticGrid({
    super.key,
    this.column,
    this.row,
    required this.children,
    this.order = StaticGridLayoutOrder.lrtb,
    this.rowSpacing = 0,
    this.columnSpacing = 0,
  });

  final int? column;
  final int? row;
  final double rowSpacing;
  final double columnSpacing;
  final StaticGridLayoutOrder order;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(row ?? (children.length / column!).ceil(), (r) {
        return Row(
          mainAxisAlignment: (columnSpacing < 0) ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(column ?? (children.length / row!).ceil(), (c) {
            if (row != null && column != null) {
              return switch (order) {
                StaticGridLayoutOrder.lrtb => children.length <= r * column! + c ? const SizedBox.shrink() : children[r * column! + c],
                StaticGridLayoutOrder.tblr => children.length <= c * row! + r ? const SizedBox.shrink() : children[c * row! + r],
              };
            } else if (row != null) {
              final index = c * row! + r;
              if (children.length <= index) {
                return const SizedBox.shrink();
              }
              return children[index];
            } else {
              final index = r * column! + c;
              if (children.length <= index) {
                return const SizedBox.shrink();
              }
              return children[index];
            }
          }).addBetween(SizedBox(width: max(0, columnSpacing))),
        );
      }).addBetween(SizedBox(height: rowSpacing)),
    );
  }
}
