import 'package:flutter/material.dart';
import 'package:statistical_graphs/graphs_bar/vertical_bar_graph.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            VerticalBarGraph(
              onBarChild: ((model, size, index) => Container(
                    height: size.height,
                    width: size.width,
                    color: Colors.black,
                  )),
              onLabelXChild: (model, size, index) => Container(
                height: size.height,
                width: size.width,
                alignment: Alignment.center,
                child: Text(model.label ?? model.x.toString()),
              ),
              onLabelYChild: (model, size, index) => Container(
                height: size.height,
                width: size.width,
                alignment: Alignment.bottomCenter,
                child: Text(model.label ?? model.y.toString()),
              ),
              bars: [
                LineBar(pointY: 0.1),
                LineBar(pointY: 1),
                LineBar(pointY: 2),
                LineBar(pointY: 3.5),
                LineBar(pointY: 4),
                LineBar(pointY: 5),
              ],
              labelsY: List.generate(6, (index) => index)
                  .map((e) => PointY(y: e + 0.0, label: e == 0 ? '0' : null))
                  .toList(),
              labelsX: List.generate(8, (index) => index)
                  .map((e) => PointX(x: e + 0.0))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
