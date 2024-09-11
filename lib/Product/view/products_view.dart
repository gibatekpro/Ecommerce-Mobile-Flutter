import 'package:ecommerce_flutter/Product/widget/nav_drawer_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../cart/widget/cart_menu_icon.dart';
import '../../util/routes.dart';
import '../model/product_category.dart';
import '../service/product_categories/product_category_service.dart';
import '../widget/easy_search_bar/easy_search_bar.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key, required this.title});

  final String title;

  @override
  State<ProductsView> createState() => ProductsViewState();
}

class ProductsViewState extends State<ProductsView> {
  late Future<List<ProductCategory>> futureProduct;

  int menuItemId = 1;

  @override
  void initState() {
    super.initState();
    // When the app is first started, load all the products
    Modular.to.pushNamed(Routes.products);
    futureProduct = ProductCategoryService.fetchProductCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EasySearchBar(
          title: Text(widget.title),
          onSearch: (value) => setState(() {
            Modular.to.pushNamed('${Routes.productSearch}/$value');
          }),
          actions: const [
            CartMenuIcon(),
          ],
        ),
        drawer: Drawer(
          child: FutureBuilder<List<ProductCategory>>(
            future: futureProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Convert the data to a list of product categories
                List<ProductCategory> productCategories =
                    snapshot.data as List<ProductCategory>;
                return Column(
                  children: [
                    NavDrawerHeader(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: productCategories.length,
                        itemBuilder: (BuildContext context, int index) {
                          // On first loading, if categories exist, save
                          // the first in the list and display the
                          // first one as the home page
                          return SizedBox(
                            height: 50,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  menuItemId = snapshot.data![index].id!;
                                  Modular.to.pushNamed(
                                      '${Routes.productsByCategory}/$menuItemId');
                                  Navigator.pop(context);
                                });
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: Text(
                                    snapshot.data![index].categoryName,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
        body: const RouterOutlet());
  }
}
