import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../controller/auth_controller.dart';

class SignInView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.amber,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 32),

                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator:
                      (val) =>
                          val != null && val.contains('@')
                              ? null
                              : 'Enter a valid email',
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator:
                      (val) =>
                          val != null && val.length >= 6
                              ? null
                              : 'Password must be at least 6 characters',
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final success = await authController.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                      if (context.mounted) {
                        if (success) {
                          context.pushReplacementNamed('home');
                        } else {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login failed. Please try again.'),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text('Login', style: TextStyle(fontSize: 18)),
                ),

                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    // Fixed typo in "Powered by"
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.amber,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                context.goNamed('sign_up');
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
