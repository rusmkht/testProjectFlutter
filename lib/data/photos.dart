import 'package:http/http.dart' as http;
import 'dart:convert';

class PhotosList {
  List<Photos> photos;

  PhotosList(this.photos);

  factory PhotosList.fromJson(List<dynamic> json) {
    var photosJson = json as List;

    List<Photos> photosList =
    photosJson.map((e) => Photos.fromJson(e)).toList();
    int i = 1;
    //photosList.map((e) => e.albumId==i?i++:photosList.remove(e)); типа если альбом айди равен i оставляем если нет убираем. типа сортировки

    return PhotosList(photosList);
  }
}

class Photos {
  Photos({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
    albumId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
  );


}

Future<PhotosList> getPhotosList() async {
  const url = 'https://jsonplaceholder.typicode.com/photos';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("OK");
    return PhotosList.fromJson(json.decode(response.body));
  } else {
    print("Not OK");
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

