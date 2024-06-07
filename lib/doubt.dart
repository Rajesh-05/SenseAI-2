import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';


fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}



// void main(){
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "main",
//       home: Home(),
//     );
//   }
// }





class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String url = '';
  var data;
  int mode =1;
  String output = ' ';
  String path = ' ';
  TextEditingController _Controller = TextEditingController();

  Future getData (String text,String mode) async {

    url = 'http://127.0.0.1:5000/api?text=$mode' + text.toString();
    _Controller.clear();
    setState(() {
      output='Loading';
      url = 'http://127.0.0.1:5000/api?text=$mode' + text.toString();
    });
    data = await fetchdata(url);
    var decoded = jsonDecode(data);
    setState(() {
      output = decoded['answer'];
      path = decoded['path'] ;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Clarify your doubts !')),
      body: SingleChildScrollView(
        child: Container(

          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(120, 40)
                        ),

                        onPressed: () {
                      setState(() {
                        mode == 1 ? mode=2 : mode=1 ;

                      });
                    } ,
                        child: Center(child: Text(mode==1 ? "General" : "In-BOOK" ))) ,

                    //Icon(mode==0 ? Icons.looks_one_outlined : Icons.looks_two_rounded ,),
                // Question
                    SizedBox(width:15,height:5) ,

                SizedBox(width: 500,
                  child: TextField(
                    // onChanged: (value) {
                    //   url = 'http://127.0.0.1:5000/api?text=' + value.toString();
                    // },
                    controller: _Controller,
                    onSubmitted: mode==1 ? (text) => getData(text,'c') : (text) => getData(text,'q'),
                    decoration: const InputDecoration(
                      hintText: "Ask Zen",
                      suffixIcon: IconButton(onPressed:null,  icon: Icon(Icons.mic_rounded,color: Colors.black,)),
                      //prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white10,
                        )
                      )
                    ),
                  ),
                ),

                TextButton(
                    onPressed: () { mode==1 ?  getData(_Controller.text,'c')
                        : getData(_Controller.text,'q'); } ,
                    style: ButtonStyle(),
                    child: Icon(Icons.send,color: Colors.black,) ,
                    // Text(
                    //   'Next',
                    //   style: TextStyle(fontSize: 20),
                    // )
                ),

              ]),

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
                      child: Column(
                      children: [
                      Text('Result :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      SizedBox(height: 50,),
                        output=='Loading' ? CircularProgressIndicator() :
                      Text(output, style: TextStyle(fontSize: 16),

    ),  ]),
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
                child: output=='Loading' ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                )
                    :
                  mode==1 ? null :

                path == " " ? null :


                Image.asset(
                   "assets/database/$path" ,
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
