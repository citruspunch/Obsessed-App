import 'package:obsessed_app/src/features/payment_finalization/domain/repositories/email_repository.dart';

class EmailService implements EmailRepository {
  @override
  Future<void> sendEmail(String email, String subject, String body) async {
    // Implementación para enviar el correo usando un servicio externo
  }
}