import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebview extends StatefulWidget {
  String? url;
  NewsWebview({this.url});

  @override
  State<NewsWebview> createState() => _NewsWebviewState();
}

class _NewsWebviewState extends State<NewsWebview> {
  StreamSubscription? connection;
  bool isoffline = false;
  int? position = 1;
  final key = UniqueKey();
  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  void initState() {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
           Get.snackbar(
        "Error",
        "Internet is not Connected",
        snackPosition: SnackPosition.BOTTOM,
      );
        });
      
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        
        setState(() {
          isoffline = false;
           Get.snackbar(
        "Success",
        "Internet is Connected",
        snackPosition: SnackPosition.BOTTOM,
      );
        });
       
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
           Get.snackbar(
        "Success",
        "Internet is Connected",
        snackPosition: SnackPosition.BOTTOM,
      );
        });
        
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        setState(() {
          isoffline = false;
           Get.snackbar(
        "Success",
        "Internet is Connected",
        snackPosition: SnackPosition.BOTTOM,
      );
        });
        
      
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        setState(() {
          isoffline = false;
           Get.snackbar(
        "Success",
        "Internet is Connected",
        snackPosition: SnackPosition.BOTTOM,
      );
        });
        
      }
    });
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            child: Image.asset(
              "assets/images/logo.jpeg",
              width: 50,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: (!isoffline)
            ? IndexedStack(
                index: position,
                children: [
                  WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    key: key,
                    onPageFinished: doneLoading,
                    onPageStarted: startLoading,
                    initialUrl:
                        widget.url == null ? "https://flutter.dev" : widget.url,
                  ),
                  Container(
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
                ],
              )
            : Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.jpeg",
                        width: 80,
                      ),
                      Text("Internet not Connected !")
                    ],
                  ),
                ),
              ));
  }
}
