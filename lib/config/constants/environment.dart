import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String urlServer = dotenv.env['API_KEY_TMDB'] ?? '';
}
