// ignore_for_file: avoid_print

import 'package:flashorder/Constants/db_tables.dart';

import 'package:flashorder/DataAccess/Models/cart_item.dart';
import 'package:flashorder/helpers/db_helper.dart';

class CartClient {
/*   Future<CartGroup> createCartGroup(CartGroup item) async {
    final db = await Helper.instance.database;

    final id = await db?.insert(DBTables.cartGroup, item.toMap());
    //print(id);
    CartGroup copy = item.copyWith(id: id);
     print(copy); 
    return copy;
  } */
  Future<CartItem> createCartItem(CartItem item) async {
    final db = await Helper.instance.database;

    final id = await db?.insert(DBTables.cartItem, item.toDbMap());
    //print(id);
    CartItem copy = item.copyWith(id: id);
    print(copy);
    return copy;
  }

  Future<int?> editCartItem(int oldId, int qty) async {
    final db = await Helper.instance.database;
    Map<String, dynamic> row = {'qty': qty};
    final id = await db
        ?.update(DBTables.cartItem, row, where: 'id=?', whereArgs: [oldId]);
    //print(id);

    return id;
  }
  /* Future<List<CartGroup>> readAllGroups() async {
    final db = await Helper.instance.database;

    final result = await db?.query(DBTables.cartGroup);
    return result!.map((json) => CartGroup.fromMap(json)).toList();
  } */

  Future<List<CartItem>> readAllItems() async {
    final db = await Helper.instance.database;

    final result = await db?.query(DBTables.cartItem);
    return result!.map((json) => CartItem.fromMap(json)).toList();
  }

  /* Future<int?> deleteGroup(int id) async {
    final db = await Helper.instance.database;
    return await db?.delete(DBTables.cartGroup,
        where: '${CartGroupFields.id} = ?', whereArgs: [id]);
  } */
  Future<int?> deleteItem(int id) async {
    final db = await Helper.instance.database;
    return await db?.delete(DBTables.cartItem,
        where: '${CartItemFields.id} = ?', whereArgs: [id]);
  }

  Future<int?> deleteAll() async {
    final db = await Helper.instance.database;
    return await db?.delete(DBTables.cartItem);
  }

  Future close() async {
    final db = await Helper.instance.database;
    db!.close();
  }
}
