import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int? theCategory;
  Map<int, String> categoryOptions = {1: "Jídlo a nápoje",2: "Doprava",3: "Zábava",4: "Zdraví a péče",5: "Oblečení a obuv",6: "Cestování a dovolená",7: "Účty a domácnost"};

  void setCategoryNum(theValue){
    setState(() {
      theCategory = theValue;
    });
  }

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
                  onPressed: (){
                    showCategoryList(context, categoryOptions, setCategoryNum, theCategory);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white
                  ),
                  child: Text(
                    theCategory != null ? categoryOptions[theCategory]! : "Category",
                    style: TextStyle(
                      color: theCategory != null ? Colors.black : const Color.fromARGB(255, 150, 150, 150),
                    ),
                    )),
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

void showCategoryList(context, optionsList, setFunction, currentValue){
  int finalValueIndex = currentValue != null ? optionsList.keys.toList().indexOf(currentValue) : 0;
  int? finalValue = optionsList.keys.toList()[finalValueIndex];
  showModalBottomSheet(
    enableDrag: false,
    context: context,
    builder: (context){
      return SizedBox(
        height: 350,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children:[
                  ScrollSnapList(
                    initialIndex: finalValueIndex.toDouble(),
                  onItemFocus: (index){
                    finalValue = optionsList.keys.toList()[index];
                  },
                  itemSize: 80,
                  itemBuilder: (context, index){
                    return SizedBox(
                      height: 80,
                      child: Center(
                        child: Text(
                          optionsList[optionsList.keys.toList()[index]],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),),
                      )
                    );
                  },
                  itemCount: optionsList.keys.length,
                  scrollDirection: Axis.vertical,
                  ),
                SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Container(
                    color: const Color.fromARGB(34, 0, 0, 0),
                  ),
                )
                ]
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      overlayColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero)
                      )
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black
                      ),
                      )),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: (){
                      setFunction(finalValue);
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      overlayColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero)
                      )
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.black
                      ),
                      )),
                ),
              ],
            )
          ],
        )
      );
    });
}

// https://www.geeksforgeeks.org/flutter-scroll-snap-list/