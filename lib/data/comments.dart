
import 'dart:convert';
import 'package:http/http.dart' as http;

class CommentList {
  List<Comment> comments;

  CommentList(this.comments);

  factory CommentList.fromJson(List<dynamic> json) {
    var commentsJson = json as List;

    List<Comment> newsList =
    commentsJson.map((e) => Comment.fromJson(e)).toList();

    return CommentList(newsList);
  }
}

class Comment {
  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  int postId;
  int id;
  String name;
  String email;
  String body;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    postId: json["postId"],
    id: json["id"],
    name: json["name"],
    email: json["email"],
    body: json["body"],
  );

}

Future<CommentList> getCommentList() async {
  const url = 'https://jsonplaceholder.typicode.com/comments';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("OK");
    return CommentList.fromJson(json.decode(response.body));
  } else {
    print("Not OK");
    throw Exception('Error: ${response.reasonPhrase}');
  }
}


