import 'dart:convert';
import 'package:obsessed_app/src/core/constants/constants.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/entities/country.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/repositories/countries_repository.dart';
import 'package:http/http.dart' as http;

class CountriesService implements CountriesRepository {
  @override
  Future<List<Country>> getCountries() async {
    final response = await http.get(Uri.parse(countriesApiUrl));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (!responseBody['error']) {
        List<dynamic> countriesJson = responseBody['data'];
        return countriesJson.map((json) => Country.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load countries: ${responseBody['msg']}');
      }
    } else {
      throw Exception('Failed to load countries');
    }
  }
}