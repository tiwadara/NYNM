import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resolution/src/commons/constants/app_colors.dart';
import 'package:resolution/src/commons/constants/app_constants.dart';
import 'package:resolution/src/commons/constants/routes_constant.dart';
import 'package:resolution/src/commons/widgets/app_horizontal_line.dart';
import 'package:resolution/src/commons/widgets/app_loader.dart';
import 'package:resolution/src/commons/widgets/app_snackbar.dart';
import 'package:resolution/src/commons/widgets/app_spinner.dart';
import 'package:resolution/src/commons/widgets/app_text_view.dart';
import 'package:resolution/src/commons/widgets/primary_button.dart';
import 'package:resolution/src/resolutions/blocs/resolution/resolution_bloc.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';

class NewResolution extends StatefulWidget {
  static const String routeName = '/newResolution';
  NewResolution();

  @override
  _NewResolutionState createState() => _NewResolutionState();
}

class _NewResolutionState extends State<NewResolution> {
  ResolutionBloc _resolutionBloc;
  final _formKey = GlobalKey<FormState>();
  var isButtonDisabled = true;
  var hasSwitchedBeneficiary = false;
  Resolution resolution = Resolution();
  AppDropDown2Item _selectedInterval;
  List<AppDropDown2Item> _intervals = [];
  TextEditingController dateTextController = TextEditingController();
  TextEditingController endDateTextController = TextEditingController();

  @override
  void initState() {
    _resolutionBloc = BlocProvider.of<ResolutionBloc>(context);
    resolution.increment = 1;
    _intervals.add(AppDropDown2Item("DAILY", "Daily"));
    _intervals.add(AppDropDown2Item("WEEKLY", "Weekly"));
    _intervals.add(AppDropDown2Item("MONTHLY", "Monthly"));
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
            "New Resolution",
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
                            hintText: 'Add Title e.g  Kids monthly stipends',
                            labelText: "Title",
                            onChanged: (text) {
                              resolution.name = text;
                              watchFormState();
                            },
                          ),
                          AppTextInput(
                            keyboardType: TextInputType.text,
                            labelText: "Notes",
                            onChanged: (text) {
                              resolution.description = text;
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
                                    resolution.interval = value.code;
                                    _selectedInterval = value;
                                    print("seellle" + _selectedInterval.toString());
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
                  BlocConsumer<ResolutionBloc, ResolutionState>(
                    builder: (context, state) {
                      return PrimaryButton(
                          icon: Icons.chevron_right_rounded,
                          label: 'SAVE RESOLUTION',
                          onPressed:
                              isButtonDisabled ? null : () => createEvent());
                    },
                    listener: (context, state) {
                      if (state is ErrorWithMessageState) {
                        Navigator.pop(context);
                        AppSnackBar().show(message: state.error);
                      } else if (state is ResolutionSaved) {
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
    print("event" + resolution.toJson().toString());
    if (resolution.checkIfAnyIsNull()) {
      setState(() => isButtonDisabled = true);
    } else {
      setState(() => isButtonDisabled = false);
    }
  }

  void gotoNextScreen() {
    Navigator.pushReplacementNamed(context, Routes.resolutions);
  }

  void createEvent() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      showOverlay(context, "Creating Schedule");
      _resolutionBloc.add(SaveResolution(resolution));
    } else {
      AppSnackBar().show(message: "Please, correct invalid fields");
    }
  }

  @override
  void dispose() {
    endDateTextController.dispose();
    dateTextController.dispose();
    super.dispose();
  }
}
