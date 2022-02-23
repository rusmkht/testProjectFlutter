import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsList {
  List<News> news;

  NewsList(this.news);

  factory NewsList.fromJson(List<dynamic> json) {
    var newsJson = json as List;

    List<News> newsList =
    newsJson.map((e) => News.fromJson(e)).toList();

    return NewsList(newsList);
  }
}

class News {
  News({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  int userId;
  int id;
  String title;
  String body;

  factory News.fromJson(Map<String, dynamic> json) => News(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );


}

Future<NewsList> getNewsList() async {
  const url = 'https://jsonplaceholder.typicode.com/posts';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("OK");
    return NewsList.fromJson(json.decode(response.body));
  } else {
    print("Not OK");
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

