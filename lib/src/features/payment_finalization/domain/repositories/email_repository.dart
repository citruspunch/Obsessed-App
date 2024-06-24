abstract class EmailRepository {
  Future<void> sendEmail(String email, String subject, String body);
}