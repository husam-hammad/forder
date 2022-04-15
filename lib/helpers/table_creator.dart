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
}
