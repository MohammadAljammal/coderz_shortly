import 'package:flutter/material.dart';
import 'package:shortly/screens/onboarding_page/onboarding_page.dart';
import 'package:shortly/screens/welcome_page/welcome_page.dart';

import '../screens/home_page/home_page.dart';
import 'constants.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case welcome:
        return MaterialPageRoute(
          builder: (_) {
            return const WelcomePage();
          },
        );
      case onboarding:
        return MaterialPageRoute(
          builder: (_) {
            return const OnboardingPage();
          },
        );
      case home:
        return MaterialPageRoute(builder: (_) {
          return const HomePage();
        });
    }
    return null;
  }
}