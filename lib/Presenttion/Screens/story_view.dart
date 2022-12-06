// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, avoid_print

import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/stories_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';

import 'package:flashorder/DataAccess/Models/story.dart';
import 'package:flashorder/Presenttion/Screens/restaurent_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:story_view/story_view.dart';

import 'box_screen.dart';
import 'meal_screen.dart';

class StoryViewScreen extends StatelessWidget {
  final StoryController controller = StoryController();
  final StoriesController storyController = Get.find();
  final MealsController mealsController = Get.find();
  StoryViewScreen({Key? key, required this.goto}) : super(key: key);
  final int goto;

  @override
  Widget build(BuildContext context) {
    /* if (goto != 0) {

      controller.playbackNotifier.add(PlaybackState.next);
    } */
    bool firststoryshown = false;
    int currentindex = 0;
    Story? currentkey;
    List<StoryItem?> list = [];
    return Directionality(
      textDirection: Get.locale!.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.pink,
          title: Text(
            "lateststories".tr,
            style: AppTextStyles.whiteRegularHeading,
          ),
          centerTitle: true,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Container(
                  height: Get.height,
                  child: Directionality(
                    textDirection: Get.locale!.languageCode == 'en'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        StoryView(
                          controller: controller,
                          storyItems: buildStories(list),
                          onStoryShow: (s) {
                            currentindex = list.indexOf(s);
                            currentkey = storyController.stories[currentindex];

                            if (goto != 0 && goto != 10000) {
                              int gotovalue = goto;
                              while (gotovalue > 0 && !firststoryshown) {
                                gotovalue--;
                                controller.next();
                              }
                              firststoryshown = true;
                            }
                          },
                          onComplete: () {
                            Get.back();
                          },
                          onVerticalSwipeComplete: (e) {
                            if (e!.index == 0) {
                              if (currentkey != null) {
                                if (currentkey!.box != null) {
                                  print(currentkey!.box!.title);
                                  Get.to(() => BoxScreen(
                                        box: currentkey!.box!,
                                      ));
                                } else if (currentkey!.meal != null) {
                                  Get.to(() => MealScreen(),
                                      arguments: [currentkey!.meal]);
                                } else {
                                  if (currentkey!.restaurent != null) {
                                    Get.to(() => RestaurentScreen(
                                        restaurent: currentkey!.restaurent!));
                                  }
                                }
                              }
                            }
                          },
                          progressPosition: ProgressPosition.top,
                          repeat: false,
                          inline: true,
                        ),
                        Positioned(
                          bottom: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: LottieBuilder.asset(
                              'assets/images/swipertop.json',
                              width: 100,
                              repeat: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /*  Expanded(
                flex: 1,
                child: Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MoreStories()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(8))),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "morestories".tr,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
             */
            ],
          ),
        ),
      ),
    );
  }

  List<StoryItem?> buildStories(list) {
/*     storyController.stories[0] = storyController.stories[goto]; */

    for (var story in storyController.stories) {
      list.add(StoryItem.inlineImage(
        imageFit: BoxFit.contain,
        duration: Duration(seconds: 5),
        url: story.image,
        controller: controller,
        key: ValueKey<Story?>(story),
        caption: Text(
          story.description,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              /* backgroundColor: Colors.black54, */
              wordSpacing: 0,
              letterSpacing: 0,
              fontSize: 17,
              fontFamily: "Cairo"),
        ),
      ));
    }

    return list;
  }
}

class MoreStories extends StatefulWidget {
  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("morestories".tr),
      ),
      body: StoryView(
        storyItems: const [
          /* StoryItem.text(
            title: "I guess you'd love to see more of our food. That's great.",
            backgroundColor: Colors.blue,
          ),
          StoryItem.text(
            title: "Nice!\n\nTap to continue.",
            backgroundColor: Colors.red,
            textStyle: TextStyle(
              fontFamily: 'Dancing',
              fontSize: 40,
            ),
          ),
          StoryItem.pageImage(
            url:
                "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
            caption: "Still sampling",
            controller: storyController,
          ),
          StoryItem.pageImage(
              url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
              caption: "Working with gifs",
              controller: storyController),
          StoryItem.pageImage(
            url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
            caption: "Hello, from the other side",
            controller: storyController,
          ),
          StoryItem.pageImage(
            url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
            caption: "Hello, from the other side2",
            controller: storyController,
          ), */
        ],
        onStoryShow: (s) {},
        onComplete: () {
          Get.back();
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}
