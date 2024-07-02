import 'package:obsessed_app/src/features/payment_finalization/domain/entities/country.dart';

abstract class CountriesRepository {
  Future<List<Country>> getCountries();
}