// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Providers/cart_client.dart';
import 'package:flashorder/DataAccess/Models/cart_item.dart';

class CartItemRepo {
  final CartClient cartClient = CartClient();

  Future<List<CartItem>> readAll() async {
    print("Carts Readed");
    return await cartClient.readAllItems();
  }

  Future deleteAll() async {
    return await cartClient.deleteAll();
  }

  Future deleteItem(int cartId) async {
    return await cartClient.deleteItem(cartId);
  }

  Future<CartItem> create(CartItem cartItem) async {
    return await cartClient.createCartItem(cartItem);
  }

  Future<int?> update(int id, int qty) async {
    return await cartClient.editCartItem(id, qty);
  }
}
