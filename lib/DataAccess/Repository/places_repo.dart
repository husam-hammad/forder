import 'package:flashorder/BussinessLogic/Providers/place_client.dart';

import '../Models/place.dart';

class PlacesRepo {
  final PlaceClient placeClient;

  PlacesRepo(this.placeClient);

  Future<List<Place>> getAll() async {
    return await placeClient.readAllItems();
  }

  Future<int?> delete(id) async {
    return await placeClient.deleteItem(id);
  }

  Future<Place> addPlace(Place place) async {
    Place tempplace = await placeClient.createPlaceItem(place);
    // ignore: avoid_print
    print(tempplace);
    return place;
  }
}
