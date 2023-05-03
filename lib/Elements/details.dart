import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:iconly/iconly.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DetailView(),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(""),
          ),
          // buttonArrow(context),
          scroll()
        ],
      ),
    ));
  }

  // buttonArrow(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: InkWell(
  //       onTap: () {
  //         Navigator.pop(context);
  //       },
  //       child: Container(
  //         clipBehavior: Clip.hardEdge,
  //         height: 55,
  //         width: 55,
  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
  //         child: BackdropFilter(
  //             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  //             child: Container(
  //               height: 55,
  //               width: 55,
  //               decoration:
  //                   BoxDecoration(borderRadius: BorderRadius.circular(25)),
  //               child: const Icon(
  //                 Icons.arrow_back_ios,
  //                 size: 20,
  //                 color: Colors.white,
  //               ),
  //             )),
  //       ),
  //     ),
  //   );
  // }

  scroll() {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, ScrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 35,
                        color: Colors.black12,
                      )
                    ],
                  ),
                ),
                Text(
                  "News Title",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("DD-MM-YYYY"),
                const Text("Author"),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    height: 4,
                  ),
                ),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Expanded(
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent at eros nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Fusce ac odio sit amet justo mollis lacinia quis sit amet nibh. Ut ut tellus eget magna tristique bibendum. Nam eget varius velit. Integer a lacus velit. Curabitur sit amet elit sed elit accumsan scelerisque vel vitae nunc. Donec volutpat ante eu enim interdum, vel vestibulum arcu posuere.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ElevatedButton(
                    onPressed: (//link
                        ) {},
                    child: const Text("Read More")),
              ],
            ),
          );
        });
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'API Demo',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Details',
//             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
//           ),
//         ),
//       ),
//     );
//   }
// }

// @override
//   Widget build(BuildContext context){
//   return SafeArea(
//     child: Scaffold(
//       body: Stack(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: Image.asset(""),
//           ),
//           buttonArrow()
//         ],
//       ),
//     ));
// }

// buttonArrow(){
// return Container(
//   clipBehavior: Clip.hardEdge,
//               height: 55,
//            width: 55,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX:10, sigmaY: 10),
//                 child: Container(
//                   height: 55,
//                   width: 55,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   child: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white,),
//                 ),
//               ),
//             );
// }
// }

// Future<List<String>> getNewsChannels() async {
//   String apiKey = "7a2036d273524925b937fddb814623c5";
//   String url = "https://newsapi.org/v2";
//   String channelWeblink = "$url/sources?apiKey=$apiKey";

//   final response = await http.get(Uri.parse(channelWeblink));
//   if (response.statusCode == 200) {
//     final sourcesJson = json.decode(response.body)['sources'];
//     return sourcesJson
//         .map<String>((source) => source['name'] as String)
//         .toList();
//   } else {
//     throw Exception('Failed to load news channels');
//   }
// }
