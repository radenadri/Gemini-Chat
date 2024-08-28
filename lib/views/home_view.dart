import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_chat/models/message_model.dart';
import 'package:gemini_chat/riverpod/message_provider.dart';
import 'package:gemini_chat/utils/markdown_style_sheet.dart';
import 'package:gemini_chat/views/widgets/message_bubble.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool loading = false;
  File? imageFile;

  final ImagePicker picker = ImagePicker();
  final gemini = Gemini.instance;

  final TextEditingController _textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  late List<Message> messageWidgetLists;

  @override
  void initState() {
    super.initState();

    messageWidgetLists = ref.read(messageLists);
  }

  @override
  void dispose() {
    _textController.dispose();
    _controller.dispose();

    super.dispose();
  }

  void scrollToTheEnd() =>
      _controller.jumpTo(_controller.position.maxScrollExtent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Chat'),
      ),
      body: Column(
        children: [
          MessageWidgetLists(
            controller: _controller,
            messageLists: messageWidgetLists,
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Write a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.transparent,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: () async {
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);

                    setState(() {
                      imageFile = image != null ? File(image.path) : null;
                    });
                  },
                ),
                IconButton(
                  icon: loading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.send),
                  onPressed: () async {
                    if (_textController.text.isEmpty) {
                      // show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a message'),
                          behavior: SnackBarBehavior.floating,
                          showCloseIcon: true,
                        ),
                      );

                      return;
                    }

                    await handleSubmitPrompt(context);

                    setState(() {
                      loading = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) {
          if (imageFile != null) {
            return Container(
              margin: const EdgeInsets.only(bottom: 80),
              height: 150,
              child: Image.file(imageFile ?? File('')),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> handleSubmitPrompt(BuildContext context) async {
    if (imageFile != null) {
      messageWidgetLists.add(
        Message(
          owner: 'Me',
          text: '',
          imageUrl: imageFile!.path,
        ),
      );
    }

    String textForGemini = _textController.text;
    File? imageForGemini = imageFile;

    _textController.clear();
    imageFile = null;

    messageWidgetLists.add(
      Message(
        owner: 'Me',
        text: textForGemini,
      ),
    );

    setState(() {
      loading = true;
    });

    var message = imageForGemini != null
        ? await submitTextAndImagePrompt(textForGemini, imageForGemini)
        : await submitTextPrompt(textForGemini);

    messageWidgetLists.add(message);

    scrollToTheEnd();

    setState(() {
      loading = false;
    });
  }
}

class MessageWidgetLists extends StatelessWidget {
  const MessageWidgetLists({
    super.key,
    required ScrollController controller,
    required this.messageLists,
  }) : _controller = controller;

  final ScrollController _controller;
  final List messageLists;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _controller,
        itemCount: messageLists.length,
        padding: const EdgeInsets.only(bottom: 20),
        itemBuilder: (context, index) {
          final message = messageLists[index];

          return MessageBubble(
            message: message,
            child: message.imageUrl != null
                ? Image.file(File(message.imageUrl!))
                : MarkdownBody(
                    data: message.text,
                    styleSheet: markdownStyle(context),
                  ),
          );
        },
      ),
    );
  }
}
