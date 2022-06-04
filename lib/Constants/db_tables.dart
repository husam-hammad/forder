class DBTables {
  static const String favorites = "favorites";
  static const String orders = "orders";
  static const String ordersDetails = "orders_details";
  static const String cartGroup = "cart_group";
  static const String cartItem = "cart_item";
  static const String places = "places";
}

class FavoriteFields {
  static final List<String> values = [
    /// Add all fields
    id, mealId
  ];
  static const String id = 'id';
  static const String mealId = 'meal_id';
}

class PlacesFields {
  static final List<String> values = [
    /// Add all fields
    id, name, lat, long, adress
  ];
  static const String id = 'id';
  static const String name = 'name';
  static const String lat = 'lat';
  static const String long = 'long';
  static const String adress = 'adress';
}
/* class CartGroupFields {
  static final List<String> values = [id, restaurentId, createdAt];
  static const String id = "id";
  static const String restaurentId = "restaurent_id";
  static const String createdAt = "created_at";
} */

class CartItemFields {
  static final List<String> values = [
    id,
    mealId,
    qty,
    price,
    allPrice,
    specialOrder,
    createdAt
  ];
  static const String id = "id";
  static const String mealId = "meal_id";
  static const String restaurentId = "restaurent_id";
  static const String qty = "qty";
  static const String price = "price";
  static const String allPrice = "all_price";
  static const String specialOrder = "special_order";
  static const String createdAt = "created_at";
}
