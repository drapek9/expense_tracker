import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                TextInput(
                  theHintText: "Name",
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text("Category")),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red
                  ),
                  onPressed: (){},
                  icon: Icon(Icons.calendar_month),
                  label: Text("Date")),
                SizedBox(
                  width: 200,
                  child: TextInput(
                    theHintText: "Prize",
                  )
                  ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text(
                    "Save"
                  ))
              ],
            ),
          ))),
    );
  }
}

class TextInput extends StatelessWidget {
  // const TextInput({super.key});
  String? theHintText;

  TextInput({required this.theHintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
          decoration: InputDecoration(
            hintText: theHintText,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: Colors.white
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: Colors.white
              )
            ),
          ),
        );
  }
}