
import '../controllers/task_controller.dart';
import '../models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/app_layout.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_field_widget.dart';
import 'theme.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
final TaskController _taskController =Get.put(TaskController());

final TextEditingController _titleController = TextEditingController();
final TextEditingController _noteController = TextEditingController();

DateTime _selectedDate = DateTime.now();
 String _endTime = "9:30";
 String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

 int _selectedRemind =5;
 List<int> remindList =[
  5,
  10,
  15,
  20
 ];

 String _selectedRepeat ="None";
 List<String>RepeatList =[
  "None",
  "Daily",
  "Weekly",
  "Monthly"
 ];

 int _selectedColor =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar:_appBar(context),
      body: Container(
        padding: EdgeInsets.only(left: AppLayout.GetWidget(20), right: AppLayout.GetWidget(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: HeadingStyle,
              ),
             MyInputField(title: "Title", hint: "  Enter Your Title  ",controller: _titleController,),
             MyInputField(title: "Note", hint: "  Enter Your Note  ",controller: _noteController,),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon: const Icon( Icons.calendar_today_outlined,
                color: Colors.grey,),
                onPressed: (){
                   _getDateFormUser()  ;
                },
               ),
              ),
              Row(
                children: [
                  Expanded(
                    child:MyInputField(
                      title: "Start Date",
                      hint:_startTime ,
                      widget: IconButton(
                        onPressed: () {
                             _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                          ),
                      ),
                    ) 
                ),
                SizedBox(width: AppLayout.GetWidget(12),),
                 Expanded(
                    child:MyInputField(
                      title: "End Date",
                      hint: _endTime ,
                      widget: IconButton(
                        onPressed: (){
                     _getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                          ),
                      ),
                    ) 
                )
                ],
              ),
              MyInputField(title: "Remind", hint: "$_selectedRemind Minutes early",
              widget: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                iconSize: 32,
                elevation: 4,
                style: subTitleStyle,
                underline: Container(height: 0,),
                onChanged: (String ? newValue){
                  setState(() {
                    _selectedRemind =int.parse(newValue!);
                  });
                },
                items: remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }
                ).toList() ,
              ),
              ),
              MyInputField(title: "Repeat", hint: "$_selectedRepeat",
              widget: DropdownButton(
               icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                iconSize: 32,
                elevation: 4,
                style: subTitleStyle,
                underline: Container(height: 0,),
                onChanged: (String ? newValue){
                  setState(() {
                    _selectedRepeat =newValue!;
                  });
                  
                },
                items: RepeatList.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style:TextStyle(color: Colors.grey)  ,),
                  );
                }
                ).toList()
              ),
              ),
              SizedBox(height: AppLayout.getHeight(18),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyBottom(
                  label: "Create Task",
                   onTap:()=>_validateData()
                  )
                ],
              ),
              SizedBox(height:AppLayout.getHeight(30) ,)
            ],
          ),
        ),

      ),
    );

    
  }

  _validateData(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
      //add to database
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty){
      Get.snackbar("Required", "All Fields are required !",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      icon: Icon(Icons.warning_amber_rounded)
      );
    }
  }

  _addTaskToDb()async{
int value=  await _taskController.addTask(
    task:TaskModel(
    note: _noteController.text,
    title: _titleController.text,
    date: DateFormat.yMd().format(_selectedDate),
    startTime: _startTime,
    endTime: _endTime,
    remind: _selectedRemind,
    repeat: _selectedRepeat,
    color: _selectedColor,
    isCompleted: 0
   )
   );
   print("my id is "+ "$value");
  }

  _colorPallete(){
    return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color",
                      style: titleStyle,
                      ),
                      SizedBox(height: AppLayout.getHeight(8),),
                      Wrap(
                 
                        children:List<Widget>.generate(
                          3, (int index) {
                        return GestureDetector(
                          onTap: (){
                          setState(() {
                             _selectedColor=index;
                          });
                          },
                          child: Padding(
                            padding:  EdgeInsets.only(right: AppLayout.getHeight(8.0)),
                            child: CircleAvatar(
                                 radius: AppLayout.getHeight(14),
                                 backgroundColor:index==0?primaryClr:index==1?pinkClr:yellowClr,
                               
                               child: _selectedColor==index ? 
                               Icon(Icons.done,
                               color: Colors.white,
                               size: AppLayout.getHeight(16), 
                               ):Container()
                            ),
                          ),
                        );
                          }
                           )
                      )
                    ],
                  );
  }

   _appBar(BuildContext context){
      return AppBar(
        elevation: 0, //app bar shawo 0
        backgroundColor: context.theme.backgroundColor, //theme come to the getx packages then use the function ThemeData then use backgroundColor
      leading: GestureDetector(
        
        onTap: (){
       Get.back();
        },

        child:  Icon(Icons.arrow_back_ios,
        size: 20,
        color: Get.isDarkMode ? Colors.white : Colors.black
        ),
      
      ),
      actions:  const [
         CircleAvatar(
       backgroundImage: AssetImage(
        "images/man.png"
       ),
         ),
        SizedBox(width: 20,)
      ],
      );
    }

  _getDateFormUser() async{
    DateTime ? _pickerDate= await showDatePicker(
      context: context,
       initialDate: DateTime.now(), 
       firstDate: DateTime(2015), 
       lastDate: DateTime(2222)
       );

       if(_pickerDate!=null){
     setState(() {
       _selectedDate = _pickerDate;  //using setState pick date are changed otherwise not change
     });
       } else{
        print("it's null or something is wrong");
       }
  }

_getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay ?pickedTime = await _showTimePicker();
   // print( pickedTime!.format(context));
    String formattedTime = pickedTime?.format(context)??_startTime;
    if(isStartTime == true) {
      setState(() {
        _startTime = formattedTime;
      });
    }else if(isStartTime == false) {
      setState(() {
        _endTime = formattedTime;
      });
    }else if(pickedTime == null) {
      debugPrint('Time Cancelled');}
  }

  _showTimePicker() {
    return showTimePicker(
      
      context: context,
         // initialTime: TimeOfDay.now().add(),
                        initialEntryMode: TimePickerEntryMode.dial,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(':')[0]),
            minute: int.parse(_startTime.split(':')[1].split(' ')[0])
            )
        
    
            );
  }
}

