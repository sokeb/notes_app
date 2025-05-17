import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/modules/sign_in/view/sign_in_view.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static final route = GoRoute(
    path: '/sign_in',
    name: 'sign_in',
    builder: (context, state) => const SignInPage(),
  );

  @override
  Widget build(BuildContext context) {
    return SignInView();
  }
}