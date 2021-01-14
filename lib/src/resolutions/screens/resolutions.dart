import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resolution/src/commons/constants/app_colors.dart';
import 'package:resolution/src/commons/constants/app_constants.dart';
import 'package:resolution/src/commons/constants/routes_constant.dart';
import 'package:resolution/src/commons/services/notification_service.dart';
import 'package:resolution/src/commons/util/bottom_sheet.dart';
import 'package:resolution/src/commons/widgets/app_header.dart';
import 'package:resolution/src/commons/widgets/app_widget_transition.dart';
import 'package:resolution/src/resolutions/blocs/resolution/resolution_bloc.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/resolutions/screens/new_resolution.dart';
import 'package:resolution/src/resolutions/widgets/resolution_list_item.dart';

class Resolutions extends StatefulWidget {
  static const String routeName = '/resolutions';
  Resolutions();

  @override
  _ResolutionsState createState() => _ResolutionsState();
}

class _ResolutionsState extends State<Resolutions> {
  ResolutionBloc _resolutionBloc;
  NotificationService _notificationService;
  List<Resolution> _resolutions = [];

  @override
  void initState() {
    _resolutionBloc = BlocProvider.of<ResolutionBloc>(context);
    _notificationService = RepositoryProvider.of<NotificationService>(context);
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
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
          onPressed: () {
            displayBottomSheet(context, NewResolution());
          },
        ),
        backgroundColor: AppColors.windowColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Header(
              previous: Container(),
              title: "New Year, New Me",
              next: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: AppColors.white,
                  )),
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
                      BlocBuilder<ResolutionBloc, ResolutionState>(
                          builder: (context, state) {
                            if (state is ResolutionSaved) {
                              _resolutionBloc.add(GetResolutions());
                            }
                            if (state is ResolutionsReceived) {
                              _resolutions = state.resolutions.toList();
                              if (_resolutions.isEmpty) {
                                return buildEmptyEventContainer(context);
                              } else {
                                return ShowUp(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _resolutions.length,
                                    itemBuilder: (context, position) {
                                      return ResolutionListItem(
                                        icon: Icons.add_circle_outline,
                                        resolution: _resolutions[position],
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
              displayBottomSheet(context, NewResolution());
            },
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "No resolution :-( , create one",
            textAlign: TextAlign.center,
            style: TextStyle(),
          )),
        ],
      ),
    );
  }
}
