// import 'dart:convert';
//
// import 'package:sense_ai/main.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class OptionsView extends StatefulWidget {
//   const LessonsView({super.key});
//
//   @override
//   State<OptionsView> createState() => _LessonsViewState();
// }
//
// int cont =0 ;
//
// class _LessonsViewState extends State<OptionsView> {
//
//   var response;
//   var data;
//   var data5;
//   var topics;
//   var loading=0 ;
//
//   Future<void> GetData() async {
//     response = await rootBundle.loadString('assets/Zoo-dataset2.json');
//     data = await json.decode(response);
//     data5 = data['Microbes in Human Welfare'];
//     topics = [];
//     for (final i in data5.keys) {
//       topics.add(i);
//     }
//     setState(() {
//       topics = topics;
//       loading=1 ;
//     });
//   }
//
//   @override
//   void initState() {
//     GetData();
//     super.initState();
//     //_startAutoScroll();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Topics"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: loading==0? CircularProgressIndicator() : Container(
//           padding: const EdgeInsets.all(25),
//           width: 800,
//           child: ListView.builder(
//               itemCount: topics.length,
//               itemBuilder: (context,index){
//                 return Container(
//                   child: Column(
//                     children: [
//
//                       Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white70,
//                             borderRadius: BorderRadius.circular(30)
//                         ),
//                         child: ListTile(
//
//                             trailing: IconButton(onPressed: (){},icon: Icon(Icons.play_circle_outline_outlined,color: Colors.green,),),
//                             title: Text(topics[index],style: TextStyle(fontWeight: FontWeight.bold),),
//                             onTap: () {
//                               cont = index ;
//                               Navigator.of(context).push(
//                                 CupertinoPageRoute(builder: (context) {
//                                   return ParagraphsAndImageViewer(i:index);
//                                 }),);
//                             }),
//                       ),
//                       SizedBox(height: 10,)
//                     ],
//                   ),
//
//                 );
//               }),
//         ),
//       ),
//     );
//   }
// }
