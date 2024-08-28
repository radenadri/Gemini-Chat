import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_chat/config/constants.dart';
import 'package:gemini_chat/config/routes.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  Gemini.init(
    apiKey: GEMINI_AI_TOKEN,
  );

  runApp(
    ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Gemini Chat',
        theme: ThemeData(
          colorSchemeSeed: Colors.blue,
          useMaterial3: true,
        ),
      ),
    ),
  );
}
