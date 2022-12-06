// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/favorite_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meal_screen_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/favorite.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/Presenttion/Widgets/loading_item.dart';
import 'package:flashorder/Presenttion/Widgets/restaurent_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../../Constants/colors.dart';
import '../Widgets/drawer.dart';

// ignore: must_be_immutable
class MealScreen extends StatelessWidget {
  MealScreen({Key? key}) : super(key: key);
  FavoriteController favoriteController = Get.find();
  Meal meal = Get.arguments[0];

  late MealScreenController mealScreenController;
  UserController userController = Get.find();
  Widget buildBottomButton() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: GetBuilder<MealScreenController>(
            init: mealScreenController,
            builder: (_) {
              return Row(children: [
                mealScreenController.canReplaceWtihPoint == true
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton(
                              style: CustomStyles.secondaryButtonStyle,
                              onPressed: () {
                                mealScreenController.addbuttonEnabled == true
                                    ? mealScreenController.addToCart(
                                        mealScreenController.pointsCount.value)
                                    : null;
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/coins.png',
                                    width: 25,
                                  ),
                                  Text(
                                      mealScreenController.pointsCount.value
                                              .toString() +
                                          " " +
                                          "point".tr,
                                      style: AppTextStyles.whiteRegularHeading)
                                ],
                              )),
                        ),
                      )
                    : Row(),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ElevatedButton(
                      style: CustomStyles.acceptButtonStyle,
                      onPressed: () {
                        mealScreenController.addbuttonEnabled == true
                            ? mealScreenController.addToCart(0)
                            : null;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (mealScreenController.addingtocart == true)
                            loadingItem(),
                          if (mealScreenController.addingtocart == false)
                            const Icon(Icons.add),
                          Text("addtocart".tr,
                              style: AppTextStyles.whiteRegularHeading)
                        ],
                      )),
                ))
              ]);
            }));
  }

  Widget buildNumbersText(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "number".tr,
            style: AppTextStyles.greenRegularHeading,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    style: CustomStyles.removeButtonStyle2,
                    onPressed: () {
                      mealScreenController.minusNumber();
                    },
                    child: const Text("-")),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    style: CustomStyles.acceptButtonStyle2,
                    onPressed: () {
                      mealScreenController.addNumber();
                    },
                    child: const Text("+")),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 4,
                child: TextField(
                  enabled: false,
                  controller: controller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,

                  /* onEditingComplete: () { mealScreenController.changeNumber();},
                  onChanged: (val) {
                   
                  }, */
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCompomentText(TextEditingController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.star,
                color: AppColors.green,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "specialorder".tr,
                style: AppTextStyles.greenRegularHeading,
              )
            ],
          ),
          TextField(
            controller: controller,
            keyboardType: TextInputType.text,
            minLines: 2,
            maxLines: null,
            decoration: InputDecoration(
                hintText: "specialorderdesc".tr,
                contentPadding: const EdgeInsets.all(20)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    mealScreenController = Get.put(MealScreenController(meal));
    return Directionality(
        textDirection: Get.locale!.languageCode == 'en'
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: GetBuilder(
            init: mealScreenController,
            builder: (_) {
              return Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  drawer: PublicDrawer(userController: userController),
                  appBar: NewGradientAppBar(
                    gradient: const LinearGradient(
                        colors: [AppColors.pink, AppColors.pink2]),
                    shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(100))),
                    elevation: 0,
                    centerTitle: true,
                    title: Column(
                      children: [
                        //Icon(Icons.flash_on),
                        const SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          "assets/images/logo-white.png",
                          width: 100,
                        )
                      ],
                    ),
                    actions: [
                      InkWell(onTap: () {
                        Get.toNamed(AppRoutes.usercarts);
                      }, child: Obx(() {
                        if (mealScreenController.animationscompleted.value !=
                            true) {
                          return Lottie.asset(
                            'assets/images/cart.json',
                            frameRate: FrameRate.max,
                            controller:
                                mealScreenController.animationController,
                            onLoaded: (composition) {
                              // Configure the AnimationController with the duration of the
                              // Lottie file and start the animation.
                              mealScreenController.animationController
                                ..duration = composition.duration
                                //;const Duration(microseconds: 200)
                                ..stop();
                            },
                          );
                        } else {
                          return Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: const Icon(
                              Icons.shopping_cart,
                              size: 30,
                              color: AppColors.green,
                            ),
                          );
                        }
                      })),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.search);
                        },
                        icon: const Icon(Icons.search),
                        color: Colors.white,
                      )
                    ],
                  ),
                  bottomNavigationBar: buildBottomButton(),
                  body: GetBuilder(
                      init: mealScreenController,
                      builder: (buildercontext) {
                        return CustomScrollView(slivers: [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: AppColors.green,
                            expandedHeight: 300,
                            flexibleSpace: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Hero(
                                    tag: "meal:${meal.id}",
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              color: AppColors.grey,
                                              image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                    meal.image,
                                                  ),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  CustomStyles.raduis100Bottom),
                                        ))),
                                Positioned(
                                    top: 10,
                                    left: 10,
                                    child: RestaurentIcon(
                                      restaurent:
                                          mealScreenController.meal.restaurent,
                                      smallicon: true,
                                    )),
                                if (mealScreenController.meal.points != 0)
                                  Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/coins.png',
                                              width: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "earnedpoints".tr +
                                                  " : " +
                                                  (meal.points *
                                                          (meal.price / 1000) *
                                                          num.parse(mealScreenController
                                                                      .numbercontroller
                                                                      .value
                                                                      .text !=
                                                                  ""
                                                              ? mealScreenController
                                                                  .numbercontroller
                                                                  .value
                                                                  .text
                                                              : "1"))
                                                      .toStringAsFixed(0),
                                              style: AppTextStyles
                                                  .whiteRegularDetail,
                                            )
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                            borderRadius:
                                                CustomStyles.raduis100,
                                            color: AppColors.pink2),
                                      )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: () {
                                        mealScreenController.toggle(
                                            Favorite(id: 0, meal_id: meal.id));
                                      },
                                      icon: Icon(
                                        mealScreenController.isfav
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                )
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                              child: Column(children: [
                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.green2,
                                        AppColors.green,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter),
                                  color: AppColors.green,
                                  borderRadius: CustomStyles.raduis100Bottom),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    meal.name,
                                    style: AppTextStyles.whiteboldHeading,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Text(
                                    "price".tr + " : ",
                                    style: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  if (meal.offerPrice != 0)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          meal.price.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .apply(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.red),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          meal.offerPrice.toString() + "  ل.س",
                                          style: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? AppTextStyles.whiteboldHeading
                                              : AppTextStyles.greyboldHeading,
                                        ),
                                      ],
                                    ),
                                  if (meal.offerPrice == 0)
                                    Text(
                                      meal.price.toString() + "  ل.س",
                                      style: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppTextStyles.whiteboldHeading
                                          : AppTextStyles.greyboldHeading,
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (mealScreenController
                                        .newmealcompomemt.isNotEmpty)
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                mealScreenController
                                                    .repartCompoment();
                                              },
                                              icon: const Icon(Icons.refresh)),
                                          Text(
                                            "compoments".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    if (mealScreenController
                                        .newmealcompomemt.isNotEmpty)
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    if (mealScreenController
                                        .newmealcompomemt.isNotEmpty)
                                      GetBuilder(
                                          init: mealScreenController,
                                          builder: (_) {
                                            return mealScreenController
                                                    .newmealcompomemt.isNotEmpty
                                                ? SizedBox(
                                                    height: 35,
                                                    width: double.infinity,
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            mealScreenController
                                                                .newmealcompomemt
                                                                .length,
                                                        itemBuilder:
                                                            (_, index) {
                                                          return Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        4),
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius:
                                                                  CustomStyles
                                                                      .raduis100,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      158,
                                                                      158,
                                                                      158),
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  mealScreenController
                                                                          .newmealcompomemt[
                                                                      index],
                                                                  style: AppTextStyles
                                                                      .whiteRegularDetail,
                                                                ),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      mealScreenController
                                                                          .deleteCompoment(
                                                                              index);
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .white,
                                                                    ))
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  )
                                                : Row();
                                          }),
                                    buildNumbersText(
                                        mealScreenController.numbercontroller),
                                    buildCompomentText(mealScreenController
                                        .compomentController),
                                  ]),
                            ),
                            const SizedBox(
                              height: 100,
                            )
                          ]))
                        ]);
                      }));
            }));
  }
}
