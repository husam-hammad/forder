import 'package:flashorder/DataAccess/Models/cart_item.dart';

class CartGroup {
  int? restaurentId;
  List<CartItem> cartItems;
  CartGroup({
    required this.restaurentId,
    required this.cartItems,
  });
}
