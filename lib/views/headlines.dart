// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:news_app/controllers/headlines_controller.dart';

// class Headlines extends StatefulWidget {
//   const Headlines({super.key});

//   @override
//   State<Headlines> createState() => _HeadlinesState();
// }

// class _HeadlinesState extends State<Headlines> {
//   HeadlinesController headlinesController = HeadlinesController();
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: headlinesController.getHeadlines(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return SpinKitRotatingCircle(
//             color: Colors.white,
//             size: 50.0,
//           );
//         } else {
//           return ListView.builder(
//               itemCount: snapshot.data.articles.length,
//               itemBuilder: (context, index) {
//                 print(snapshot.data.articles.length);
//                 return Text("hi");
//               });
//         }
//       },
//     );
//   }
// }
