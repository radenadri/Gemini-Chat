import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

MarkdownStyleSheet markdownStyle(BuildContext context) => MarkdownStyleSheet(
      p: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.white,
          ),
      h1: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Colors.white,
          ),
      h2: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.white,
          ),
      h3: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Colors.white,
          ),
      h4: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.white,
          ),
      h5: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.white,
          ),
      h6: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Colors.white,
          ),
      listBulletPadding: EdgeInsets.zero,
      listBullet: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.white,
          ),
      blockSpacing: 10.0,
    );
