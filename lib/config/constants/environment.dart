import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String keyTMDB = dotenv.env['API_KEY_TMDB'] ?? '';
}
