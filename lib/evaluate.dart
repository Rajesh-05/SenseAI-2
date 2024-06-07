import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sense_ai/main.dart';

fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}



class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _controller = ScrollController();
  String url = '';
  var data;
  String output = ' ';

  @override
  void initState() {
    GetData();
    super.initState();
    _messages.add(ChatMessage("🤖 Welcome to SenseAI - Your Personal Study Assistant! 📚 Are you a student looking to put your knowledge to the test and deepen your understanding of various subjects? You're in the right place! SenseAI isn't just here to answer your questions; it's here to challenge you with thought-provoking questions and seek your answers.", 'Zen'));
    WidgetsBinding.instance.addPostFrameCallback((_) => _jumpToLast());
  }

  void _jumpToLast() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }


  TextEditingController _userController = TextEditingController();
  List<ChatMessage> _messages = [];

  var response;

  var data5;
  List<String> topics = [];
  var loading=0 ;

  Future<void> GetData() async {
    response = await rootBundle.loadString('assets/Zoo-dataset.json');
    data = await json.decode(response);
    data5 = data['Microbes in Human Welfare'];

    for (final i in data5.keys) {
      topics.add(i);
    }
    setState(() {
      topics = topics;
      loading=1 ;
    });
  }

  dynamic jQues ;
  ques (url) async {

    jQues = await fetchdata(url);
    var decoded =  jsonDecode(jQues);
    late String question =  decoded['q'];
    print(question) ;
    setState(() {
      _messages.add(ChatMessage(question, 'Zen'));

    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });

  }

  void _handleSubmitted(String text, String user) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(text, user));
        //url = 'http://127.0.0.1:5000/api?text=' + text.toString();

      });
      if (text.toLowerCase()=='start'){
        ques('http://127.0.0.1:5000/ask');

      } else{

        ques('http://127.0.0.1:5000/eval?text=' + text.toString());

        Future.delayed(Duration(seconds: 15), () {
          ques('http://127.0.0.1:5000/ask');
        });


      }

        _userController.clear();

      _userController.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      });

    }
  }




  String? valueChoose ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(context),
      // AppBar(title: Text('Evalution Time !'),
      // actions: [
      //
      //   ],
      // ),
      body: Container(
        color: Colors.white54,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 25,) ,
            Container(
              height: 50,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                border:Border.all(width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: loading==0? null : DropdownButton(

                focusColor: Colors.white,
                hint: Text("Select a Topic "),
                icon: Icon(Icons.arrow_downward_rounded,color: Colors.black,),
                value: valueChoose,
                onChanged: (newValue){
                  setState(() {
                    url = 'http://127.0.0.1:5000/start?text=' + newValue.toString();
                    valueChoose=newValue;
                    var topic = fetchdata(url);
                    _messages.add(ChatMessage("Type START to start Evalution :) ", 'Zen'));

                  });
                },
                items: topics.map((valueItem){
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ) ,
            Container(
              alignment: Alignment.center,
              child: Container(
                height: 650,
                width: 1000,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        controller: _controller,
                        itemCount: _messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _messages[index];
                        },
                      ),
                    ),
                    //_buildInputFields("User 1", _user1Controller),
                    SizedBox(height: 30,) ,
                    _buildInputFields("User", _userController),
                    SizedBox(height: 30,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputFields(String user, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (text) => _handleSubmitted(text, user),
              decoration: InputDecoration(
                  hintText: 'Enter message...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    
                  )
              ),
            ),
          ),

          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _handleSubmitted(controller.text, user),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String user;

  ChatMessage(this.text, this.user);

  @override
  Widget build(BuildContext context) {
    final isUser1 = user == "Zen";
    final messageAlign = isUser1 ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final messageColor = Colors.white ;
    // Color.fromRGBO(0, 155, 232,0.9) ;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser1 ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          // if (!isUser1) {
          //   //Spacer(),
          isUser1 ?  CircleAvatar(child: Text('Z'),backgroundColor: Colors.black,foregroundColor: Colors.white,) : Text("") ,
          SizedBox(width: 8.0),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,  // Specify the border color
                  width: 1.6,          // Specify the border thickness
                ),

                borderRadius: isUser1 ? BorderRadius.only(topLeft: Radius.zero,topRight: Radius.circular(25),bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25))
                : BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(0),bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),  // If you need the border to be rounded
              ),
              padding: EdgeInsets.all(10.0),
              // decoration: BoxDecoration(
              //   color: messageColor,
              //
              //   // borderRadius: BorderRadius.circular(8.0),
              // ),
              child: SizedBox(
                width: 150.5 + text.length,
                child: Column(
                  crossAxisAlignment: messageAlign,


                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,),
                      ),
                    ),
                    SizedBox(height: 5.0,
                      // width: 100.5 + text.length,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        text.toString(),
                        style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400,fontFamily: "Poppins"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(width: 8.0),
          !isUser1 ?  CircleAvatar(child: Text(user[0]),foregroundColor: Colors.white,backgroundColor: Colors.black,) : Text("") ,


        ],
      ),
    );
  }
}
