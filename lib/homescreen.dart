//import 'dart:js';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:sense_ai/file.dart';
import 'package:sense_ai/lesson.dart';
import 'package:sense_ai/quizz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'doubt.dart';
import 'evaluate.dart';
import 'main.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<String> imageUrls = [
  'assets/biod-171-essential-lab-microbiology.jpg',
  'assets/shutterstock_1496330648.webp',
  'assets/shutterstock_1127223938_(1).webp',
  'assets/microbes-and-viruses-exploring-the-unseen-world-of-science-generative-ai-photo.jpg'
];

List<String> imageUrls2 = [
  'assets/abt4.png',
  'assets/abt5.png'
];



class _HomePageState extends State<HomePage> {
  @override
  void initState() {

    flessons ;
    if (flessons.length < 1){
      GetData();

    }
    super.initState();
  }
  @override

  var response;
  var data;
  var data5;
  var loading = 1 ;

  Future<void> GetData() async {
    response = await rootBundle.loadString('assets/Zoo-dataset2.json');
    data = await json.decode(response);
    data5 = data['Microbes in Human Welfare'];
    List topics = [];
    for (final i in data5.keys) {

      topics.add(i);
    }
    setState(() {
      flessons.add(data5);
      fTopics.add(topics) ;
      loading=1 ;
    });
  }

  Widget build(BuildContext context) {

    return  Scaffold(
      drawer: Navigation(),
      appBar: NavBar(context) ,
      // AppBar(
      //   title: Text("HOME"),
      //   actions: [
      //     IconButton(onPressed: () {
      //       setState(() {
      //         flessons;
      //       });
      //     }, icon: Icon(Icons.refresh_outlined)),
      //     SizedBox(width: 80,)
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 155,right: 155,bottom: 55,top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackdropFilter(

                  filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      //image: AssetImage('assets/bio2.jpg'),
                    ),
                    //padding: const EdgeInsets.all(30),
                    //color: Color.fromRGBO(14, 0, 95, 1),
                    height: 350,
                    width: 1800,
                    child: PageView.builder(
                      //physics: ,
                        itemCount: imageUrls2.length,
                        itemBuilder: (context,index){
                      return Card(
                        child: Image.asset(imageUrls2[index]),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 50,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Lessons ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),

                    ElevatedButton(onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) {
                          return ParagraphsAndImageViewer(i: cont,);
                        }),);
                    }, child: Text("Continue")) ,
                  ],
                ) ,

                SizedBox(height: 20,),



                Container(
                    child: loading==0? CircularProgressIndicator() :  _buildLess(),
                    width: 1800,
                  height: 500,
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Navigation extends StatelessWidget {
  const Navigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(

      indicatorShape: BeveledRectangleBorder(
          borderRadius: BorderRadius.zero),
      children: [
        SizedBox(height:50 ,),
      //toPage(title:"Teach",page: ParagraphsAndImageViewer(),),
      toPage(title:"Upload file",page: FilePick(),),
      // toPage(title:"Quizz",page: QuizScreen(),),
      toPage(title:"Evaluate",page: ChatScreen(),),
      toPage(title:"Doubt",page: Home(),),

      ],
    );
  }
}

class toPage extends StatelessWidget {
  final String title;
  final dynamic page ;
  const toPage({
    required this.title,
    required this.page ,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.play_circle_outline_outlined),
      title: Text(title),
      onTap: (){
        Navigator.of(context).push(CupertinoPageRoute(builder: (context){
          return page;

        },),
        );
      },
      hoverColor: Colors.white70,
      splashColor: Colors.white10,
    );
  }
}

Widget _buildLess() {
  return Container(
    width: 1000,
    height: 500,
    child: ListView.builder(
      //maxCrossAxisExtent: 350,
      //padding: const EdgeInsets.all(4),
      scrollDirection: Axis.horizontal,
      itemCount: flessons.length,
      //mainAxisSpacing: 0,
      //crossAxisSpacing: 0,
      itemBuilder : (context,index){
        return LessItem(i: index);
  },
  ),);
 }




class LessItem extends StatelessWidget {
  final int i ;
  const LessItem({super.key,required this.i});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25)
      ),
      child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: 250,
                  height: 150,
                  child: GestureDetector(child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(imageUrls[i],fit: BoxFit.cover,)),onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return LessonsView(i: i) ;
                    }),);
                  },)),
            ),
            Text('Lesson ${i+1}',style: TextStyle(fontWeight: FontWeight.bold),),


          ]
      ),
    );
  }
}


