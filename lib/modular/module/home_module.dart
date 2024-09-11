import 'package:ecommerce_flutter/util/routes.dart';
import 'package:ecommerce_flutter/Product/view/products_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../Product/view/products_search_view.dart';
import '../../Product/widget/products_grid_view.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const ProductsView(title: 'Ecommerce'), children: [
  ChildRoute(Routes.products, child: (context, args) => const ProductsGridView()),
  ChildRoute('${Routes.productsByCategory}/:id', child: (context, args) => ProductsGridView(categoryId: int.parse(args.params['id']))),
  ChildRoute('${Routes.productSearch}/:keyWord', child: (context, args) => ProductsSearchView(keyWord: args.params['keyWord'])),
  ]),
  ];
}