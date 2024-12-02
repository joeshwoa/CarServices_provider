// @dart=2.12
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// This is the stateful widget that the main application instantiates.

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  State<LoadingWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linearToEaseOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, .45),
      body: Center(
        child: RotationTransition(
          turns: _animation,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/images/loading.svg',),
          ),
        ), /* Text('Loading') */
      ),
    );
  }
}
