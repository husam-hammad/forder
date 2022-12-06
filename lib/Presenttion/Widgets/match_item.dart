import 'package:flashorder/DataAccess/Models/match.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../Constants/colors.dart';
import '../../Constants/custom_styles.dart';
import '../../Constants/textstyles.dart';
import 'team_flag.dart';

class MatchItem extends StatelessWidget {
  const MatchItem({Key? key, required this.match}) : super(key: key);

  final Match match;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: AppColors.green2, borderRadius: CustomStyles.raduis50),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: teamFlag(match.team1.flag, match.team1.name)),
              Expanded(
                child: Column(
                  children: [
                    if (match.live == 1)
                      Text(
                        match.result,
                        style: AppTextStyles.whiteboldHeading
                            .apply(fontSizeFactor: 1.5),
                      ),
                    if (match.live == 0)
                      const Text("توقيت المباراة",
                          style: AppTextStyles.whiteboldHeading),
                    if (match.live == 0)
                      Text(
                        match.time,
                        style: match.live == 0
                            ? AppTextStyles.whiteboldHeading
                            : AppTextStyles.whiteRegularDetail,
                      ),
                    if (match.live == 1)
                      const Text(
                        "جارية الآن",
                        style: AppTextStyles.whiteRegularDetail,
                      ),
                  ],
                ),
              ),
              Expanded(child: teamFlag(match.team2.flag, match.team2.name)),
            ],
          ),
          if (match.link != "" || match.compLink != "") const Divider(),
          if (match.compLink != "")
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  style: CustomStyles.secondaryButtonStyle,
                  onPressed: () {
                    launchUrlString(match.compLink,
                        webViewConfiguration:
                            const WebViewConfiguration(enableJavaScript: true));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.tv_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "رابط التوقعات",
                        style: AppTextStyles.whiteRegularDetail,
                      )
                    ],
                  )),
            ),
        ],
      ),
    );
  }
}
