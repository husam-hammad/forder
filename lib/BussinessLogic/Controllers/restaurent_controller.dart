import 'package:flashorder/BussinessLogic/Providers/restaurent_client.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/DataAccess/Repository/restaurent_repo.dart';
import 'package:get/get.dart';

class RestaurentController extends GetxController {
  late RestaurentRepo repo;
  List<Restaurent> restaurents = [];
  bool homeRestaurentsLoaded = false;
  @override
  void onInit() async {
    super.onInit();
    await getResturents();
  }

  Future getResturents() async {
    repo = RestaurentRepo(RestaurentClient());
    await repo.getall().then((data) {
      restaurents = data;
      homeRestaurentsLoaded = true;
      update();
    });
  }
}
