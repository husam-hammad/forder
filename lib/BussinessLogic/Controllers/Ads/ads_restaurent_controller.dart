import 'package:flashorder/BussinessLogic/Providers/restaurent_client.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/DataAccess/Repository/restaurent_repo.dart';
import 'package:get/get.dart';

class AdsRestaurentController extends GetxController {
  final int id;
  var repo = RestaurentRepo(RestaurentClient());
  AdsRestaurentController(this.id);
  Restaurent? restaurent;
  @override
  void onInit() async {
    restaurent = await repo.resturentById(id);
    update();
    super.onInit();
  }
}
