import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool done = false;

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        setState(() {
          done = true;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informazioni'),
      ),
      body: AnimatedAlign(
        alignment: done ? Alignment.topCenter : Alignment.center,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInQuad,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "UniPi Orario",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(width: 4),
            const Hero(
              tag: 'infoIcon',
              child: Icon(
                Icons.copyright,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
