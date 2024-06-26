import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/controllers/category_news_controller.dart';
import 'package:news_app/resources/utils/date_format.dart';
import 'package:news_app/views/showNews.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var selectedCategory = 'General';
  @override
  Widget build(BuildContext context) {
    CategoryNews categoryNews = CategoryNews();
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    List categories = [
      'General',
      'Sports',
      'Health',
      'Entertainment',
      'Movies',
      'Technology',
      'Bussiness',
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: height * 0.07,
            // color: Colors.red,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectedCategory = categories[index];
                      print(selectedCategory);
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.all(6),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue, width: 2),
                        color: selectedCategory == categories[index].toString()
                            ? Colors.blue
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                selectedCategory == categories[index].toString()
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          FutureBuilder(
            future: categoryNews.getCategoryNews(selectedCategory),
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
                return Expanded(
                  child: ListView.builder(
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
                                            channel: snapshot
                                                .data.articles[index].source.name,
                                            date: snapshot
                                                .data.articles[index].publishedAt,
                                            desc: snapshot
                                                .data.articles[index].description,
                                            title: snapshot
                                                .data.articles[index].title,
                                          )));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Container(
                              // color: Colors.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // color: Colors.orange,
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
                                            maxLines: 2,
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
                                              Text(DateFormater.showDate(
                                                  snapshot.data.articles[index]
                                                      .publishedAt))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
