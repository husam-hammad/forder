import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: buildAppBar(),
          bottomNavigationBar: const CustomBotttomNav(),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "إتصل بنا ",
                        style: AppTextStyles.pinkboldTopPage,
                      ),
                    ],
                  ),
                ),
                const Text(
                  "لأي استفسار أو شكوى مباشرة يمكنك الإتصال  على : ",
                  style: AppTextStyles.greyregular,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text(
                          "0119691",
                          style: AppTextStyles.greenboldHeading,
                        ),
                        leading: const Icon(
                          Icons.phone,
                          color: Colors.blueAccent,
                        ),
                        subtitle: const Text("رقم رباعي",
                            style: AppTextStyles.greyRegularDetail),
                        onTap: () {
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: "0119691",
                          );
                          launchUrl(launchUri);
                          /* launch("tel://214324234"); */
                        },
                      ),
                      const ListTile(
                        title: Text(""),
                        leading: Icon(
                          Icons.call,
                          color: Colors.blueAccent,
                        ),
                        subtitle: Text("رقم موبايل"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "مؤسسة فلاش أوردر : ",
                        style: AppTextStyles.pinkboldHeading,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.room),
                          Text(
                            "شارع بغداد - قبل مشفى الهلال ",
                            style: AppTextStyles.greyregular,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
