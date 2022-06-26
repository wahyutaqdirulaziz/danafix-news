// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  String? status;
  int? totalResults;
  List<Article>? articles;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"] ?? "Lorem Ipsum is an example of dummy text in the printing and typesetting industry. Lorem Ipsum has been the standard sample text since the 1500s, when an unknown printer took a collection of texts and scrambled them to make a letter sample book. It has not only lasted for 5 centuries, but has also transitioned to electronic typesetting, without any changes. It was popularized in the 1960s with the release of Letraset sheets using sentences from Lorem Ipsum, and with the advent of Desktop Publishing software such as Aldus PageMaker also had versions of Lorem Ipsum.",
        url: json["url"],
        urlToImage: json["urlToImage"] ?? "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/b1/a3/fd/b1a3fd6c-4210-8726-6ea7-5b855bdd9317/AppIcon-0-0-1x_U007emarketing-0-0-0-10-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/1200x630wa.png",
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source!.toJson(),
        "author": author,
        "title": title,
        "description": description ?? "Lorem Ipsum is an example of dummy text in the printing and typesetting industry. Lorem Ipsum has been the standard sample text since the 1500s, when an unknown printer took a collection of texts and scrambled them to make a letter sample book. It has not only lasted for 5 centuries, but has also transitioned to electronic typesetting, without any changes. It was popularized in the 1960s with the release of Letraset sheets using sentences from Lorem Ipsum, and with the advent of Desktop Publishing software such as Aldus PageMaker also had versions of Lorem Ipsum.",
        "url": url,
        "urlToImage": urlToImage ?? "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/b1/a3/fd/b1a3fd6c-4210-8726-6ea7-5b855bdd9317/AppIcon-0-0-1x_U007emarketing-0-0-0-10-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/1200x630wa.png",
        "publishedAt": publishedAt!.toIso8601String(),
        "content": content,
      };
}

class Source {
  Source({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
