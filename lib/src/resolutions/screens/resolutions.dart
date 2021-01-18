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
import 'package:resolution/src/resolutions/blocs/resolution/resolution_bloc.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/resolutions/widgets/resolution_bottom_sheet.dart';
import 'package:resolution/src/resolutions/widgets/resolution_list_item.dart';

class Resolutions extends StatefulWidget {
  static const String routeName = '/resolutionInYears';
  Resolutions();

  @override
  _ResolutionsState createState() => _ResolutionsState();
}

class _ResolutionsState extends State<Resolutions> {
  ResolutionBloc _resolutionBloc;
  List<Resolution> _resolutions = [];

  @override
  void initState() {
    _resolutionBloc = BlocProvider.of<ResolutionBloc>(context);
    _resolutionBloc.add(GetResolutions());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
        backgroundColor: AppColors.windowColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Header(
              previous: Container(),
              title: "",
              next: Container()
            ),
            Container(
              height: 200.h,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: AppColors.primaryDark,
              child: Text(
                "Hey, time to make your yearly resolution.",
                style: TextStyle(
                    fontSize: 40,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      BlocBuilder<ResolutionBloc, ResolutionState>(
                          buildWhen: (previous, current) =>
                              current is ResolutionsReceived ||
                              current is ResolutionSaved,
                          builder: (context, state) {
                            if (state is ResolutionSaved) {
                              _resolutionBloc.add(GetResolutions());
                            } else if (state is ResolutionsReceived) {
                              _resolutions = state.resolutions.toList();
                              if (_resolutions.isEmpty) {
                                return buildEmptyEventContainer(context);
                              } else {
                                return ShowUp(
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _resolutions.length + 1,
                                    itemBuilder: (context, position) {
                                      if (position == 0) {
                                        return Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 2),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: AppColors.primaryDark,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              displayBottomSheet(context,
                                                  NewResolutionBottomSheet());
                                            },
                                          ),
                                        );
                                      }
                                      return ResolutionListItem(
                                        icon: Icons.add_circle_outline,
                                        resolution: _resolutions[position - 1],
                                        color: Colors.white,
                                        position: position,
                                        onPressed: () {},
                                      );
                                    },
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                  ),
                                );
                              }
                            } else if (state is LoadingResolution) {
                              print("loading resolutions");
                              return Container(
                                  height: 40,
                                  child: CircularProgressIndicator());
                            }

                            return Container();
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
              displayBottomSheet(context, NewResolutionBottomSheet());
            },
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "No resolution :-( , create one",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}
