

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/task_model.dart';
import '../screens/theme.dart';
import '../utils/app_layout.dart';

class TaskTile extends StatelessWidget {
  final TaskModel? task;
  TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: AppLayout.getHeight(20)),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: AppLayout.getHeight(12)),
      child: Container(
        padding: EdgeInsets.all(AppLayout.getHeight(16)),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppLayout.getHeight(16)),
          color: _getBGClr(task?.color??0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title??"",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: AppLayout.getHeight(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: AppLayout.getHeight(12),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: AppLayout.getHeight(18),
                    ),
                    SizedBox(width: AppLayout.GetWidget(4)),
                    Text(
                      "${task!.startTime} - ${task!.endTime}",
                      style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: AppLayout.getHeight(13), color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppLayout.getHeight(12)),
                Text(
                  task?.note??"",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: AppLayout.getHeight(15), color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppLayout.GetWidget(10)),
            height: AppLayout.getHeight(60),
            width: AppLayout.GetWidget(0.5),
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task!.isCompleted == 1 ? "COMPLETED" : "TODO",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: AppLayout.getHeight(10),
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }
}