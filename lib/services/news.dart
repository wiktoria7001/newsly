import 'dart:convert';

import 'package:newsly/model/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews()async {
    String urlNews = "https://newsapi.org/v2/everything?q=tesla&from=2024-11-18&sortBy=publishedAt&apiKey=fe7d5cfe3eca4b2fbc9882d416f3aeb9";
    var response = await http.get(Uri.parse(urlNews));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element['description'] != null){
          ArticleModel article_model = ArticleModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          news.add(article_model);
        }
      });
    }
  }
}