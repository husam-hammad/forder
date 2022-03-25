import 'package:flashorder/BussinessLogic/Providers/stories_client.dart';
import 'package:flashorder/DataAccess/Models/story.dart';
import 'package:flashorder/DataAccess/Repository/story_repo.dart';
import 'package:get/get.dart';

class StoriesController extends GetxController {
  late StoryRepo repo;
  List<Story> stories = [];

  @override
  void onInit() async {
    super.onInit();
    await getStories();
  }

  Future getStories() async {
    repo = StoryRepo(StoryClient());
    await repo.getall().then((data) {
      stories = data;
      // ignore: avoid_print
      print(data);
      update();
    });
  }
}
