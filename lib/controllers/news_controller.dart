import 'package:danafix/service/news.dart';
import 'package:get/state_manager.dart';
import 'package:danafix/models/news.dart';

class NewsController extends GetxController {
    var count = 1.obs();
  var isLoading = true.obs;
  var isLoadingSearch = true.obs;
  List news = <Article>[].obs();
List newsSearch = <Article>[].obs();

  void getnews(int page) async {
    try {
      isLoading(true);
      var res = await NewsApi.getnews(page: count.obs());
      news.assignAll(res.articles!.toList());
    } finally {
      isLoading(false);
    }
  }

  void getnewsSearch(keyword) async {
    try {
      isLoadingSearch(true);
      var res = await NewsApi.getnewssearch(keyword: keyword);
      newsSearch.assignAll(res.articles!.toList());
    } finally {
      isLoadingSearch(false);
    }
  }
}
