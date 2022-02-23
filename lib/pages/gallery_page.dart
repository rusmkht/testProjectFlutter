import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/albums.dart';
import 'package:flutter_project_1/data/photos.dart';

class Gallery_page extends StatefulWidget {
  @override
  _Gallery_pageState createState() => _Gallery_pageState();
}

class _Gallery_pageState extends State<Gallery_page> {
  late Future<AlbumList> albumsList;
  late Future<PhotosList> photosList;

  var colorBack = const Color(0xff01062B);
  var colorMain = const Color(0xff29046E);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    albumsList = getAlbumList();
    photosList = getPhotosList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBack,
      appBar: AppBar(
        title: Text(
          "Gallery",
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
        backgroundColor: colorMain,
      ),
      body: FutureBuilder<AlbumList>(
        future: albumsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<PhotosList>(
                future: photosList,
                builder: (context, snapshot2) {
                  int id = 1;
                  List<Photos>? phot = snapshot2.data!.photos;
                  List<Photos> mainPhotos = [];
                  if(snapshot2.data!=null) {
                    for (var i in phot) {
                      if (i.albumId == id) {
                        id++;
                        mainPhotos.add(i);
                      }
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if (index + 1 >= snapshot.data!.albums.length - 1 &&
                            index.isEven) {
                          return Align(
                              child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/albumPage',
                                    arguments: snapshot.data!.albums[index]);
                              },
                              child: Container(
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Ink.image(
                                      image: NetworkImage(
                                          "${mainPhotos[index].url}"),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                          "${snapshot.data!.albums[index].title}" ,  style: TextStyle(fontWeight: FontWeight.bold),),
                                    )
                                  ],
                                ),
                                height: 175,
                                width: 175,
                              ),
                            ),
                          ));
                        } else {
                          if (index.isEven) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 10),
                              child: Row(
                                children: [
                                  Align(
                                      child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/albumPage',
                                            arguments:
                                                snapshot.data!.albums[index]);
                                      },
                                      child: Container(
                                        child: Stack(
                                          alignment: Alignment.bottomLeft,
                                          children: [
                                            Ink.image(
                                              image: NetworkImage(
                                                  // ignore: unnecessary_string_interpolations
                                                  "${mainPhotos[index].url}"),
                                              fit: BoxFit.cover,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                  "${snapshot.data!.albums[index].title}" , style: TextStyle(fontWeight: FontWeight.bold),),
                                            )
                                          ],
                                        ),
                                        height: 175,
                                        width: 175,
                                      ),
                                    ),
                                  )),
                                  Align(
                                      child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/albumPage',
                                            arguments: snapshot
                                                .data!.albums[index + 1]);
                                      },
                                      child: Container(
                                        child: Stack(
                                          alignment: Alignment.bottomLeft,
                                          children: [
                                            Ink.image(
                                              image: NetworkImage(
                                                  "${mainPhotos[index + 1].url}"),
                                              fit: BoxFit.cover,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                  "${snapshot.data!.albums[index + 1].title}", style: TextStyle(fontWeight: FontWeight.bold),),
                                            )
                                          ],
                                        ),
                                        height: 175,
                                        width: 175,
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        }
                      },
                      itemCount: snapshot.data!.albums.length - 1,
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text("Error");
          } else {
            return Center(child: Text("Loading...", style: TextStyle(fontSize: 23),));
          }
        },
      ),
    );
  }
}

class Album_page extends StatelessWidget {
  var colorBack = const Color(0xff01062B);
  var colorMain = const Color(0xff29046E);

  late Future<PhotosList> photosList;

  @override
  Widget build(BuildContext context) {
    photosList = getPhotosList();

    RouteSettings settings = ModalRoute.of(context)!.settings;
    Album album = settings.arguments as Album;

    return FutureBuilder<PhotosList>(
        future: photosList,
        builder: (context, snapshot) {
          List<Photos> currentList = [];
          if(snapshot.data!=null) {
            for (var i in snapshot.data!.photos) {
              if (i.albumId == album.id) {
                currentList.add(i);
              }
            }
          }

          int count = 1;
          bool predel = true;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: colorMain,
              title: Text(
                "${album.id} Album",
                style: TextStyle(fontSize: 23),
              ),
              centerTitle: true,
            ),
            backgroundColor: colorBack,
            body: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (predel) {
                    if (count == 1) {
                      count += 1;
                      if (index + 1 > currentList.length - 1 && predel) {
                        predel = false;
                        count = 10;
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/photoPage',
                                        arguments: currentList[index].url);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    height: 115,
                                    width: 115,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Ink.image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${currentList[index].url}")),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${currentList[index].title}",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (index + 2 > currentList.length - 1 && predel) {
                        predel = false;
                        count = 10;
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/photoPage',
                                        arguments: currentList[index].url);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    height: 115,
                                    width: 115,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Ink.image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${currentList[index].url}")),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${currentList[index].title}",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/photoPage',
                                        arguments: currentList[index+1].url);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    height: 115,
                                    width: 115,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Ink.image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${currentList[index+1].url}")),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${currentList[index+1].title}",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/photoPage',
                                        arguments: currentList[index].url);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    height: 115,
                                    width: 115,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Ink.image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${currentList[index].url}")),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${currentList[index].title}",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/photoPage',
                                        arguments: currentList[index+1].url);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    height: 115,
                                    width: 115,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Ink.image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${currentList[index+1].url}")),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${currentList[index+1].title}",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/photoPage',
                                        arguments: currentList[index+2].url);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    height: 115,
                                    width: 115,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Ink.image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${currentList[index+2].url}")),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${currentList[index+2].title}",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    } else if (count == 2) {
                      count += 1;
                      return SizedBox();
                    } else {
                      count -= 2;
                      return SizedBox();
                    }
                  } else {
                    return SizedBox();
                  }
                },
                itemCount: currentList.length,
              ),
            ),
          );
        });
  }
}

class PhotoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    String url = settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Ink.image(image: NetworkImage("${url}")),
            Padding(
              padding: const EdgeInsets.only(top: 30,left: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            )
          ],
        ),
      ),
    );
  }
}
