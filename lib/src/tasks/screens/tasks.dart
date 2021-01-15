import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resolution/src/commons/constants/app_colors.dart';
import 'package:resolution/src/commons/constants/app_constants.dart';
import 'package:resolution/src/commons/util/bottom_sheet.dart';
import 'package:resolution/src/commons/widgets/app_header.dart';
import 'package:resolution/src/commons/widgets/app_widget_transition.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/tasks/blocs/task/task_bloc.dart';
import 'package:resolution/src/tasks/widgets/new_task_bottom_sheet.dart';
import 'package:resolution/src/tasks/widgets/task_list_item.dart';

class Tasks extends StatefulWidget {
  static const String routeName = '/tasks';
  Tasks(this.resolution);
  final Resolution resolution;

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  TaskBloc _taskBloc;
  List<dynamic> _tasks = [];

  @override
  void initState() {
    _taskBloc = BlocProvider.of<TaskBloc>(context);
    _taskBloc.add(GetTasks(widget.resolution.year));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
          onPressed: () {
            displayBottomSheet(context, NewTaskBottomSheet(widget.resolution));
          },
        ),
        backgroundColor: AppColors.windowColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Header(
              title: "New Year, New Me",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      BlocBuilder<TaskBloc, TaskState>(
                          buildWhen: (previous, current) =>
                              current is TaskListReceived ||
                              current is TaskSaved,
                          builder: (context, state) {
                            if (state is TaskSaved) {
                              _taskBloc.add(GetTasks(widget.resolution.year));
                            }
                            if (state is TaskListReceived) {
                              _tasks = state.tasks.toList();
                              if (_tasks.isEmpty) {
                                return buildEmptyEventContainer(context);
                              } else {
                                return ShowUp(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _tasks.length,
                                    itemBuilder: (context, position) {
                                      return ResolutionListItem(
                                        icon: Icons.add_circle_outline,
                                        task: _tasks[position],
                                        year: widget.resolution.year,
                                        color: Colors.white,
                                        position: position,
                                        onPressed: () {},
                                      );
                                    },
                                  ),
                                );
                              }
                            }
                            return buildEmptyEventContainer(context);
                          }),
                      SizedBox(
                        height: 100.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Container buildEmptyEventContainer(BuildContext context) {
    return Container(
      height: 200.h,
      child: Column(
        children: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: AppColors.primaryDark,
            ),
            onPressed: () {
              displayBottomSheet(
                  context, NewTaskBottomSheet(widget.resolution));
            },
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "No tasks yet :-( , create one",
            textAlign: TextAlign.center,
            style: TextStyle(),
          )),
        ],
      ),
    );
  }
}
