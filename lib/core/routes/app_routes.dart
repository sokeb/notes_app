import 'package:go_router/go_router.dart';
import '../../modules/sign_in/view/sign_in_page.dart';
import '../../modules/splash_sceen/view/splash_sreen_page.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: <RouteBase>[
      SplashPage.route,
      SignInPage.route,
    ],
  );
}