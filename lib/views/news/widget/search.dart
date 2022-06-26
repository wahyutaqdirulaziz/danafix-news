import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:danafix/controllers/news_controller.dart';
import 'package:danafix/views/news/widget/card_news.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class NewsSearch extends StatefulWidget {
  NewsSearch({Key? key}) : super(key: key);

  @override
  State<NewsSearch> createState() => _NewsSearchState();
}

class _NewsSearchState extends State<NewsSearch> {
  StreamSubscription? connection;
  bool isoffline = false;
  var keyword = "hallo".obs();
  final NewsController newsControllers = Get.put(NewsController());
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

  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    newsControllers.getnewsSearch(keyword);

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          /* Clear the search field */
                          setState(() {});
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                  onChanged: (value) {
                    if (value == null) {
                      setState(() {
                        keyword = "mu";
                      });
                    } else {
                      setState(() {
                        keyword = value;
                      });
                    }
                  },
                ),
              ),
            )),
        body: Obx(() {
          if (newsControllers.isLoadingSearch.value) {
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
            return ListView.separated(
              itemCount: newsControllers.newsSearch.length,
              itemBuilder: (BuildContext context, int index) {
                return NewsCard(
                  title: newsControllers.newsSearch[index].title,
                  description: newsControllers.newsSearch[index].description,
                  image: newsControllers.newsSearch[index].urlToImage,
                  date: newsControllers.newsSearch[index].publishedAt,
                  url: newsControllers.newsSearch[index].url,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10.0,
                );
              },
            );
          }
        }));
  }
}
