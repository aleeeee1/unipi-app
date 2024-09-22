import 'package:flutter/material.dart';
import 'package:unipi_orario/ui/pages/home.dart';
import 'package:unipi_orario/ui/pages/info.dart';

class RouteGenerator {
  static const String homePageRoute = '/';
  static const String settingsPageRoute = '/info';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    //ignore: unused_local_variable
    List? args = settings.arguments as List?;

    switch (settings.name) {
      case homePageRoute:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const HomePage(),
        );

      case settingsPageRoute:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const InfoPage(),
        );

      default:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const HomePage(),
        );
    }
  }
}
