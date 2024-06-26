import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/controllers/category_news_controller.dart';
import 'package:news_app/controllers/headlines_controller.dart';
import 'package:news_app/resources/utils/date_format.dart';
import 'package:news_app/views/categories.dart';
import 'package:news_app/views/showNews.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String newChannel = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    HeadlinesController headlinesController = HeadlinesController();

    CategoryNews categoryNews = CategoryNews();
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.category),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Categories()));
            },
          ),
          actions: [
            PopupMenuButton(
                initialValue: newChannel,
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("BBC News"),
                        onTap: () {
                          setState(() {
                            newChannel = 'bbc-news';
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text("The Hindu"),
                        onTap: () {
                          setState(() {
                            newChannel = 'the-hindu';
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text("The Times of India"),
                        onTap: () {
                          setState(() {
                            newChannel = 'the-times-of-india';
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text("Fox News"),
                        onTap: () {
                          setState(() {
                            newChannel = "fox-news";
                          });
                        },
                      ),
                    ])
          ],
          centerTitle: true,
          title: Text(
            "NEWS",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            FutureBuilder(
              future: headlinesController.getHeadlines(newChannel),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: height * 0.8,
                    child: Center(
                      child: SpinKitRotatingCircle(
                        color: Colors.red,
                        size: 50.0,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: height * 0.6,
                    // color: Colors.blue,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.articles.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ShowNews(
                                            image: snapshot
                                                .data.articles[index].urlToImage
                                                .toString(),
                                            channel: snapshot.data
                                                .articles[index].source.name,
                                            date: snapshot.data.articles[index]
                                                .publishedAt,
                                            desc: snapshot.data.articles[index]
                                                .description,
                                            title: snapshot
                                                .data.articles[index].title,
                                          )));
                            },
                            child: Container(
                                width: width * 0.75,
                                margin: EdgeInsets.all(width * 0.03),
                                // color: Colors.red,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: CachedNetworkImage(
                                        height: double.infinity,
                                        width: double.infinity,
                                        imageUrl: snapshot
                                            .data.articles[index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                                child: SpinKitCircle(
                                          color: Colors.green,
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          color: Colors.grey.withOpacity(0.4),
                                          width: double.infinity,
                                          child: Icon(
                                            Icons.error_outline_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: height * 0.18,
                                      margin: EdgeInsets.only(bottom: 18),
                                      child: Card(
                                        color: Colors.white.withOpacity(0.3),
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot
                                                    .data.articles[index].title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(snapshot
                                                      .data
                                                      .articles[index]
                                                      .source
                                                      .name),
                                                  Text(DateFormater.showDate(
                                                      snapshot
                                                          .data
                                                          .articles[index]
                                                          .publishedAt))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        }),
                  );
                }
              },
            ),
            Container(
              height: height * 0.6,
              child: FutureBuilder(
                future: categoryNews.getCategoryNews('general'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SpinKitRotatingCircle(
                        color: Colors.red,
                        size: 50.0,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.articles.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ShowNews(
                                            image: snapshot
                                                .data.articles[index].urlToImage
                                                .toString(),
                                            channel: snapshot.data
                                                .articles[index].source.name,
                                            date: snapshot.data.articles[index]
                                                .publishedAt,
                                            desc: snapshot.data.articles[index]
                                                .description,
                                            title: snapshot
                                                .data.articles[index].title,
                                          )));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width * 0.4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: CachedNetworkImage(
                                        height: height * 0.18,
                                        imageUrl: snapshot
                                            .data.articles[index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                                child: SpinKitCircle(
                                          color: Colors.green,
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          color: Colors.grey.withOpacity(0.4),
                                          child: Icon(
                                            Icons.error_outline_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.18,
                                    width: width * 0.52,
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data.articles[index].title,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data.articles[index]
                                                    .source.name,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: width * 0.018),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                DateFormater.showDate(
                                                  snapshot.data.articles[index]
                                                      .publishedAt,
                                                ),
                                                style: TextStyle(
                                                    fontSize: width * 0.028),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ));
  }
}
