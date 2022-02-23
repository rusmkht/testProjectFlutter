import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/comments.dart';
import 'package:flutter_project_1/data/news.dart';

class News_page extends StatefulWidget {
  const News_page({Key? key}) : super(key: key);

  @override
  _News_pageState createState() => _News_pageState();
}

class _News_pageState extends State<News_page> {
  var colorBack = const Color(0xff01062B);
  var colorMain = const Color(0xff29046E);

  late Future<NewsList> newsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsList = getNewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBack,
      appBar: AppBar(
        title: Text(
          "News",
          style: TextStyle(fontFamily: 'RaleWay', fontSize: 23),
        ),
        centerTitle: true,
        backgroundColor: colorMain,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: FutureBuilder<NewsList>(
          future: newsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.news.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: 10, left: 3, right: 5),
                      child: Card(
                        child: InkWell(
                            splashColor: colorBack,
                            onTap: () {
                              debugPrint('Card tapped.');
                              Navigator.pushNamed(context, '/selectedNewsPage',
                                  arguments: snapshot.data!.news[index]);
                            },
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 13, left: 0, right: 0, bottom: 0),
                                child: ListTile(
                                  title: Container(
                                    height: 40,
                                    child: Text(
                                        "${snapshot.data!.news[index].title}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Container(
                                        height: 34,
                                        child: Text(
                                            "${snapshot.data!.news[index].body}")),
                                  ),
                                ),
                              ),
                              width: 100,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: colorMain,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            )),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("Error");
            } else {
              return Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class SelectedNewsPage extends StatefulWidget {
  const SelectedNewsPage({Key? key}) : super(key: key);

  @override
  _SelectedNewsPageState createState() => _SelectedNewsPageState();
}

class _SelectedNewsPageState extends State<SelectedNewsPage> {
  var colorBack = const Color(0xff01062B);
  var colorMain = const Color(0xff29046E);

  late Future<CommentList> commentList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentList = getCommentList();
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    News newsData = settings.arguments as News;
    List<Comment> comments = [];

    return FutureBuilder<CommentList>(
        future: commentList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (var i in snapshot.data!.comments) {
              if (i.postId == newsData.id) {
                comments.add(i);
              }
            }
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Post",
                  style: TextStyle(fontSize: 23),
                ),
                centerTitle: true,
                backgroundColor: colorMain,
              ),
              body: Container(
                color: colorBack,
                height: 700,
                width: 400,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 20, right: 15),
                            child: Text(
                              "${newsData.title}",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 50),
                            child: Text(
                              "${newsData.body}",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 5),
                            child: Card(
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(18),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white30),
                                            child: Padding(
                                              padding: const EdgeInsets.all(7),
                                              child: Icon(
                                                Icons.person,
                                                size: 27,
                                                color: Colors.white54,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${comments[0].email}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 10, bottom: 20),
                                      child: Container(
                                          child: Text("${comments[0].body}")),
                                    )
                                  ],
                                ),
                                width: 350,
                                decoration: BoxDecoration(
                                    color: colorMain,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 5),
                            child: Card(
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(18),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white30),
                                            child: Padding(
                                              padding: const EdgeInsets.all(7),
                                              child: Icon(
                                                Icons.person,
                                                size: 27,
                                                color: Colors.white54,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${comments[1].email}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 10, bottom: 20),
                                      child: Container(
                                          child: Text("${comments[1].body}")),
                                    )
                                  ],
                                ),
                                width: 350,
                                decoration: BoxDecoration(
                                    color: colorMain,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/moreCommentsPage',
                              arguments: comments);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          height: 75,
                          width: 390,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                "Show me all ${comments.length} comments",
                                style: TextStyle(fontSize: 22),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Icon(Icons.remove_red_eye),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: colorBack,
              body: Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          }
        });
  }
}

class MoreCommentsPage extends StatelessWidget {
  var colorBack = const Color(0xff01062B);
  var colorMain = const Color(0xff29046E);

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    List<Comment> comments = settings.arguments as List<Comment>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorMain,
        title: Text("Comments"),
        centerTitle: true,
      ),
      backgroundColor: colorBack,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 15, bottom: 5, right: 15),
              child: Card(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white30),
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Icon(
                                  Icons.person,
                                  size: 27,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${comments[index].email}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 10, bottom: 20),
                        child:
                            Container(child: Text("${comments[index].body}")),
                      )
                    ],
                  ),
                  width: 350,
                  decoration: BoxDecoration(
                      color: colorMain,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
            );
          },
          itemCount: comments.length,
        ),
      ),
    );
  }
}


