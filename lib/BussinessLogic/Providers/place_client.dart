// ignore_for_file: avoid_print

import 'package:flashorder/Constants/db_tables.dart';

import 'package:flashorder/DataAccess/Models/place.dart';
import 'package:flashorder/helpers/db_helper.dart';

class PlaceClient {
  Future<Place> createPlaceItem(Place item) async {
    final db = await Helper.instance.database;

    final id = await db?.insert(DBTables.places, item.toDBMap());
    //print(id);
    Place copy = item.copyWith(id: id);
    /* print(copy); */
    return copy;
  }

  Future<int?> editPlaceItem(Place place) async {
    final db = await Helper.instance.database;

    final id = await db?.update(DBTables.places, place.toMap(),
        where: 'id=?', whereArgs: [place.id]);
    //print(id);

    return id;
  }

  Future<List<Place>> readAllItems() async {
    final db = await Helper.instance.database;

    final result = await db?.query(DBTables.places);
    return result!.map((json) => Place.fromMap(json)).toList();
  }

  Future<int?> deleteItem(int id) async {
    final db = await Helper.instance.database;
    return await db?.delete(DBTables.places,
        where: '${PlacesFields.id} = ?', whereArgs: [id]);
  }

  Future<int?> deleteAll() async {
    final db = await Helper.instance.database;
    return await db?.delete(DBTables.places);
  }

  Future close() async {
    final db = await Helper.instance.database;
    db!.close();
  }
}
