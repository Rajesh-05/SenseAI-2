import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

import 'package:sense_ai/quizz.dart';
import 'package:sense_ai/evaluate.dart';
import 'package:sense_ai/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'doubt.dart';
import 'file.dart';
import 'homescreen.dart';
import 'lesson.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(MyApp());
}


PreferredSize NavBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(kToolbarHeight + 10), // here, increase the height as you want
    child: Padding(
      padding: const EdgeInsets.fromLTRB(350,25,350,0), // here, set the space you want
      child: AppBar(
        // title: Text('Virtual Teacher', style: TextStyle(fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children : [

                // MaterialButton(onPressed: (){}, child: Text("Hi"),
                //   hoverColor: Colors.transparent,
                //   splashColor: Colors.transparent,
                //   animationDuration: Duration(),
                //    ),
                // ElevatedButton(onPressed: (){}, child: Text("Hi") ,
                //     style:  ElevatedButton.styleFrom(
                //     backgroundColor: Colors.transparent ,
                //     fixedSize: Size(155, 45),
                //     foregroundColor: Colors.white,
                //     textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)
                // )),
                // ElevatedButton(onPressed: (){}, child: Text("Hi")),
                // ElevatedButton(onPressed: (){}, child: Text("Hi")),
                TextButton(
                  child: Text('HOME',
                    style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }),);
                  },
                  style: TextButton.styleFrom(primary: Colors.white, splashFactory: NoSplash.splashFactory,enableFeedback: false,
                      shape: RoundedRectangleBorder(),
                      fixedSize: Size(105, 55)
                  ),
                ),
                // TextButton(
                //   child: Text('LEARN',
                //     style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14),
                //   ),
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(builder: (context) {
                //         return HomePage();
                //       }),);
                //   },
                //   style: TextButton.styleFrom(primary: Colors.black, splashFactory: NoSplash.splashFactory,enableFeedback: false,
                //       shape: RoundedRectangleBorder(),
                //       fixedSize: Size(105, 55)
                //   ),
                // ),
                TextButton(
                  child: Text('CREATE',
                    style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return FilePick();
                      }),);
                  },
                  style: TextButton.styleFrom(primary: Colors.white, splashFactory: NoSplash.splashFactory,enableFeedback: false,
                      shape: RoundedRectangleBorder(),
                      fixedSize: Size(105, 55)
                  ),
                ), TextButton(
                  child: Text('DOUBTS',
                    style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            height: 600,
                            width: 1200,
                            child: Home(),
                          ),
                        );
                      },
                    );
                  },
                  style: TextButton.styleFrom(primary: Colors.white, splashFactory: NoSplash.splashFactory,enableFeedback: false,
                      shape: RoundedRectangleBorder(),
                      fixedSize: Size(105, 55)
                  ),
                ),
                TextButton(
                  child: Text('EVALUATE',
                    style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return ChatScreen();
                      }),);
                  },
                  style: TextButton.styleFrom(primary: Colors.white, splashFactory: NoSplash.splashFactory,enableFeedback: false,
                      shape: RoundedRectangleBorder(),
                      fixedSize: Size(105, 55)
                  ),
                ),
                SizedBox(width: 210,) ,

                // IconButton(
                //     onPressed: () {
                //       showDialog(
                //         context: context,
                //         builder: (context) {
                //           return Dialog(
                //             child: Container(
                //               height: 600,
                //               width: 1200,
                //               child: Home(),
                //             ),
                //           );
                //         },
                //       );
                //     },
                //     icon: Icon(Icons.question_answer_outlined)
                // ),
                Text('SenseAI',
                  style: TextStyle(fontWeight: FontWeight.w900,fontSize: 21,color: Colors.white),
                ) ,
                SizedBox(width: 60,)
              ]

          )

        ],
        centerTitle: true,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Virtual Teacher',
      theme: ThemeData(
        fontFamily: 'Lato',

        //appBarTheme: AppBarTheme(foregroundColor:Color.fromRGBO(14, 0, 95, 1) ),
        //appBarTheme: AppBarTheme(foregroundColor:Color.(14, 0, 95, 1) ),
        //colorScheme:ColorScheme.light(onPrimary: Colors.blue,background: Colors.grey,onSecondary: Colors.yellowAccent),
        //primaryColor: const Color.fromRGBO(14, 0, 95, 1),rgb(13, 18, 130)
        //colorScheme: ColorScheme.fromSwatch(accentColor: Colors.pinkAccent,primaryColorDark:Color.fromRGBO(13, 18, 130,1),cardColor:Colors.purpleAccent ),
        //secondaryHeaderColor: const Color.fromRGBO(14, 0, 95, 1),

        appBarTheme: AppBarTheme(
          color: Colors.black ,
          foregroundColor: Colors.white,
          
        ),
        colorScheme: ColorScheme.fromSwatch(backgroundColor: Colors.white,primaryColorDark: Colors.black,accentColor: Colors.white,primarySwatch: Colors.grey,
        cardColor:  Colors.white ,
          //,primaryColorDark: Color.fromRGBO(184, 158, 122,1)
        ),



        elevatedButtonTheme : ElevatedButtonThemeData(

          style:  ElevatedButton.styleFrom(
            backgroundColor: Colors.black ,
            fixedSize: Size(155, 45),
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)
          )

        ),
        //colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(13, 18, 130,1),primary: Color.fromRGBO(13, 18, 130,1),secondary: Color.fromRGBO(240, 222, 54,1)),
        useMaterial3: true ,

      ),


      home: HomePage(),


    );

  }
}



