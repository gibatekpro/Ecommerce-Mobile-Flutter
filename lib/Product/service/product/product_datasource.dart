import 'package:tuple/tuple.dart';
import '../../model/ProductResponse.dart';
import '../../model/product/product.dart';
import '../../pagination/datasource/page_keyed_datasource.dart';
import 'product_service.dart';


class ProductDataSource extends PageKeyedDataSource<int, Product> {
  ProductService service;
  final int? categoryId;

  ProductDataSource({required this.service, this.categoryId});

  @override
  Future<Tuple2<List<Product>, int>> loadInitial(int pageSize) async {
    ProductResponse productResponse;
    if (categoryId == null) {
      productResponse = await service.fetchAllProducts(0);
    }else{
      productResponse = await service.fetchProductsByProductCategoryId(categoryId, 0);
    }

    List<Product> products = productResponse.embedded.products;
    return Tuple2(products, 1);
  }

  @override
  Future<Tuple2<List<Product>, int>> loadPageAfter(int params, int pageSize) async {
    ProductResponse productResponse;
    if (categoryId == null) {
      productResponse = await service.fetchAllProducts(params);
    }else{
      productResponse = await service.fetchProductsByProductCategoryId(categoryId, params);
    }
    List<Product> products = productResponse.embedded.products;
    return Tuple2(products, params + 1);
  }
}