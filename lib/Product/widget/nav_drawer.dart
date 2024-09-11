import 'package:flutter/material.dart';

import '../model/product_category.dart';

class NavDrawer extends StatefulWidget {

  late Future<List<ProductCategory>> futureProduct;

  NavDrawer({Key? key, required this.futureProduct}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<List<ProductCategory>>(
          future: widget.futureProduct,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              //Convert the data to a list of product categories
              List<ProductCategory> productCategories = snapshot.data as List<ProductCategory>;

              return ListView.builder(
                  itemCount: productCategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 75,
                      color: Colors.white,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            // menuItemId = productCategories[index].id!;
                            Navigator.pop(context);
                          });
                        },
                        child: Center(
                          child: Text(snapshot.data![index].categoryName),
                        ),
                      ),
                    );
                  });
            }else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          }
      ),
    );
  }
}
