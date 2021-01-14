import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resolution/src/commons/constants/app_colors.dart';
import 'package:resolution/src/commons/constants/routes_constant.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/tasks/models/task.dart';
import 'package:resolution/src/resolutions/blocs/resolution/resolution_bloc.dart';

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
  ResolutionBloc _resolutionBloc;
  Resolution _updatedResolution = Resolution();
  @override
  void initState() {
    _resolutionBloc = BlocProvider.of<ResolutionBloc>(context);
    _updatedResolution = widget.resolution;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("resolution" + widget.resolution.toJson().toString());
    return BlocBuilder<ResolutionBloc, ResolutionState>(
        buildWhen: (previous, current) => current is ResolutionUpdated,
        builder: (context, state) {
          if (state is ResolutionUpdated) {
            _updatedResolution = state.resolution;
          }
          return InkWell(
            onTap: () => {Navigator.pushNamed(context, Routes.tasks)},
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
                                widget.resolution.year,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor),
                              ),
                            ],
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
                          Text(
                            widget.resolution.tasks.length.toString() +
                                " tasks",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark),
                          ),
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
            ),
          );
        });
  }
}
