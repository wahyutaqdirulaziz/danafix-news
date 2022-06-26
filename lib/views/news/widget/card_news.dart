import 'package:danafix/views/news/news.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class NewsCard extends StatefulWidget {
  String? title;
  String? description;
  String? image;
  DateTime? date;
  String? url;
  NewsCard({this.title, this.description, this.image, this.date, this.url});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  final DateFormat formatter = DateFormat.yMMMMd('en_US');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(NewsWebview(
          url: widget.url,
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(233, 233, 233, 1),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(233, 233, 233, 1),
                ),
                image: DecorationImage(
                    image: NetworkImage(
                      widget.image!,
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    widget.description!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color.fromRGBO(139, 144, 165, 1),
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    formatter.format(widget.date!).toString(),
                    style: const TextStyle(
                        color: Color.fromRGBO(139, 144, 165, 1), fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