class ParagraphsAndImageViewer extends StatefulWidget {
  int i , less;
  ParagraphsAndImageViewer({
    super.key,
    this.i = 0,
    this.less = 0,
  });
  @override
  _ParagraphsAndImageViewerState createState() =>
      _ParagraphsAndImageViewerState(i: i,less: less);


}

class _ParagraphsAndImageViewerState extends State<ParagraphsAndImageViewer> {
  int i , less;
  _ParagraphsAndImageViewerState({this.i=0,this.less=0});
  int _currentPage=0;
  int _imgPage=0;
  late PageController _pageController =  PageController(initialPage: i);
  late PageController _pageController2 = PageController(initialPage: 0);
  Timer? _timer;

  final FlutterTts fluttertts = FlutterTts();

  speak(String para) async{
    await fluttertts.setLanguage('en-US');
    await fluttertts.setPitch(1.5);
    await fluttertts.setSpeechRate(0.55);
    await fluttertts.speak(para) ;

  }

  var response;
  var data;
  var data5 ;
  late var topics = fTopics[less];
  int loading=0;

  GetData () {
    setState(() {
      _currentPage=i;
      data5 = flessons[less];
      topics = fTopics[less];
      loading=1 ;

    });
    getData2(data5[topics[_currentPage]]);
    getDatatrans(data5[topics[_currentPage]]);
  }

  // Future<void> GetData() async {
  //
  //
  //   response = await rootBundle.loadString('assets/Zoo-dataset2.json');
  //   data = await json.decode(response);
  //   data5 = data['Microbes in Human Welfare'];
  //   topics = [];
  //   for (final i in data5.keys) {
  //     topics.add(i);
  //   }
  //   setState(() {
  //     _currentPage=i;
  //     topics = topics;
  //     loading = 1;
  //   });
  //   getData2(data5[topics[_currentPage]]);
  //   getDatatrans(data5[topics[_currentPage]]);
  // }

