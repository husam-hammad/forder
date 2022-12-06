import 'dart:convert';
import 'dart:math';

// ignore_for_file: avoid_print
import 'package:http/http.dart' as http;

import '../../Constants/links.dart';

class SMSCleint {
  var client = http.Client();
  Random random = Random();

  Future<dynamic> sendMessage(phone) async {
    try {
      var otpnumber = random.nextInt(100000);
      while (otpnumber < 10000) {
        otpnumber *= 10;
      }
      var otp = otpnumber.toString();
      /*    print(otp);
    return otp; */
      var message = "إن رمز تأكيد حساب فلاش أوردر هو : " + otp;
      print(message);

      var url = Uri.parse(baseUrl + sendOtpTo);
      print(url);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "auth": "AdmIn",
          "message": message,
          "recipient": phone,
        }),
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
/*       print(response.body);
      // print(otp); */
        return otp;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
