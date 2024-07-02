import 'package:obsessed_app/src/features/payment_finalization/domain/entities/country.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/repositories/countries_repository.dart';

class GetCountries {
  final CountriesRepository repository;

  GetCountries(this.repository);

  Future<List<Country>> call() async {
    return await repository.getCountries();
  }
}