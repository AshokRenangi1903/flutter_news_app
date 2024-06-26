import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/headlines_model.dart';

class HeadlinesController {
  Future getHeadlines(String newsChannel) async {
    var headlinesUrl =
        "https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=5b39f8103d8640e4839bb2be4b4b9661";

    var response = await http.get(Uri.parse(headlinesUrl));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return HeadlinesModel.fromJson(body);
    } else {
      throw Exception("error");
    }
  }
}
