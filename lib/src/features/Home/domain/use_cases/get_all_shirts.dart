import 'package:obsessed_app/src/features/Home/domain/entities/shirt.dart';
import '../repositories/shirt_repository.dart';

class GetAllShirts {
  final ShirtRepository shirtRepository;

  GetAllShirts(this.shirtRepository);

  Future<List<Shirt>> call() {
    return shirtRepository.getAllShirts();
  }
}