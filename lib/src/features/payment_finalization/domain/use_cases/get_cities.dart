import 'package:obsessed_app/src/features/payment_finalization/domain/entities/city.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/repositories/city_repository.dart';

class GetCities {
  final CityRepository repository;
  final String countryName;

  GetCities(this.repository, this.countryName);

  Future<List<City>> call() async {
    return await repository.getCities(countryName);
  }
}