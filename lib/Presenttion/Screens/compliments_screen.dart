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
      textDirection: Get.locale!.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            complimentController.showAdd();
          },
          child: const Icon(Icons.add),
          backgroundColor: AppColors.green,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "complaintsandsuggestions".tr,
                      style: AppTextStyles.pinkboldTopPage,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: Get.height - 250,
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
                              itemCount:
                                  complimentController.compliments.length,
                              itemBuilder: (BuildContext context, int index) {
                                var compliment =
                                    complimentController.compliments[index];
                                return Dismissible(
                                  onDismissed: ((direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      complimentController
                                          .delete(compliment.id);
                                    }
                                  }),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "delete".tr,
                                            style: AppTextStyles
                                                .whiteRegularDetail,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  key: Key(compliment.id.toString()),
                                  child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        borderRadius: CustomStyles.raduis100,
                                        color: AppColors.lightwhite),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "complaintid".tr +
                                              compliment.id.toString(),
                                          style: AppTextStyles.greyregular
                                              .apply(fontSizeFactor: 1.8),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          compliment.description,
                                          style: AppTextStyles.greyregular
                                              .apply(fontSizeFactor: 1.8),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        (compliment.reply != null &&
                                                compliment.reply != "")
                                            ? RichText(
                                                strutStyle: const StrutStyle(
                                                    fontFamily: "Cairo"),
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "support".tr + " ",
                                                      style: AppTextStyles
                                                          .greenboldHeading),
                                                  TextSpan(
                                                    text: complimentController
                                                        .compliments[index]
                                                        .reply!,
                                                    style: AppTextStyles
                                                        .greyregular
                                                        .apply(
                                                            fontSizeFactor:
                                                                1.8),
                                                  ),
                                                  const TextSpan(
                                                      text:
                                                          "\nتم الرد بتاريخ : ",
                                                      style: AppTextStyles
                                                          .greenboldHeading),
                                                  TextSpan(
                                                      text: formatter.format(
                                                          compliment
                                                              .repliedAt!),
                                                      style: AppTextStyles
                                                          .greyregular)
                                                ]))
                                            : Text(
                                                "noreply".tr,
                                                textAlign: TextAlign.right,
                                                style: AppTextStyles
                                                    .pinkboldHeading,
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
                          return Center(child: Text("nocomplaint".tr));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
