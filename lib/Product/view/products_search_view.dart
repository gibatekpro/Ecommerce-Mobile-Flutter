import 'package:ecommerce_flutter/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../util/util.dart';
import '../pagination/paging_grid_view.dart';
import '../widget/product_card.dart';
import '../model/product/product.dart';
import '../service/product_search/product_search_datasource.dart';
import '../service/product_search/product_search_service.dart';

class ProductsSearchView extends StatefulWidget {
  final String? keyWord;

  const ProductsSearchView({super.key, this.keyWord});

  @override
  ProductsSearchViewState createState() => ProductsSearchViewState();
}

class ProductsSearchViewState extends State<ProductsSearchView> {
  final GlobalKey key = GlobalKey();
  late ProductSearchDataSource dataSource;

  @override
  void initState() {
    super.initState();

    dataSource = ProductSearchDataSource(
        service: ProductSearchService(), keyWord: widget.keyWord);
  }

  @override
  Widget build(BuildContext context) {
    return PagingGridView<Product>(
      emptyBuilder: (context) {
        return Container();
      },
      key: key,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, data, child) {
        return InkWell(
          onTap: () {
            setState(() {
              Modular.to.pushNamed(Routes.productDetails, arguments: data);
            });
          },
          child: ProductCard(
            id: data.id!,
            name: data.name!,
            imageUrl: data.imageUrl!,
            unitPrice: data.unitPrice,
            unitsInStock: data.unitsInStock!
          ),
        );
      },
      delegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
      pageDataSource: dataSource,
    );
  }
}
