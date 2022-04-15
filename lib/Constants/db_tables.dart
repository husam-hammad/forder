class DBTables {
  static const String favorites = "favorites";
  static const String orders = "orders";
  static const String ordersDetails = "orders_details";
}

class FavoriteFields {
  static final List<String> values = [
    /// Add all fields
    id, mealId
  ];
  static const String id = 'id';
  static const String mealId = 'meal_id';
}
