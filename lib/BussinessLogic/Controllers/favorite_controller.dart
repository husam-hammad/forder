// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Providers/favorite_client.dart';
import 'package:flashorder/DataAccess/Models/favorite.dart';
import 'package:flashorder/DataAccess/Repository/favorite_repo.dart';

import 'package:get/get.dart';

class FavoriteController extends GetxController {
  late FavoriteRepo repo;
  List<Favorite> favorites = [];

  @override
  void onInit() async {
    super.onInit();
    await getAll();
  }

  Future<void> getAll() async {
    repo = FavoriteRepo(FavoriteClient());
    favorites = await repo.readAll();
    update();
  }
}
