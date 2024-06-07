import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';


fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}



class Summary extends StatefulWidget {
  final String para ;
  const Summary({Key? key,required this.para}) : super(key: key);

  @override
  _SummaryState createState() => _SummaryState(para: para);
}




class _SummaryState extends State<Summary> {
  String para="" ;
   _SummaryState({
    required this.para,
  }) ;
  String url = '';
  var data;
  String output = ' ';

  @override
  void initState() {
    getData();
    super.initState();
  }
  int imgloading=0 ;
  String paraImg = "" ;
  Future getData () async {

    url = 'http://127.0.0.1:5000/sum?text=$para';
    //_Controller.clear();4
    setState(() {
      imgloading = 0 ;
      output='Loading';
      url = 'http://127.0.0.1:5000/sum?text=$para';
    });
    data = await fetchdata(url);
    var decoded = jsonDecode(data);
    output = decoded['sum'];

    setState(() {
      output = decoded['sum'];
    });
    var imgdata = await fetchdata('http://127.0.0.1:5002/img?text=$output');
    var imgdict = jsonDecode(imgdata);
    var imglist = imgdict['img'] ;
    paraImg = imglist[0] ;
    setState(() {
     imgloading=1 ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //appBar: AppBar(title: Text('Summary')),
      body: output=='Loading' ? Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
        child: Container(

          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       // Question
              //       SizedBox(width: 500,
              //         child: TextField(
              //           onChanged: (value) {
              //             url = 'http://127.0.0.1:5000/api?text=' + value.toString();
              //           },
              //           onSubmitted: (value) => () async {
              //             setState(() {
              //               output='Loading';
              //             });
              //             data = await fetchdata(url);
              //             var decoded = jsonDecode(data);
              //             setState(() {
              //               output = decoded['output'];
              //             });
              //           },
              //           decoration: const InputDecoration(
              //               hintText: "Ask",
              //               //prefixIcon: Icon(Icons.search),
              //               border: OutlineInputBorder(
              //                   borderSide: BorderSide(
              //                     color: Colors.white10,
              //                   )
              //               )
              //           ),
              //         ),
              //       ),
              //       TextButton(
              //         onPressed: () async {
              //           setState(() {
              //             output='Loading';
              //           });
              //           data = await fetchdata(url);
              //           var decoded = jsonDecode(data);
              //           setState(() {
              //             output = decoded['output'];
              //           });
              //         },
              //         style: ButtonStyle(),
              //         child: Icon(Icons.send) ,
              //         // Text(
              //         //   'Next',
              //         //   style: TextStyle(fontSize: 20),
              //         // )
              //       ),
              //
              //     ]),

              // Ans


              Container(
                // width:1000,
                padding: const EdgeInsets.all(10),

                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Container(
                          height: 350,
                          padding: EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            child: Column(
                                children: [
                                  Text('Summary : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                  SizedBox(height: 50,),
                                  output=='Loading' ? CircularProgressIndicator() :
                                  Text(output, style: TextStyle(fontSize: 16),

                                  ),  ]),
                          ),
                        ),
                      ),
                    ),

                    Card(
                      child: Container(
                        height: 350,
                        width: 400,
                        padding: EdgeInsets.all(16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: imgloading==0?CircularProgressIndicator():Image.asset(
                            "assets/database/"+paraImg  ,
                            fit: BoxFit.cover,
                          ),
                          ),
                        ),
                      ),

                  ],
                ),
              ),

              // Card(
              //   child: Container(
              //     width: 1000,
              //     height: 160,
              //
              //     child: Text("Translations : "),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class options extends StatelessWidget {
  const options({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}