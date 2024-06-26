import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/resources/utils/date_format.dart';

class ShowNews extends StatelessWidget {
  var title, channel, date, desc, image;
  ShowNews(
      {super.key, this.channel, this.date, this.desc, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Stack(
          // alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: CachedNetworkImage(
                height: height * .5,
                width: width,
                imageUrl: image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                    child: SpinKitCircle(
                  color: Colors.green,
                )),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.withOpacity(0.4),
                  child: Icon(
                    Icons.error_outline_outlined,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              // color: Colors.grey.withOpacity(0.2),
              margin: EdgeInsets.only(top: height * 0.45),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(18)),
              child: Container(
                padding: EdgeInsets.all(8),
                // height: height * 0.36,
                // color: Colors.red,
                child: Column(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          channel,
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          DateFormater.showDate(date),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      desc,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
