import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get/get.dart';
import 'package:unipi_orario/services/internal_api.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InternalAPI internalAPI = Get.find<InternalAPI>();

  final EasyInfiniteDateTimelineController _controller = EasyInfiniteDateTimelineController();
  DateTime currentDate = DateTime.now();

  late PageController _pageController;
  int currentPageValue = 10000;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPageValue);
  }

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

  Widget timeLine() {
    TextStyle subStyle = TextStyle(
      fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
      color: Theme.of(context).disabledColor,
      fontWeight: FontWeight.w600,
    );

    DayStyle dayStyle = DayStyle(
      monthStrStyle: subStyle,
      dayStrStyle: subStyle,
      dayNumStyle: TextStyle(
        fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.w800,
      ),
    );

    List<String> months = [
      FlutterI18n.translate(context, "months.january"),
      FlutterI18n.translate(context, "months.february"),
      FlutterI18n.translate(context, "months.march"),
      FlutterI18n.translate(context, "months.april"),
      FlutterI18n.translate(context, "months.may"),
      FlutterI18n.translate(context, "months.june"),
      FlutterI18n.translate(context, "months.july"),
      FlutterI18n.translate(context, "months.august"),
      FlutterI18n.translate(context, "months.september"),
      FlutterI18n.translate(context, "months.october"),
      FlutterI18n.translate(context, "months.november"),
      FlutterI18n.translate(context, "months.december"),
    ];

    return EasyInfiniteDateTimeLine(
      controller: _controller,
      //
      firstDate: DateTime(DateTime.september),
      lastDate: DateTime(DateTime.now().year).add(const Duration(days: 365 * 4)),
      focusDate: currentDate,
      //
      onDateChange: (selectedDate) {
        setState(() {
          currentDate = selectedDate;
          _pageController.jumpToPage(currentPageValue + currentDate.difference(DateTime.now()).inDays);
        });
      },
      activeColor: Theme.of(context).colorScheme.primaryContainer,
      locale: Localizations.localeOf(context).toLanguageTag(),
      dayProps: EasyDayProps(
        todayHighlightStyle: TodayHighlightStyle.withBackground,
        todayHighlightColor: Theme.of(context).colorScheme.tertiaryContainer,
        //
        activeDayStyle: dayStyle,
        todayStyle: dayStyle,
        inactiveDayStyle: dayStyle,
        //
        height: 80,
      ),
      headerBuilder: (context, date) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            children: [
              Text(
                "${months[currentDate.month - 1]} ${currentDate.year}",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget eventsList() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          DateTime date = DateTime.now().add(Duration(days: index - currentPageValue));

          return Center(
            child: Text(
              date.toString(),
            ),
          );
        },
      ),
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      currentDate = DateTime.now().add(Duration(days: page - currentPageValue));
      _controller.animateToDate(currentDate);
    });
  }

  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        timeLine(),
        eventsList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: appBar(),
        body: body(),
      ),
    );
  }
}
