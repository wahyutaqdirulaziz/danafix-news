import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:danafix/controllers/news_controller.dart';
import 'package:danafix/helper/firebase_auth.dart';
import 'package:danafix/helper/theme.dart';
import 'package:danafix/views/news/widget/card_news.dart';
import 'package:danafix/views/news/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription? connection;
  bool isoffline = false;

  final NewsController newsController = Get.put(NewsController());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    if (newsController.count == 1) {
    } else {
      newsController.count -= 1;
    }
    newsController.getnews(newsController.count);
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    newsController.count++;
    _refreshController.loadComplete();
    newsController.getnews(newsController.count);
  }

  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    newsController.getnews(newsController.count);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Container(
            child: Image.asset(
              "assets/images/logo.jpeg",
              width: 50,
            ),
          ),
          actions: [
            IconButton(
              color: primaryBlue,
              onPressed: () {
                // method to show the search bar
                Get.to(NewsSearch());
              },
              icon: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.search_rounded)),
            ),
            IconButton(
                color: primaryBlue,
                onPressed: () {
                  // method to show the search bar
                  authController.signOut();
                },
                icon: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.logout_rounded))),
          ],
          backgroundColor: Colors.white,
        ),
        body: Obx(() {
          if (newsController.isLoading.value) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
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
                )));
          } else {
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: const WaterDropHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.separated(
                itemCount: newsController.news.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewsCard(
                    title: newsController.news[index].title,
                    description: newsController.news[index].description,
                    image: newsController.news[index].urlToImage,
                    date: newsController.news[index].publishedAt,
                    url: newsController.news[index].url,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10.0,
                  );
                },
              ),
            );
          }
        }));
  }
}
