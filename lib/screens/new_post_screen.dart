import 'package:flutter/material.dart';

class NewPostRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: (){},
      ),
      body: NewPostScreen(),
    );
  }
}

class NewPostScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewPostScreenState();
  }
}

class NewPostScreenState extends State<NewPostScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.grey,
            height: screenWidth / 1.9,
            width: screenWidth,
          ),
          Container(
            margin: EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                TextField(
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle,
                  controller: titleController,
                  decoration: InputDecoration(hintText: "Title"),
                ),
                TextField(
                  controller: descriptionController,
                  minLines: 6,
                  maxLines: 10,
                  decoration: InputDecoration(hintText: "Description"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
