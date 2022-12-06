// ignore_for_file: avoid_print

import 'package:flashorder/Constants/db_tables.dart';
import 'package:flashorder/DataAccess/Models/favorite.dart';
import 'package:flashorder/helpers/db_helper.dart';

class FavoriteClient {
  Future<Favorite> createFavorite(Favorite item) async {
    final db = await Helper.instance.database;

    final id = await db?.insert(DBTables.favorites, item.toMap());
    Favorite copy = item.copyWith(id: id);
    return copy;
  }

  Future<bool> checkExist(int mealId) async {
    final db = await Helper.instance.database;

    final maps = await db?.query(DBTables.favorites,
        columns: FavoriteFields.values,
        where: '${FavoriteFields.mealId} = ?',
        whereArgs: [mealId]);

    if (maps!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Favorite>> readAllFavorite() async {
    final db = await Helper.instance.database;

    final result = await db?.query(DBTables.favorites);
    print(result);
    return result!.map((json) => Favorite.fromMap(json)).toList();
  }

  Future<int?> deleteFavorite(int id) async {
    final db = await Helper.instance.database;
    return await db?.delete(DBTables.favorites,
        where: '${FavoriteFields.id} = ?', whereArgs: [id]);
  }

  Future<int?> deleteByMealid(int mealId) async {
    final db = await Helper.instance.database;
    return await db?.delete(DBTables.favorites,
        where: '${FavoriteFields.mealId} = ?', whereArgs: [mealId]);
  }

  Future<int?> deleteAllFavorite() async {
    final db = await Helper.instance.database;
    return await db?.delete(DBTables.favorites);
  }

  Future close() async {
    final db = await Helper.instance.database;
    db!.close();
  }
}
