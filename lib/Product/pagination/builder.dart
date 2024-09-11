import 'package:flutter/widgets.dart';

typedef PaginationBuilder<T> = Future<List<T>> Function(int page);

typedef TheErrorBuilder<T> = T Function(BuildContext context, Object error);