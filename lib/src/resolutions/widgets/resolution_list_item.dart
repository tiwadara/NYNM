import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resolution/src/commons/constants/app_colors.dart';
import 'package:resolution/src/commons/constants/routes_constant.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/tasks/blocs/task/task_bloc.dart';

class ResolutionListItem extends StatefulWidget {
  const ResolutionListItem(
      {Key key,
      @required this.icon,
      @required this.color,
      @required this.onPressed,
      @required this.position,
      @required this.resolution})
      : super(key: key);

  final VoidCallback onPressed;
  final Color color;
  final Resolution resolution;
  final int position;
  final IconData icon;

  @override
  _ResolutionListItemState createState() => _ResolutionListItemState();
}

class _ResolutionListItemState extends State<ResolutionListItem> {
  int _taskCount = 0;
  int _completedTaskCount = 0;
  TaskBloc _taskBloc;

  @override
  void initState() {
    _taskBloc = BlocProvider.of<TaskBloc>(context);
    getCount();
    super.initState();
  }

  getCount() {
    _taskBloc.getTaskCount(widget.resolution.year).then((value) {
      setState(() {
        _taskCount = value;
      });
      return null;
    });
    _taskBloc.getCompletedTaskCount(widget.resolution.year).then((value) {
      setState(() {
        _completedTaskCount = value;
      });
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.pushNamed(context, Routes.tasks, arguments: widget.resolution)
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 2),
              padding: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color: AppColors.accentDark,
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.resolution.year.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor),
                        ),
                      ],
                    ),
                    BlocListener<TaskBloc, TaskState>(
                      listenWhen: (previous, current) => current is TaskSaved || current is TaskUpdated,
                      listener: (context, state) {
                        if (state is TaskSaved) {
                        return getCount();
                        } else if (state is TaskUpdated) {
                          return getCount();
                        }
                      },
                      child: Container(),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: 100,
                      child: Text(
                        widget.resolution.motto,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _taskCount.toString() + " tasks",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDark),
                        ),
                        Text(
                         '${ ((_completedTaskCount ?? 0) /(_taskCount ?? 0 )* 100).isNaN ? "0" : ((_completedTaskCount ?? 0) /(_taskCount ?? 0 )* 100).floor().toString()}' + "% done",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDark),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
