import '../Constants/db_tables.dart';
import '../Constants/fielde_types.dart';
import 'package:sqflite/sqflite.dart';

class TableCreator {
  static Future<void> createFavoriteTable(Database db) async {
    await db.execute('''
     CREATE TABLE ${DBTables.favorites} (
       ${FavoriteFields.id} ${FieldsTypes.id},
       ${FavoriteFields.mealId} ${FieldsTypes.int}
     )
     ''');
  }

/*   static Future<void> createCartGroupTable(Database db) async {
    await db.execute('''
     CREATE TABLE ${DBTables.cartGroup} (
       ${CartGroupFields.id} ${FieldsTypes.id},
       ${CartGroupFields.restaurentId} ${FieldsTypes.int},
     )
     ''');
  } */

  static Future<void> createCartItemTable(Database db) async {
    await db.execute('''
     CREATE TABLE ${DBTables.cartItem} (
       ${CartItemFields.id} ${FieldsTypes.id},
       ${CartItemFields.mealId} ${FieldsTypes.int},
              ${CartItemFields.restaurentId} ${FieldsTypes.int},
       ${CartItemFields.qty} ${FieldsTypes.int},
       ${CartItemFields.price} ${FieldsTypes.num},
       ${CartItemFields.allPrice} ${FieldsTypes.num},
       ${CartItemFields.specialOrder} ${FieldsTypes.text}
     )
     ''');
  }

  static Future<void> createPlacesTable(Database db) async {
    await db.execute('''
     CREATE TABLE ${DBTables.places} (
       ${PlacesFields.id} ${FieldsTypes.id},
       ${PlacesFields.name} ${FieldsTypes.text},
       ${PlacesFields.lat} ${FieldsTypes.num},
       ${PlacesFields.long} ${FieldsTypes.num}

     )
     ''');
  }

  static Future<void> updatePlacesTable(Database db) async {
    await db.execute(
        "ALTER TABLE ${DBTables.places} ADD ${PlacesFields.adress}  ${FieldsTypes.text};");
  }
}
