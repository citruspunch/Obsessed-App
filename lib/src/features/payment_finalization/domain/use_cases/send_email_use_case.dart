import 'package:obsessed_app/src/features/payment_finalization/domain/repositories/email_repository.dart';

class SendEmailUseCase {
  final EmailRepository emailRepository;

  SendEmailUseCase(this.emailRepository);

  Future<void> sendEmail(String email, String subject, String body) async {
    await emailRepository.sendEmail(email, subject, body);
  }
}