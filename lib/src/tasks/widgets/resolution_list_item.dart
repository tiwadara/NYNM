import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resolution/src/commons/constants/app_colors.dart';
import 'package:resolution/src/tasks/blocs/todo/to_do_bloc.dart';
import 'package:resolution/src/tasks/models/task.dart';

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
  final Task resolution;
  final int position;
  final IconData icon;

  @override
  _ResolutionListItemState createState() => _ResolutionListItemState();
}

class _ResolutionListItemState extends State<ResolutionListItem> {
  ToDoBloc _resolutionBloc;
  Task _updatedResolution = Task();
  @override
  void initState() {
    _resolutionBloc = BlocProvider.of<ToDoBloc>(context);
    _updatedResolution = widget.resolution;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("resolution" + widget.resolution.toJson().toString());
    return BlocBuilder<ToDoBloc, ToDoState>(
        buildWhen: (previous, current) => current is ResolutionUpdated,
        builder: (context, state) {
          if (state is ResolutionUpdated) {
            _updatedResolution = state.resolution;
          }
          return Row(
            children: [
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  onChanged: (bool value) {
                    _updatedResolution.done = value;
                    _resolutionBloc.add(UpdateResolutionStatus(
                        widget.resolution, widget.position));
                  },
                  value: widget.resolution.done,
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
                                widget.resolution.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor),
                              ),
                              Text(widget.resolution.description),
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
          );
        });
  }
}
