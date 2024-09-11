import 'package:ecommerce_flutter/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../pagination/paging_grid_view.dart';
import 'product_card.dart';
import '../model/product/product.dart';
import '../service/product/product_datasource.dart';
import '../service/product/product_service.dart';

class ProductsGridView extends StatefulWidget {
  final int? categoryId;

  const ProductsGridView({super.key, this.categoryId});

  @override
  ProductsGridViewState createState() => ProductsGridViewState();
}

class ProductsGridViewState extends State<ProductsGridView> {
  final GlobalKey key = GlobalKey();
  late ProductDataSource dataSource;

  @override
  void initState() {
    super.initState();
    if (widget.categoryId == null) {
      dataSource = ProductDataSource(service: ProductService());
    } else {
      dataSource = ProductDataSource(
          service: ProductService(), categoryId: widget.categoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagingGridView<Product>(
      emptyBuilder: (context) {
        return Container();
      },
      key: key,
      padding: const EdgeInsets.all(16),
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
              unitsInStock: data.unitsInStock!),
        );
      },
      delegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.6),
      pageDataSource: dataSource,
    );
  }
}
