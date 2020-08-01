import 'package:Smsvis/widgets/chatmessag.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dialogflow/dialogflow_v2.dart';
// import 'package:flutter_dialogflow/utils/language.dart';
// import 'package:flutter_dialogflow/v2/auth_google.dart';
// import 'package:flutter_dialogflow/v2/dialogflow_v2.dart';

class HelpMe extends StatefulWidget {
  HelpMe({Key key}) : super(key: key);

  @override
  _HelpMeState createState() => _HelpMeState();
}

class _HelpMeState extends State<HelpMe> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  void response(query) async {
    _textController.clear();
    print(query);
    // AuthGoogle authGoogle =
    //     await AuthGoogle(fileJson: "assets/credentialsDialogFlow.json").build();
    // Dialogflow dialogflow =
    //     Dialogflow(authGoogle: authGoogle, language: Language.english);
    // print(dialogflow);
    // // AIResponse r = await dialogflow.detectIntent(query);
    // AIResponse response = await dialogflow.detectIntent(query);
    // print(response);
    // print("hello122");
    // print(response.queryResult);
    // print("hello");
    // ChatMessage message = new ChatMessage(
    //   text: response.getMessage() ??
    //       new CardDialogflow(response.getListMessage()[0]).title,
    //   name: "Bot",
    //   type: false,
    // );
    // setState(() {
    //   _messages.insert(0, message);
    // });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      name: "You",
      type: true,
    );
    int len = _messages.length;
    print(len);
    setState(() {
      _messages.insert(len, message);
    });
    response(text);
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Ask Me Anything"),
        // ),
        body: new Column(
      children: <Widget>[
        new Flexible(
            child: ListView.builder(
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        new Divider(
          height: 1.0,
        ),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ],
    ));
  }
}
