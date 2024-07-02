import 'package:obsessed_app/src/features/payment_finalization/domain/entities/city.dart';

abstract class CityRepository {
  Future<List<City>> getCities(String countryCode);
}