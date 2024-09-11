import 'package:tuple/tuple.dart';
import '../../model/ProductResponse.dart';
import '../../model/product/product.dart';
import '../../pagination/datasource/page_keyed_datasource.dart';
import 'product_search_service.dart';

class ProductSearchDataSource extends PageKeyedDataSource<int, Product> {
  ProductSearchService service;
  final String? keyWord;

  ProductSearchDataSource({required this.service, this.keyWord});

  @override
  Future<Tuple2<List<Product>, int>> loadInitial(int pageSize) async {
    ProductResponse productResponse;

    productResponse = await service.fetchProductsByKeyWord(keyWord, 0);

    List<Product> products = productResponse.embedded.products;
    return Tuple2(products, 1);
  }

  @override
  Future<Tuple2<List<Product>, int>> loadPageAfter(
      int params, int pageSize) async {
    ProductResponse productResponse;

      productResponse =
          await service.fetchProductsByKeyWord(keyWord, params);

    List<Product> products = productResponse.embedded.products;
    return Tuple2(products, params + 1);
  }
}
