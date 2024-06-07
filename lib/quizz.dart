import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(backgroundColor:  Color.fromRGBO(251, 246, 239,1),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(55),
          width: double.infinity,
          decoration: const BoxDecoration(
              //image: DecorationImage(image:  AssetImage('assets/back1.jpg') ,fit: BoxFit.cover)
              color: Color.fromRGBO(251, 246, 239,1),
          ),

          child:Column(
            children: [

              // SizedBox(height: 20,),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color.fromRGBO(195, 49, 73,1),

                ),
                //height: 70,
                alignment: Alignment.centerLeft,
                child: Text("Question 1Q",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  color: Color.fromRGBO(247, 237, 222,1),
                ),),
              ),

              SizedBox(height: 80,),
              SizedBox(
                width: 800,
                height: 400,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Option(option: "Red",i: 1,),
                        Option(option: "Blue",i: 2,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Option(option: "Green",i: 3,),
                        Option(option: "Yellow",i: 4,),
                      ],
                    )
                  ],
                ),
              )
            ],
          ) ,
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  final String option ;
  final int i ;
  const Option({
    super.key,
    required this.option,
    required this.i,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){print(i); },
          child: Container(
            height: 120,
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color.fromRGBO(195, 49, 73,1),
              border: Border.all(
                style: BorderStyle.solid,
                width: 5,
                color:Color.fromRGBO(247, 237, 222,1) ,

              )

            ),
            alignment:Alignment.center,

            child:
              Text(option,style: TextStyle(
                color: Color.fromRGBO(247, 237, 222,1),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              ),
          ),
        ),
        Text('Option $i',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        color: Color.fromRGBO(195, 49, 73,1)))
      ],
    );
  }
}
