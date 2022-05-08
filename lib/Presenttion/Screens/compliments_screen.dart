import 'package:flashorder/BussinessLogic/Controllers/compliments_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as ints;

class ComplimentScreen extends StatelessWidget {
  ComplimentScreen({Key? key}) : super(key: key);
  final complimentController =
      Get.put<ComplimentController>(ComplimentController());
  final ints.DateFormat formatter = ints.DateFormat('yyyy-MM-dd hh:mm');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            complimentController.showAdd();
          },
          child: const Icon(Icons.add),
          backgroundColor: AppColors.green,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "الشكاوى والاٌقتراحات ",
                    style: AppTextStyles.pinkboldHeading,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: Get.height - 200,
                width: double.infinity,
                child: GetBuilder(
                    init: complimentController,
                    builder: (_) {
                      if (complimentController.loaded &&
                          complimentController.compliments.isNotEmpty) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            complimentController.getAll();
                          },
                          child: ListView.builder(
                            itemCount: complimentController.compliments.length,
                            itemBuilder: (BuildContext context, int index) {
                              var compliment =
                                  complimentController.compliments[index];
                              return Dismissible(
                                onDismissed: ((direction) {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    complimentController.delete(compliment.id);
                                  }
                                }),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "حذف",
                                          style:
                                              AppTextStyles.whiteRegularDetail,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                key: Key(compliment.id.toString()),
                                child: Container(
                                  width: double.infinity,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      borderRadius: CustomStyles.raduis100,
                                      color: AppColors.lightwhite),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "شكوى رقم : " +
                                            compliment.id.toString(),
                                        style: AppTextStyles.greyregular,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        compliment.description,
                                        style: AppTextStyles.greyregular,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      (compliment.reply != null &&
                                              compliment.reply != "")
                                          ? RichText(
                                              text: TextSpan(children: [
                                              const TextSpan(
                                                  text: "الدعم الفني : ",
                                                  style: AppTextStyles
                                                      .greenboldHeading),
                                              TextSpan(
                                                  text: complimentController
                                                      .compliments[index]
                                                      .reply!,
                                                  style: AppTextStyles
                                                      .greyregular),
                                              const TextSpan(
                                                  text: "\nتم الرد بتاريخ : ",
                                                  style: AppTextStyles
                                                      .greenboldHeading),
                                              TextSpan(
                                                  text: formatter.format(
                                                      compliment.repliedAt!),
                                                  style:
                                                      AppTextStyles.greyregular)
                                            ]))
                                          : const Text(
                                              "الحالة : لم يتم الرد",
                                              textAlign: TextAlign.right,
                                              style:
                                                  AppTextStyles.pinkboldHeading,
                                            )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (complimentController.loaded &&
                          complimentController.compliments.isEmpty) {
                        return const Center(child: Text("لا توجد شكاوى"));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
