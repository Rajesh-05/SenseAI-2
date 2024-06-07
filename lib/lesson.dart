import 'dart:convert';

import 'package:sense_ai/file.dart';
import 'package:sense_ai/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LessonsView extends StatefulWidget {
  final int i ;
  const LessonsView({super.key,required this.i});

  @override
  State<LessonsView> createState() => _LessonsViewState(i: i);
}

int cont =0 ;

class _LessonsViewState extends State<LessonsView> {
  int i =0;
  _LessonsViewState({required this.i});
  var response;
  var data;
  var data5;
  late var topics = fTopics[i];
  var loading=1 ;

  // Future<void> GetData() async {
  //   response = await rootBundle.loadString('assets/Zoo-dataset2.json');
  //   data = await json.decode(response);
  //   data5 = data['Microbes in Human Welfare'];
  //   topics = [];
  //   for (final i in data5.keys) {
  //     topics.add(i);
  //   }
  //   setState(() {
  //     topics = topics;
  //     loading=1 ;
  //   });
  // }

    @override
    void initState() {
      // GetData();
      super.initState();
      //_startAutoScroll();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Topics"),
        centerTitle: true,
      ),
      body: Center(
        child: loading==0? CircularProgressIndicator() : Container(
          padding: const EdgeInsets.all(25),
          width: 800,
          child: ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context,index){
                return Card(

                  child: Column(
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          // borderRadius: BorderRadius.circular(30)
                        ),
                        child: ListTile(

                          trailing: ElevatedButton(onPressed: (){
                            cont = index ;
                            Navigator.of(context).push(
                              CupertinoPageRoute(builder: (context) {
                                return ParagraphsAndImageViewer(i:index,less: i);
                              }),);
                          },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(130, 30),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)) ,
                              ),
                          child: Text("Learn")
                            ),
                          title: Text(topics[index],style: TextStyle(fontWeight: FontWeight.bold),),
                          onTap: () {
                            cont = index ;
                            Navigator.of(context).push(
                              CupertinoPageRoute(builder: (context) {
                                  return ParagraphsAndImageViewer(i:index,less: i);
                                }),);
                              }),
                                             ),
                      // SizedBox(height: 10,)
                    ],
                  ),

                );
          }),
        ),
      ),
    );
  }
}
