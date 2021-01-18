import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resolution/src/commons/constants/app_colors.dart';
import 'package:resolution/src/tasks/blocs/task/task_bloc.dart';
import 'package:resolution/src/tasks/models/task.dart';

class ResolutionListItem extends StatefulWidget {
  const ResolutionListItem(
      {Key key,
      @required this.icon,
      @required this.color,
      @required this.onPressed,
      @required this.position,
      @required this.year,
      @required this.task})
      : super(key: key);

  final VoidCallback onPressed;
  final Color color;
  final Task task;
  final int year;
  final int position;
  final IconData icon;

  @override
  _ResolutionListItemState createState() => _ResolutionListItemState();
}

class _ResolutionListItemState extends State<ResolutionListItem> {
  TaskBloc _taskBloc;
  Task _updatedTask = Task();
  bool _value;
  @override
  void initState() {
    _taskBloc = BlocProvider.of<TaskBloc>(context);
    _updatedTask = widget.task;
    _value = widget.task.done;
    super.initState();
  }

  getTask() {
    _taskBloc.getTask(widget.year, widget.position).then((value) {
      setState(() {
        _updatedTask = value;
        print("on task update" + _updatedTask.toJson().toString());
      });
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
        listenWhen: (previous, current) => current is TaskUpdated,
        listener: (context, state) {
          if (state is TaskUpdated) {
            getTask();
          }
        } , child:  Row(
      children: [
        SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            onChanged: (bool value) {
              setState(() {
                _value = value;
              });
              _updatedTask.done = value;
              _taskBloc.add(UpdateTaskStatus(_updatedTask, widget.year, widget.position));
            },
            value: _value,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            padding: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.task.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor),
                        ),
                        Text(widget.task.description),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: widget.position.isEven
                  ? AppColors.borderGrey.withOpacity(0.2)
                  : AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    ));
  }
}
