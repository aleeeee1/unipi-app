import 'package:flutter/material.dart';
import 'package:unipi_orario/ui/pages/home.dart';

class RouteGenerator {
  static const String homePageRoute = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    //ignore: unused_local_variable
    List? args = settings.arguments as List?;

    switch (settings.name) {
      case homePageRoute:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const HomePage(),
        );

      default:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const HomePage(),
        );
    }
  }
}
