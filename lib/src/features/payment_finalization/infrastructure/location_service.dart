import 'package:obsessed_app/src/features/payment_finalization/domain/entities/city.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/entities/country.dart';
import 'package:obsessed_app/src/features/payment_finalization/infrastructure/city_service.dart';
import 'package:obsessed_app/src/features/payment_finalization/infrastructure/countries_service.dart';

class LocationService {
  final CountriesService _countriesService = CountriesService();
  final CityService _cityService = CityService();

  Future<List<Country>> getCountries() async {
    try {
      return await _countriesService.getCountries();
    } catch (e) {
      return [];
    }
  }

  Future<List<City>> getCities(String countryName) async {
    try {
      return await _cityService.getCities(countryName);
    } catch (e) {
      return [];
    }
  }
}