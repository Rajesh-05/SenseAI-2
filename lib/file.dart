import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sense_ai/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class FilePick extends StatefulWidget {
  const FilePick({super.key});


  @override
  State<FilePick> createState() => _FilePickState();
}

fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body ;
}
var data;
var data2;

var path1;
var path2;


List flessons=[] ;
List flesscount = [] ;
int fcount = 1 ;
List fTopics = [] ;
List ftemp = [] ;

openFile(String type) async {
  FilePickerResult? resultFile = await FilePicker.platform.pickFiles();
  if(resultFile != null){
    PlatformFile file = resultFile.files.first;
    path1 = file.path ;
    path2 = path1.replaceAll(r'\', '/');
    print(path2) ;
    data = await fetchdata('http://127.0.0.1:5000/$type?text=${path2}');
    data = data.toString() ;
    var decoded = jsonDecode(data);
    var result = decoded['out'] ;
    // print(decoded['out']);
    flesscount.add("Lesson $fcount") ;
    for (final i in result.keys) {
      ftemp.add(i);
    }

    flessons.add(result) ;
    fTopics.add(ftemp) ;

    ftemp=[];
    print(fTopics);

    fcount++ ;


  }else{
    print("Bye..\n,\n,\n") ;
  }
}

class _FilePickState extends State<FilePick> {
  @override
  void setState(VoidCallback fn) {
    fTopics;
    flessons;
    super.setState(fn);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  NavBar(context),
      // AppBar(title: Text("Upload Files !"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            Container(
              width: 500,
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35)
              ),
              child: DottedBorder(
                color: Colors.black,
                strokeWidth: 2,
                dashPattern: [6, 3],
                radius: Radius.circular(35),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 25,),

                      Icon(Icons.cloud_upload_outlined,size: 100,opticalSize: 1,) ,
                      Text("Browse Files ",style: TextStyle(
                        fontSize: 25,

                      ),) ,
                      SizedBox(height: 35,),
                      ElevatedButton(onPressed: (){
                        openFile('ppt');
                        setState(() {
                        flessons ;
                        flesscount ;
                        fcount ;
                        fTopics ;
                        ftemp ;
                        });
                            },style: ElevatedButton.styleFrom(
                        fixedSize: Size(150,50)
                      ) ,child: Text("Select a PPT")),
                      SizedBox(height: 15,),
                      Text("OR") ,
                      SizedBox(height: 15,),
                      ElevatedButton(onPressed: (){
                        openFile('pdf');
                        setState(() {
                          flessons ;
                          flesscount ;
                          fcount ;
                          fTopics ;
                          ftemp ;
                        });
                      }, style: ElevatedButton.styleFrom(
                          fixedSize: Size(150, 50)
                      ),child: Text("Select a PDF")) ,

                    ],
                  ),
                  width: 500,
                  height: 400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
