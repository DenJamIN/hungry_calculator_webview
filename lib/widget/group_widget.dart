import 'package:flutter/material.dart';

class GroupWidget extends StatefulWidget {
  List<String> groups;

  GroupWidget({required this.groups});
  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          field(),
          table(),
        ],
      );
  }

  Widget field() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Введите текст',
              ),
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18.0,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          InkWell(
            onTap: () {
              final name = textController.text.trim();
              if(name.length < 2){
                setState(() {
                  widget.groups.add(textController.text);
                  textController.clear();
                });
              }
            },
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget table() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.groups.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              tileColor: const Color.fromRGBO(46, 46, 229, 100), // Фон ListTile
              title: Text(
                widget.groups[index],
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
