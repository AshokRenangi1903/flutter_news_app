import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/category_news_model.dart';

class CategoryNews {
  Future getCategoryNews(String category) async {
    var categoryNews =
        "https://newsapi.org/v2/everything?q=$category&apiKey=5b39f8103d8640e4839bb2be4b4b9661";
    var response = await http.get(Uri.parse(categoryNews));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return CategoryNewsModel.fromJson(body);
    } else {
      throw Exception("error");
    }
  }
}
