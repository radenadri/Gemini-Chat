// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:flutter_dotenv/flutter_dotenv.dart';

String GEMINI_AI_TOKEN = dotenv.env['GEMINI_AI_TOKEN'] ?? '';
