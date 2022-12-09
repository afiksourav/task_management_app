import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:task_management_app/screens/theme.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../services/notification_services.dart';
import '../services/theme_services.dart';
import '../utils/app_layout.dart';
import '../widgets/bottom_sheet_button.dart';
import '../widgets/button_widget.dart';
import '../widgets/task_tile.dart';
import 'add_task_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
DateTime _selectedDate= DateTime.now();
final _taskController = Get.put(TaskController());
var notifyHelper;

@override
  void initState() {
  notifyHelper= NotifyHelper();
  notifyHelper.initializeNotification();
  _taskController.getTasks();
  super.initState();   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
           _addTaskBar(),
           _addDateBar(),
              SizedBox(
            height: AppLayout.getHeight(10),
          ),
           _showTasks(),
        ],
      ),
    );
    
  } 

  //show task
  _showTasks(){
    return Expanded(
      child:Obx((){
        print(_taskController.taskList);
        return ListView.builder(
          itemCount: _taskController.taskList.length, 
        
          itemBuilder:(_,index) {
            print("length");
            print(_taskController.taskList.length);
            TaskModel task = _taskController.taskList[index];
            if(task.repeat=='Daily'){
            
            DateTime date = DateFormat.jm().parse(task.startTime.toString());
           var myTime = DateFormat("HH:mm").format(date);
           notifyHelper.scheduledNotification(
            int.parse(myTime.toString().split(":")[0]),
            int.parse(myTime.toString().split(":")[1]),
            task
           );
   return AnimationConfiguration.staggeredList(
    
    position: index, 
    child: SlideAnimation(
      child: FadeInAnimation(
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
              _showBotttomSheet(context, task);
              },
              child: TaskTile(task),
            )
            
          ],
        ),
      ),
    ));
            }
        if(task.date==DateFormat.yMd().format(_selectedDate)){
                  
   return AnimationConfiguration.staggeredList(
    
    position: index, 
    child: SlideAnimation(
      child: FadeInAnimation(
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
              _showBotttomSheet(context, task);
              },
              child: TaskTile(task),
            )
            
          ],
        ),
      ),
    ));
        } else {
          return Container();
        }
          
          } 
          
          );
      }) ,
    );
  }

  _showBotttomSheet(BuildContext context, TaskModel task){
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: AppLayout.getHeight(4)),
        height: task.isCompleted==1?
        MediaQuery.of(context).size.height*0.30:
         MediaQuery.of(context).size.height*0.38,
         color: Get.isDarkMode?darkGreyClr:Colors.white,
         child: Column(
          children: [
            Container(
              height: AppLayout.getHeight(6),
              width: AppLayout.GetWidget(120),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppLayout.getHeight(10)),
                color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
              ),
            ),
            Spacer(),
              task.isCompleted==1
           ?Container():
         BottomSheetButton(
          label: "Task Completed",
           onTap: (){
            _taskController.markTaskCompleted(task.id!);
         
            Get.back();
           }, 
           clr: primaryClr,
           context:context
           ),
           BottomSheetButton(
          label: "Delete Task",
           onTap: (){
            _taskController.delete(task);
           
            Get.back();
           }, 
           clr: Colors.red[300]!,
           context:context
           ),
           SizedBox(height: AppLayout.getHeight(20),),
              BottomSheetButton(
          label: "Close",
           onTap: (){
            Get.back();
           }, 
           clr: Colors.red[300]!,
           isClose: true,
           context:context
           ),
           SizedBox(height: AppLayout.getHeight(10),),
            
          ],
         ),
 
    )
    );
  }

//add date  section
  _addDateBar(){
    return Container(
            margin: EdgeInsets.only(top: AppLayout.getHeight(20),left: AppLayout.GetWidget(20)),
            //DatePicker package
            child: DatePicker(
              DateTime.now(),
              height: AppLayout.getHeight(100),
              width: AppLayout.GetWidget(80),
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
            //date style
            dateTextStyle:GoogleFonts.lato(
            textStyle: TextStyle(
             fontSize: AppLayout.getHeight(20),
             fontWeight: FontWeight.w600,
             color: Colors.grey
              ),
               ),
               //day style
            dayTextStyle:GoogleFonts.lato(
            textStyle: TextStyle(
             fontSize: AppLayout.getHeight(16),
             fontWeight: FontWeight.w600,
             color: Colors.grey
              ),
               ),
           //month style
            monthTextStyle:GoogleFonts.lato(
            textStyle: TextStyle(
             fontSize: AppLayout.getHeight(14),
             fontWeight: FontWeight.w600,
             color: Colors.grey
              ),
               ),
               onDateChange: (date){
               setState(() {
                  _selectedDate =date;
               });
               },
            ),
           );
  }

_addTaskBar(){
  return  Container(
             margin:  EdgeInsets.only(left: AppLayout.GetWidget(20),right: AppLayout.GetWidget(20),top: AppLayout.getHeight(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMd().format(DateTime.now()),
                    style:subHeadingStyle ,
                    ),
                    Text("Today",style: HeadingStyle,)
                  ],
                ),
              ),
              MyBottom(label: "+ Add Task", onTap: ()async{
                
              await  Get.to(()=>const AddTaskPage());
              _taskController.getTasks();
              }
             )
            
            ],
          ),
        );
}


//appBar
  _appBar(){
      return AppBar(
        elevation: 0, //app bar shawo 0
        backgroundColor: context.theme.backgroundColor, //theme file use the function ThemeData then use backgroundColor
      leading: GestureDetector(

        onTap: (){
         ThemeServices().switchTheme();
         notifyHelper.displayNotifications(
          title:"Theme Changed",
          body:Get.isDarkMode ? "Activated Light Theme":"Activated Dark Theme"
          );
          //notifyHelper.scheduledNotification();
        },

        child:  Icon(Get.isDarkMode ?Icons.wb_sunny_outlined:Icons.nightlight_round,
        size: 20,
        color: Get.isDarkMode ? Colors.white : Colors.black
        ),
      ),
      actions:  [
         CircleAvatar(
       backgroundImage: AssetImage(
        "images/man.png"
       ),
         ),
        SizedBox(width: 20,)
      ],
      );
    }
}