import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ecommerce_flutter/cart/database/cart_items.dart';
part 'cart_database.g.dart';


@DriftDatabase(tables: [CartItems])
class CartDatabase extends _$CartDatabase {
// we tell the database where to store the data with this constructor
  CartDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  Stream<List<CartItem>> watchAllCartItems() => select(cartItems).watch();
  Future<List<CartItem>> getAllCartItems() => select(cartItems).get();
  Future<int> insertCartItem(CartItem cartItem) => into(cartItems).insert(cartItem);
  Future<bool> updateCartItem(CartItem cartItem) => update(cartItems).replace(cartItem);
  Future<int> deleteCartItem(CartItem cartItem) => delete(cartItems).delete(cartItem);
  Future<int> deleteAll() => deleteAll();


}
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}