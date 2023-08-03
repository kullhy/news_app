import 'dart:convert';
import 'dart:developer';

import 'package:learn_bloc_2/models/news/article.dart';
import 'package:http/http.dart' as http;

Future<List<Article>> fetchHeadline() async {
  try {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=d0feb78512ac453ebe15444e2f6fe72f";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<Article> articles = (json['articles'] as List)
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
      log("nội dung :${articles[1].content!}");
      return articles;
    } else {
      throw Exception('Failed to load headlines');
    }
  } catch (e) {
    throw Exception('Failed to load headlines: $e');
  }
}
