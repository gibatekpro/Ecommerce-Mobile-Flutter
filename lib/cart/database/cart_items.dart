import 'package:drift/drift.dart';

class CartItems extends Table{

  IntColumn get id => integer()();
  TextColumn get name => text().withLength(min: 1)();
  IntColumn get quantity => integer()();
  TextColumn get imageUrl => text().named('image_url').withLength(min: 1)();
  RealColumn get unitPrice => real().named('unit_price')();
  IntColumn get unitsInStock => integer().named('units_inStock')();

  @override
  Set<Column> get primaryKey => {id};


}
