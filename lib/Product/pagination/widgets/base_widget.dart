import 'package:flutter/material.dart';

import '../builder.dart';
import '../datasource/data_source.dart';

typedef ValueIndexWidgetBuilder<T> = Widget Function(
    BuildContext context, T value, int index);

abstract class BaseWidget<T> extends StatefulWidget {
  /// Signature for a function that creates a widget empty
  final WidgetBuilder? emptyBuilder;

  /// Signature for a function that creates a widget loading
  final WidgetBuilder? loadingBuilder;

  /// Signature for a function that creates a widget Error
  final TheErrorBuilder? errorBuilder;

  /// Signature for a function that creates a widget for item
  final ValueIndexWidgetBuilder<T> itemBuilder;

  /// DataSource for current ScrollView [ListView - GridView]
  final DataSource<T> pageDataSource;

  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  BaseWidget(
      {Key? key,
        this.emptyBuilder,
        this.loadingBuilder,
        this.errorBuilder,
        this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
        required this.itemBuilder,
        required this.pageDataSource})
      : super(key: key);
}