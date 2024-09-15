import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipi_orario/services/internal_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InternalAPI internalAPI = Get.find<InternalAPI>();

  PreferredSizeWidget appBar() {
    return AppBar(
      actions: [
        ThemeSwitcher(
          builder: (ctx) => InkWell(
            child: IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(anim);

                  final bounceAnimation = Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(anim);

                  final fadeAnimation = Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(anim);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: ScaleTransition(
                      scale: bounceAnimation,
                      child: FadeTransition(
                        opacity: fadeAnimation,
                        child: child,
                      ),
                    ),
                  );
                },
                child: !internalAPI.isDarkMode
                    ? const Icon(
                        Icons.dark_mode,
                        key: ValueKey('dark'), // <-- senza key nva
                      )
                    : const Icon(
                        Icons.light_mode,
                        key: ValueKey('light'),
                      ),
              ),
              onPressed: () {
                internalAPI.setDarkMode(!internalAPI.isDarkMode, ctx);
              },
            ),
            onLongPress: () {
              internalAPI.setDynamicMode(!internalAPI.isDynamicTheme, ctx);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: appBar(),
      ),
    );
  }
}
