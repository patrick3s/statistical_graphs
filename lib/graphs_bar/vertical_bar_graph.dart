import 'package:flutter/material.dart';

class VerticalBarGraph extends StatelessWidget {
  final double padding;
  final List<PointY> labelsY;
  final List<PointX> labelsX;
  final List<LineBar> bars;
  final Widget? Function(PointY, Size, int)? onLabelYChild;
  final Widget? Function(PointX, Size, int)? onLabelXChild;
  final Widget? Function(LineBar, Size, int)? onBarChild;
  const VerticalBarGraph(
      {super.key,
      this.onBarChild,
      this.onLabelYChild,
      this.padding = 40,
      this.onLabelXChild,
      required this.labelsX,
      required this.labelsY,
      required this.bars})
      : assert(padding >= 40),
        assert(padding <= 80),
        assert(labelsX.length >= 1),
        assert(labelsY.length >= 1),
        assert(bars.length >= 1),
        assert(labelsY.length <= 8),
        assert(labelsX.length <= 8),
        assert(bars.length <= 8);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (labelsY.length * padding) + padding,
      width: double.infinity,
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: MyPainter(
              padding: padding,
              countLineHorizontal: labelsY.length,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                        width: padding,
                        child: Column(
                          children: labelsY.reversed.toList().map((e) {
                            final child = onLabelYChild?.call(
                                e, Size(padding, padding), labelsY.indexOf(e));
                            return Container(
                                alignment: Alignment.bottomCenter,
                                width: padding,
                                height: padding,
                                child:
                                    child ?? Text(e.label ?? e.y.toString()));
                          }).toList(),
                        )),
                    Expanded(
                        child: SizedBox(
                      height: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: bars.map((e) {
                          final child = onBarChild?.call(
                            e,
                            Size(padding, e.pointY * padding),
                            bars.indexOf(e),
                          );
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: SizedBox(
                                width: padding,
                                height: e.pointY * padding,
                                child: child ??
                                    Container(
                                      color: Colors.red,
                                    )),
                          );
                        }).toList(),
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                  height: padding,
                  child: Row(children: [
                    SizedBox(width: padding, child: Column()),
                    Expanded(
                        child: SizedBox(
                      height: padding,
                      child: Row(
                        children: labelsX.map((e) {
                          final child = onLabelXChild?.call(
                              e, Size(padding, padding), labelsX.indexOf(e));
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Container(
                              alignment: Alignment.center,
                              width: padding,
                              height: padding,
                              child: child ?? Text(e.label ?? e.x.toString()),
                            ),
                          );
                        }).toList(),
                      ),
                    ))
                  ]))
            ],
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double padding;
  final int countLineHorizontal;
  const MyPainter(
      {Key? key, required this.padding, required this.countLineHorizontal});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(padding, size.height - padding), Offset(padding, 0),
        Paint()..color = Colors.red);
    canvas.drawLine(Offset(padding, size.height - padding),
        Offset(size.width, size.height - padding), Paint()..color = Colors.red);
    for (int i = 1; i < countLineHorizontal + 1; i++) {
      if (i == 1) continue;
      final y = padding * i;
      canvas.drawLine(Offset(padding, size.height - y),
          Offset(size.width, size.height - y), Paint()..color = Colors.black);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PointY {
  final double y;
  final String? label;
  PointY({
    required this.y,
    this.label,
  });

  PointY copyWith({
    double? y,
    String? label,
  }) {
    return PointY(
      y: y ?? this.y,
      label: label ?? this.label,
    );
  }

  @override
  String toString() => 'PointY(y: $y, label: $label)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PointY && other.y == y && other.label == label;
  }

  @override
  int get hashCode => y.hashCode ^ label.hashCode;
}

class PointX {
  final double x;
  final String? label;
  PointX({
    required this.x,
    this.label,
  });

  PointX copyWith({
    double? x,
    String? label,
  }) {
    return PointX(
      x: x ?? this.x,
      label: label ?? this.label,
    );
  }

  @override
  String toString() => 'PointX(x: $x, label: $label)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PointX && other.x == x && other.label == label;
  }

  @override
  int get hashCode => x.hashCode ^ label.hashCode;
}

class LineBar {
  final double pointY;
  final String? label;
  LineBar({
    required this.pointY,
    this.label,
  });

  LineBar copyWith({
    double? pointY,
    String? label,
  }) {
    return LineBar(
      pointY: pointY ?? this.pointY,
      label: label ?? this.label,
    );
  }

  @override
  String toString() => 'LineBar(pointY: $pointY, label: $label)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LineBar && other.pointY == pointY && other.label == label;
  }

  @override
  int get hashCode => pointY.hashCode ^ label.hashCode;
}
