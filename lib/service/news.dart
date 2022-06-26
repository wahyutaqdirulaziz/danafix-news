import 'dart:convert';

import 'package:danafix/models/news.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  static var client = http.Client();

  static Future<NewsModel> getnews({page}) async {
    print(page);
    var token = "0d31931cda4d4b8dbc633f06933e822a";
    var response = await client.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?pageSize=10&apiKey=${token}&category=sports&page=$page'));
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);

      return NewsModel.fromJson(jsonString);
    } else {
      var jsonString = jsonDecode(response.body);

      return NewsModel.fromJson(jsonString);
    }
  }

  static Future<NewsModel> getnewssearch({keyword}) async {
    print(keyword);
    var token = "0d31931cda4d4b8dbc633f06933e822a";
    var response = await client.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=$keyword&apiKey=${token}'));
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);

      return NewsModel.fromJson(jsonString);
    } else {
      var jsonString = jsonDecode(response.body);

      return NewsModel.fromJson(jsonString);
    }
  }
}
