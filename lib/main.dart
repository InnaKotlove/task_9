import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Identity verification',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(body: const MyHomePage(title: 'Identity verification')),
    );
  }
}

class HeroStateWidget extends InheritedWidget {
  final bool superheroState;

  HeroStateWidget({required this.superheroState, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant HeroStateWidget oldWidget) =>
      oldWidget.superheroState != superheroState;

  static bool? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<HeroStateWidget>()!
      .superheroState;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => HeroState();
}

class HeroState extends State<MyHomePage> {
  bool _state = false;

  get mainAxisAlignment => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Switch(
              value: _state,
              onChanged: (value) {
                setState(() {
                  _state = value;
                });
              },
            ),
            HeroStateWidget(superheroState: _state, child: const HeroCard())

            // This trailing comma makes auto-formatting nicer for build methods.
          ],
        ));
  }
}

class HeroCard extends StatelessWidget {
  const HeroCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool currentState = HeroStateWidget.of(context) ?? false;

    return Center(
        child: (Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            currentState ? 'Брюс Уейн' : 'Бетмен',
            style: TextStyle(fontSize: 30),
          )),
      const SizedBox(
        height: 30,
      ),
      Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: currentState
                ? const AssetImage("assets/images/001.jpg")
                : const AssetImage("assets/images/002.jpg"),
          ),
        ),
      ),
      Text(
        currentState
            ? 'Брюс Уейн успешный промышленник, филантроп и любимец женщин.'
            : 'Бэтмен является одним из самых популярных и известных героев комиксов.',
        style: const TextStyle(fontSize: 30),
      ),
    ])));
  }
}
