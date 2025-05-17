import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/presentation/pages/sign_up/view/sign_up_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static final route = GoRoute(
    path: '/sign_up',
    name: 'sign_up',
    builder: (context, state) => const SignUpPage(),
  );

  @override
  Widget build(BuildContext context) {
    return SignUpView();
  }
}