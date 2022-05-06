import 'dart:math';

class Calc {
  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static num deliveryCost(distance, perKm) {
    num d = (distance * perKm).floor();

    return Calc.nearestThousand(d);
  }

  static num nearestThousand(num number) {
    num a = number % 100;

    if (a > 0) {
      return (number ~/ 100) * 100 + 100;
    }
    return number;
  }
}