  fetchdata(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  List<String> paraImg = [];
  int imgloading = 0 ;

  String url='';
  dynamic output = '';
  Future getData2 (para) async {

    url = 'http://127.0.0.1:5000/trans?text=$para';
    setState(() {
      imgloading=0;
      output='Loading';
      url = 'http://127.0.0.1:5000/trans?text=$para';
      paraImg=[];
    });

    var imgdata = await fetchdata('http://127.0.0.1:5002/img?text=$para');
    var imgdict = jsonDecode(imgdata);
    var imglist = imgdict['img'] ;
    for (final i in imglist ){
      paraImg.add(i) ;
    }
    setState(() {
      paraImg ;
      imgloading=1;
      _startAutoScroll();
    });


    //_Controller.clear();

  }

  getDatatrans(para) async {
    data = await fetchdata('http://127.0.0.1:5000/trans?text=$para');
    var decoded = jsonDecode(data);
    setState(() {
      output = decoded['trans'].toString();

    });
  }

  //   for(final i in data5.keys){
  //     lesson.add(i);
  //   }
  //
  //   for (final j in lesson){
  //     print(data5[j].runtimeType);
  //     data5[j].runtimeType== String ?topics.add(j) : topics.add(data5[j].keys) ;
  //   }
  //

  List<String> imageUrls = [
    'assets/bio1.png',
    'assets/bio2.jpg',
    'assets/bio3.jpg',
    'assets/bio4.png',
   'assets/bio5.png',
  ];
  late IO.Socket socket;
  String receivedData = '';
  String receivedDub='';

  @override
  void initState() {
    GetData();
    socket = IO.io('http://127.0.0.1:5001/drowsy', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.on('data', (data) {
      setState(() {
        receivedData = data['data'];
        receivedData=='doubt' ? dub_pop() : showdrowsy();
      });
    });


    super.initState();
    //_startAutoScroll();

  }
  showdrowsy() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
        ),
        width: 50,
        height: 40,
        child: Text("$receivedData is Drowsy",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
      ),
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)) ,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: 600, left: 420, right: 420),
      backgroundColor: Colors.lightBlue,
    ));
  }

  @override
  void dispose() {
    socket.dispose();
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }



  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_imgPage < paraImg.length - 1) {
        _imgPage++;
      } else {
        _imgPage = 0;
      }

      _pageController2.animateToPage(
        _imgPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    );

  }

  dub_pop() {
  showDialog(context: context, builder: (context){
  return Dialog(
  child:  Container(
  height: 600,
  //width: 1000,
  child: Home()),
  );

  },
  );
}

  animate() {
    cont = _currentPage ;
    getData2(data5[topics[_currentPage]]);
    getDatatrans(data5[topics[_currentPage]]);

    //_currentPage++ ;
    _currentPage==topics.length ? _currentPage=0 : _currentPage ;
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    // _pageController2.animateToPage(
    //   _currentPage,
    //   duration: Duration(milliseconds: 250),
    //   curve: Curves.easeInOut,
    // );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: NavBar(context),

      // appBar:
      // AppBar(
      //
      //   title: Text('Virtual Teacher',style: TextStyle(fontWeight: FontWeight.bold),),
      //   shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(55)),
      //   actions: [
      //     ElevatedButton(onPressed: (){}, child: Text("Hi")) ,
      //     IconButton(onPressed: () {
      //
      //       showDialog(context: context, builder: (context){
      //         return Dialog(
      //           child:  Container(
      //               height: 600,
      //               width: 1200,
      //               child: Home()),
      //         );
      //
      //       },
      //       );
      //     }, icon: Icon(Icons.question_answer_outlined)),
      //     SizedBox(width: 80,)
      //   ],
      //   centerTitle: true,
      // ),
      // PreferredSize(
      //   preferredSize: Size(300,70),
      //   child: Container(
      //     child: Row(
      //       children: [
      //
      //       ],
      //     ),
      //   ),
      // ) ,

      body: loading==0 ? Center(child: CircularProgressIndicator()) :
      Container(
        padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 65),
        width: double.infinity,

        child: Column(
          children: [

            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2.5,
                          child: Container(
                            width: 480,

                            padding: EdgeInsets.all(36),
                            child: SingleChildScrollView(
                              child: Column(

                                children: [
                                  Text(topics[index],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32),),
                                  SizedBox(height: 20,),
                                  Text(
                                  data5[topics[index]],
                                  style: TextStyle(fontSize: 23 , fontWeight: FontWeight.w500),


                                ),]
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 450,

                    child: imgloading==0? Card(child: Center(child: CircularProgressIndicator())) : PageView.builder(
                      controller: _pageController2,
                      itemCount: paraImg.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2.5,
                          color: Colors.white,
                          surfaceTintColor: Colors.white,

                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                "assets/database/"+paraImg[index]  ,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

          ],
        ),
    ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(width: 250,),



                  //SizedBox(width: 55,),

                  Container(
                    width: 155,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color:  Colors.black ,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(onPressed: (){
                          _currentPage-- ;
                          animate();
                        }, icon: Icon(Icons.arrow_back_outlined,color: Colors.white,)),

                        SizedBox(width: 20,),

                        IconButton(onPressed: (){
                          _currentPage++ ;
                          animate();
                        }, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,))
                      ],
                    ),
                  ),

                  Container(
                    height: 45,
                    width: 195,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(35),
                      color:Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 8,),
                        Icon(Icons.headphones_outlined,color: Colors.white,),
                        SizedBox(width: 8,),

                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(35),
                            color:Colors.white,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(onPressed: (){
                                fluttertts.stop();
                              }, icon: Icon(Icons.stop_circle_outlined,color:Colors.black ,size: 25,)),

                              IconButton(onPressed: (){
                                speak(data5[topics[_currentPage]]);
                              }, icon: Icon(Icons.play_circle_outline_rounded,color:Colors.black,size: 25)),

                              IconButton(onPressed: (){
                                fluttertts.pause();

                              }, icon: Icon(Icons.pause_circle_outline,color:Colors.black ,size: 25)),


                            ],

                          ),
                        ),

                      ],
                    ),
                  ),

                //   ElevatedButton(onPressed: (){
                //   _currentPage++ ;
                //     _currentPage==topics.length ? _currentPage=0 : _currentPage ;
                //   _pageController.animateToPage(
                //     _currentPage,
                //     duration: Duration(milliseconds: 250),
                //     curve: Curves.easeInOut,
                //   );
                //   _pageController2.animateToPage(
                //     _currentPage,
                //     duration: Duration(milliseconds: 250),
                //     curve: Curves.easeInOut,
                //   );
                // }, child: Text("Next")),

                  //SizedBox(width: 45,),


                  ElevatedButton(onPressed: () {
                    showDialog(context: context, builder: (context){
                      return Dialog(

                        child:  Container(
                            height: 500,
                            width: 1000,

                            child: Summary(para : data5[topics[_currentPage]])),
                      );

                    },
                    );
                  } , child: Text("Summarise" )),

                  // SizedBox(width: 400,),

              ],

    ),
            ),

            SingleChildScrollView(
              child: Card(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    height: 150,
                    width: 1200,
                    decoration: BoxDecoration(
                      //color: Color.fromRGBO(246, 184, 255, 0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(


                      children: [
                        SingleChildScrollView(
                          child: Text("Translations :",style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        output=='Loading' ? Center(child: CircularProgressIndicator()) :Text(output as String,style: TextStyle(
                          fontSize: 20,

                        ),),
                      ],
                    ),
                    ),
                ),
              ),
            ),




    ],
        ),
      ),
    );
  }


}

