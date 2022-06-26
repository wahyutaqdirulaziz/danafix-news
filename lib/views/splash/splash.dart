import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: const Center(
              child: SizedBox(
        width: 30,
        child: LoadingIndicator(
            indicatorType: Indicator.lineSpinFadeLoader,

            /// Required, The loading type of the widget
            colors: [Colors.blue],

            /// Optional, The color collections
            strokeWidth: 2,

            /// Optional, The stroke of the line, only applicable to widget which contains line
            backgroundColor: Colors.white,

            /// Optional, Background of the widget
            pathBackgroundColor: Colors.white

            /// Optional, the stroke backgroundColor
            ),
      ))),
    );
  }
}
