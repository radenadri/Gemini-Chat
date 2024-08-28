import 'package:go_router/go_router.dart';
import 'package:gemini_chat/views/home_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
  ],
);
