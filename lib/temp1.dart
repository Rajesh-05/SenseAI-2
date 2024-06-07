import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}



class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String url = '';
  var data;
  String output = ' ';

  TextEditingController _user1Controller = TextEditingController();
  TextEditingController _user2Controller = TextEditingController();
  List<ChatMessage> _messages = [];

  void _handleSubmitted(String text, String user) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(text, user));
        url = 'http://127.0.0.1:5000/api?text=' + text.toString();

      });
      if (user == "User 1") {
        _user1Controller.clear();
      } else {
        _user2Controller.clear();
      }
      showdata();
    }
  }

  showdata() async {

    data = await fetchdata(url);
    var decoded = jsonDecode(data);
    setState(() {
      output = decoded['output'];
      _messages.add(ChatMessage(output, 'Zen'));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Evalution Time !')),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: 1200,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _messages[index];
                  },
                ),
              ),
              //_buildInputFields("User 1", _user1Controller),
              _buildInputFields("User", _user2Controller),
              SizedBox(height: 50,)
            ],
          ),
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
                  borderRadius: BorderRadius.circular(35)
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
    final messageColor = isUser1 ? Colors.blue : Colors.green;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser1 ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          // if (!isUser1) {
          //   //Spacer(),
            isUser1 ?  CircleAvatar(child: Text('Z')) : Text("") ,
          SizedBox(width: 8.0),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: messageColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
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
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 5.0,
                     // width: 100.5 + text.length,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(width: 8.0),
          !isUser1 ?  CircleAvatar(child: Text(user[0])) : Text("") ,


        ],
      ),
    );
  }
}
