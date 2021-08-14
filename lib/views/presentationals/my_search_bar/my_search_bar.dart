import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({Key? key, required this.onTextChanged}) : super(key: key);
  final ValueChanged<String> onTextChanged;
  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  TextEditingController textController = TextEditingController();
  late ThemeData searchBartheme;
  @override
  Widget build(BuildContext context) {
    searchBartheme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 50,
      padding: EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          color: searchBartheme.cardColor,
          child: TextField(
            controller: textController,
            onChanged: (text) {
              widget.onTextChanged(textController.text);
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: searchBartheme.hintColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
      ),
    );
  }
}
