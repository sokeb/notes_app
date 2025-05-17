import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final route = GoRoute(
    path: '/home',
    name: 'home',
    builder: (context, state) => const HomePage(),
  );

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}
