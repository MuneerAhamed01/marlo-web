import 'package:flutter/material.dart';

class LineToArrowAnimation extends StatefulWidget {
  @override
  _LineToArrowAnimationState createState() => _LineToArrowAnimationState();
}

class _LineToArrowAnimationState extends State<LineToArrowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line to Arrow Animation'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            _controller.reverse();
            setState(() {});
          },
          child: CustomPaint(
            painter: LineToArrowPainter(progress: _animation.value),
            size: Size(200, 200),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
      }),
    ),
    home: LineToArrowAnimation(),
  ));
}

class LineToArrowPainter extends CustomPainter {
  final double progress;

  LineToArrowPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final endPoint = Offset(size.width * progress, size.height / 2);
    final controlPoint1 = Offset(size.width * progress * 0.7, size.height / 4);
    final controlPoint2 =
        Offset(size.width * progress * 0.7, size.height * 3 / 4);

    path.moveTo(0, size.height / 2);
    path.cubicTo(
      controlPoint1.dx,
      controlPoint1.dy,
      controlPoint2.dx,
      controlPoint2.dy,
      endPoint.dx,
      endPoint.dy,
    );

    final arrowPath = Path();
    final arrowLength = 12.0;
    final arrowWidth = 8.0;
    final arrowStart = Offset(endPoint.dx - arrowLength, endPoint.dy);
    final arrowEnd = Offset(endPoint.dx, endPoint.dy);
    arrowPath.moveTo(arrowStart.dx, arrowStart.dy);
    arrowPath.lineTo(arrowEnd.dx, arrowEnd.dy - arrowWidth / 2);
    arrowPath.lineTo(arrowEnd.dx, arrowEnd.dy + arrowWidth / 2);
    arrowPath.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(arrowPath, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
