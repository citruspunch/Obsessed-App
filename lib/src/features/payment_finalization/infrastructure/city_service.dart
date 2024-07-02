import 'dart:convert';
import 'package:obsessed_app/src/core/constants/constants.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/entities/city.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/repositories/city_repository.dart';
import 'package:http/http.dart' as http;

class CityService implements CityRepository {
  @override
  Future<List<City>> getCities(String countryName) async {
    final response = await http.get(Uri.parse(citiesApiUrl));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (!responseBody['error']) {
        List<dynamic> countries = responseBody['data'];
        // Encuentra el país por nombre
        var countryData = countries.firstWhere(
          (country) => country['country'] == countryName,
          orElse: () => null,
        );
        if (countryData != null) {
          // Extrae las ciudades del país encontrado
          List<dynamic> citiesJson = countryData['cities'];
          return citiesJson.map((cityName) => City(name: cityName)).toList();
        } else {
          throw Exception('Country not found: $countryName');
        }
      } else {
        throw Exception('Failed to load cities: ${responseBody['msg']}');
      }
    } else {
      throw Exception('Failed to load cities');
    }
  }
}