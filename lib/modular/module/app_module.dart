import 'package:ecommerce_flutter/cart/view/cart_view.dart';
import 'package:ecommerce_flutter/checkout/view/checkout_view.dart';
import 'package:ecommerce_flutter/util/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../Product/widget/product_details_view.dart';
import 'home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute,
            module: HomeModule()),
        // For Product Details
        ChildRoute(Routes.productDetails,
            transition: TransitionType.leftToRight,
            child: (context, args) =>
                ProductDetailsView(product: args.data)),

        // For Cart View
        ChildRoute(Routes.cart,
            transition: TransitionType.leftToRight,
            child: (context, args) =>
                const CartView()),
        // For Cart View
        ChildRoute(Routes.checkout,
            transition: TransitionType.leftToRight,
            child: (context, args) =>
                const CheckOutView()),
      ];
}
