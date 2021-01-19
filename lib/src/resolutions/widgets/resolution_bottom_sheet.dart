import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resolution/src/commons/constants/app_colors.dart';
import 'package:resolution/src/commons/constants/app_constants.dart';
import 'package:resolution/src/commons/constants/app_strings.dart';
import 'package:resolution/src/commons/widgets/app_horizontal_line.dart';
import 'package:resolution/src/commons/widgets/app_snackbar.dart';
import 'package:resolution/src/commons/widgets/app_text_view.dart';
import 'package:resolution/src/commons/widgets/primary_button.dart';
import 'package:resolution/src/resolutions/blocs/resolution/resolution_bloc.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';

class NewResolutionBottomSheet extends StatefulWidget {
  static const String routeName = '/newResolution';
  NewResolutionBottomSheet();

  @override
  _NewResolutionBottomSheetState createState() =>
      _NewResolutionBottomSheetState();
}

class _NewResolutionBottomSheetState extends State<NewResolutionBottomSheet> {
  ResolutionBloc _resolutionBloc;
  final _formKey = GlobalKey<FormState>();
  var isButtonDisabled = true;
  var hasSwitchedBeneficiary = false;
  DateTime _selectedYear = DateTime(2021);
  Resolution resolution = Resolution();

  @override
  void initState() {
    _resolutionBloc = BlocProvider.of<ResolutionBloc>(context);
    resolution.year = _selectedYear.year;
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.shadow,
                                      blurRadius: 15.0,
                                      offset: Offset(0, 8)),
                                ]),
                            height: 120,
                            // ignore: deprecated_member_use
                            child: YearPicker(
                                selectedDate: _selectedYear,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(3000),
                                onChanged: (text) {
                                  _selectedYear = text;
                                  resolution.year = text.year;
                                  watchFormState();
                                }),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextInput(
                            keyboardType: TextInputType.text,
                            labelText: "Motto",
                            onChanged: (text) {
                              resolution.motto = text;
                              watchFormState();
                            },
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
                              isButtonDisabled ? null : () => saveResolution());
                    },
                    listener: (context, state) {
                      if (state is ResolutionErrorState) {
                        AppSnackBar().show(message: state.error);
                      } else if (state is ResolutionSaved) {
                        AppSnackBar().show(message: "Resolution Created");
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
    if (resolution.checkIfAnyIsNull()) {
      setState(() => isButtonDisabled = true);
    } else {
      setState(() => isButtonDisabled = false);
    }
  }

  void saveResolution() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _resolutionBloc.add(SaveResolution(resolution));
    } else {
      AppSnackBar().show(message: AppStringConstants.formError);
    }
  }
}
