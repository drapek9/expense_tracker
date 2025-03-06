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
                    showCategoryList(context, categoryOptions, setCategoryNum);
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

void showCategoryList(context, optionsList, setFunction){

  showModalBottomSheet(
    enableDrag: false,
    context: context,
    builder: (context){
      return SizedBox(
        height: 300,
        width: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children:[ ScrollSnapList(
            onItemFocus: (index){
            },
            itemSize: 80,
            itemBuilder: (context, index){
              int theValue = optionsList.keys.toList()[index];
              return SizedBox(
                height: 80,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: const Color.fromARGB(0, 255, 255, 255)
                  ),
                  onPressed: (){
                    setFunction(theValue);
                  },
                  child: Text(
                  optionsList[theValue],
                  style: TextStyle(
                    color: Colors.black
                  ),
                )
                ,)
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
        )
      );
    });
}

// https://www.geeksforgeeks.org/flutter-scroll-snap-list/