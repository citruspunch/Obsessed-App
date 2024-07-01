import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:obsessed_app/src/features/payment_finalization/domain/repositories/email_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailService implements EmailRepository {
  final String baseUrl = 'https://api.mailgun.net/v3';
  String apiKey = dotenv.env['MAILGUN_API_KEY']!;
  String domain = dotenv.env['MAILGUN_DOMAIN']!;

  @override
  Future<void> sendEmail(String email, String subject, String body) async {
    var url = Uri.parse('$baseUrl/$domain/messages');
    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('api:$apiKey'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'from': 'Obsessed <mailgun@$domain>',
        'to': email,
        'subject': subject,
        'html': body,
        'h:Reply-To': 'no-reply@$domain',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al enviar el correo electrónico: ${response.body}');
    }
  }
}