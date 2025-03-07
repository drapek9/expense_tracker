import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int? theCategory;
  DateTime theDate = DateTime.now();


  Map<int, String> categoryOptions = {1: "Jídlo a nápoje",2: "Doprava",3: "Zábava",4: "Zdraví a péče",5: "Oblečení a obuv",6: "Cestování a dovolená",7: "Účty a domácnost"};

  void setCategoryNum(theValue){
    setState(() {
      theCategory = theValue;
    });
  }

  void setDateTime(newDateTime){
    setState(() {
      theDate = newDateTime;
    });
  }

  void saveExpense (theName, theType, theDate, thePrize){

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white
                  ),
                  onPressed: (){
                    showChooserDate(context, theDate, setDateTime);
                  },
                  icon: Icon(
                    Icons.calendar_month,
                    color: Colors.black,
                    ),
                  label: Text(
                    DateFormat("dd.MM.yyyy").format(theDate),
                    style: TextStyle(
                      color: Colors.black
                    ),
                    )),

                  SizedBox(
                    width: 15,
                  ),

                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white
                    ),
                    onPressed: (){
                      showChooserTime(context, setDateTime, theDate);
                    },
                    icon: Icon(Icons.hourglass_bottom_sharp),
                    label: Text(
                      DateFormat("HH:mm").format(theDate)
                      ))
                  ],
                ),
                
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

void showChooserDate (context, curDate, setFunction){
  Future selectDate(BuildContext context) async => showDatePicker(
    context: context,
    firstDate: DateTime(2000, 01, 01),
    lastDate: DateTime.now(),
    initialDate: curDate ?? DateTime.now()
    ).then((dateValue) {
      if (dateValue != null){
        DateTime newDate = DateTime(dateValue.year, dateValue.month, dateValue.day, curDate.hour, curDate.minute);
        if (newDate.isAfter(DateTime.now())){
            newDate = DateTime.now();
          }
        setFunction(newDate);
      }
    });
  selectDate(context);

  
}

void showChooserTime (context, setFunction, curDateTime){
  Future selectTime(BuildContext context) async => showTimePicker(context: context,
    initialTime: TimeOfDay(hour: curDateTime.hour, minute: curDateTime.minute)
    ).then((theTime){
      if (theTime != null){
        try {
          DateTime newDateTime = DateTime(curDateTime.year, curDateTime.month, curDateTime.day, theTime.hour, theTime.minute);
          if (newDateTime.isAfter(DateTime.now())){
            newDateTime = DateTime.now();
          }
          setFunction(newDateTime);
        } catch (e){
          print(e);
        }
        
      }
    
      
    });
  
  selectTime(context);
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