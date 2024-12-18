import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsly/model/show_category.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoriesNews(String category)async {
    String urlNews = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=fe7d5cfe3eca4b2fbc9882d416f3aeb9";
    var response = await http.get(Uri.parse(urlNews));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element['description'] != null){
          ShowCategoryModel categoryModel = ShowCategoryModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          categories.add(categoryModel);
        }
      });
    }
  }
}