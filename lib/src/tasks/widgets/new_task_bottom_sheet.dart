import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resolution/src/commons/constants/app_colors.dart';
import 'package:resolution/src/commons/constants/app_constants.dart';
import 'package:resolution/src/commons/constants/app_strings.dart';
import 'package:resolution/src/commons/constants/routes_constant.dart';
import 'package:resolution/src/commons/widgets/app_horizontal_line.dart';
import 'package:resolution/src/commons/widgets/app_snackbar.dart';
import 'package:resolution/src/commons/widgets/app_spinner.dart';
import 'package:resolution/src/commons/widgets/app_text_view.dart';
import 'package:resolution/src/commons/widgets/primary_button.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/tasks/blocs/task/task_bloc.dart';
import 'package:resolution/src/tasks/models/task.dart';

class NewTaskBottomSheet extends StatefulWidget {
  NewTaskBottomSheet(this.resolution);
  final Resolution resolution;

  @override
  _NewTaskBottomSheetState createState() => _NewTaskBottomSheetState();
}

class _NewTaskBottomSheetState extends State<NewTaskBottomSheet> {
  TaskBloc _taskBloc;
  final _formKey = GlobalKey<FormState>();
  var isButtonDisabled = true;
  var hasSwitchedBeneficiary = false;
  Task task = Task();
  AppDropDown2Item _selectedInterval;
  List<AppDropDown2Item> _intervals = [];

  @override
  void initState() {
    _taskBloc = BlocProvider.of<TaskBloc>(context);
    _intervals.add(AppDropDown2Item("DAILY", "Daily"));
    _intervals.add(AppDropDown2Item("WEEKLY", "Weekly"));
    _intervals.add(AppDropDown2Item("MONTHLY", "Every Minute"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      height: 420.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            "New Task",
            style: TextStyle(
                fontSize: 20,
                color: AppColors.textColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          AppHorizontalLine(
            color: AppColors.mainBlack.withOpacity(0.9),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 19.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppTextInput(
                            hintText: 'Add Title e.g  Save \$5 daily',
                            labelText: "Title",
                            onChanged: (text) {
                              task.name = text;
                              watchFormState();
                            },
                          ),
                          AppTextInput(
                            keyboardType: TextInputType.text,
                            labelText: "Notes",
                            onChanged: (text) {
                              task.description = text;
                              watchFormState();
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Spinner(
                                  hintText: "Select Interval",
                                  onSelect: (AppDropDown2Item value) {
                                    task.interval = value.code;
                                    _selectedInterval = value;
                                    watchFormState();
                                  },
                                  selected: _selectedInterval,
                                  items: _intervals,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  BlocConsumer<TaskBloc, TaskState>(
                    builder: (context, state) {
                      return PrimaryButton(
                          icon: Icons.chevron_right_rounded,
                          label: 'SAVE TASK',
                          onPressed:
                              isButtonDisabled ? null : () => saveTask());
                    },
                    listener: (context, state) {
                      if (state is TaskErrorState) {
                        AppSnackBar().show(message: state.error);
                      } else if (state is TaskSaved) {
                        AppSnackBar().show(message: "Task Created");
                        Navigator.pop(context);
                      }
                    },
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void watchFormState() {
    if (task.checkIfAnyIsNull()) {
      setState(() => isButtonDisabled = true);
    } else {
      setState(() => isButtonDisabled = false);
    }
  }

  void gotoNextScreen() {
    Navigator.pushReplacementNamed(context, Routes.tasks);
  }

  void saveTask() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _taskBloc.add(SaveTask(task, widget.resolution.year));
    } else {
      AppSnackBar().show(message: AppStringConstants.formError);
    }
  }
}
