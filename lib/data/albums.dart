import 'dart:convert';
import 'package:http/http.dart' as http;

class AlbumList {
  List<Album> albums;

  AlbumList(this.albums);

  factory AlbumList.fromJson(List<dynamic> json) {
    var albumsJson = json as List;

    List<Album> albumsList =
    albumsJson.map((e) => Album.fromJson(e)).toList();

    return AlbumList(albumsList);
  }
}

class Album {


  int userId;
  int id;
  String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
  );


}

Future<AlbumList> getAlbumList() async {
  const url = 'https://jsonplaceholder.typicode.com/albums';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("OK");
    return AlbumList.fromJson(json.decode(response.body));
  } else {
    print("Not OK");
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

