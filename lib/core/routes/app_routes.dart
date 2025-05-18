import 'package:go_router/go_router.dart';
import '../../presentation/pages/home/view/home_page.dart';
import '../../presentation/pages/note_details/view/note_details_page.dart';
import '../../presentation/pages/note_entry/view/note_entry_page.dart';
import '../../presentation/pages/sign_in/view/sign_in_page.dart';
import '../../presentation/pages/sign_up/view/sign_up_page.dart';
import '../../presentation/pages/splash_sceen/view/splash_sreen_page.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: <RouteBase>[
      SplashPage.route,
      SignInPage.route,
      SignUpPage.route,
      HomePage.route,
      NoteEntryPage.route,
      NoteDetailsPage.route,
    ],
  );
}
