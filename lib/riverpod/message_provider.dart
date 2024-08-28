import 'dart:io';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_chat/models/message_model.dart';

final gemini = Gemini.instance;

var messageLists = StateProvider<List<Message>>((ref) => []);

Future<Message> submitTextPrompt(String text) async {
  var response = await gemini.text(text);

  if (response?.content?.parts?.last.text != null) {
    return Message(
      owner: 'Gemini',
      text: response?.content?.parts?.last.text ??
          'Something went wrong, please try again later',
    );
  }

  return const Message(
    owner: 'Gemini',
    text: 'Something went wrong, please try again later',
  );
}

Future<Message> submitTextAndImagePrompt(String text, File image) async {
  var response = await gemini.textAndImage(
    text: text,
    images: [image.readAsBytesSync()],
  );

  if (response?.content?.parts?.last.text != null) {
    return Message(
      owner: 'Gemini',
      text: response?.content?.parts?.last.text ??
          'Something went wrong, please try again later',
    );
  }

  return const Message(
    owner: 'Gemini',
    text: 'Something went wrong, please try again later',
  );
}
