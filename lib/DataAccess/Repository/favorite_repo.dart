// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Providers/favorite_client.dart';
import 'package:flashorder/DataAccess/Models/favorite.dart';

class FavoriteRepo {
  final FavoriteClient client;

  FavoriteRepo(this.client);

  Future<List<Favorite>> readAll() async {
    return await client.readAllFavorite();
  }

  Future deleteAll() async {
    await client.deleteAllFavorite();
  }

  Future<void> deleteByMeal(int mealId) async {
    await client.deleteByMealid(mealId);
  }

  Future<bool> create(Favorite favorite) async {
    if (await client.checkExist(favorite.meal_id) == false) {
      try {
        await client.createFavorite(favorite);

        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }
}
