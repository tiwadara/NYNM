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
import 'package:resolution/src/resolutions/blocs/resolution/resolution_bloc.dart';
import 'package:resolution/src/resolutions/screens/new_resolution.dart';

class Resolutions extends StatefulWidget {
  static const String routeName = '/resolutions';
  Resolutions();

  @override
  _ResolutionsState createState() => _ResolutionsState();
}

class _ResolutionsState extends State<Resolutions>
    with TickerProviderStateMixin {
  final attributeValueTextController = TextEditingController();
  AnimationController _animationController;
  ResolutionBloc _resolutionBloc;

  @override
  void initState() {
    _resolutionBloc = BlocProvider.of<ResolutionBloc>(context);
    _resolutionBloc.add(GetResolutions());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
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
                      // CalendarCarouselExample2(),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "THIS MONTH",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.pushNamed(context, Routes.allResolutions);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "All Events ",
                                  style: TextStyle(color: AppColors.grey),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  size: 12,
                                  color: AppColors.grey,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      // BlocBuilder<ResolutionBloc, ResolutionState>(
                      //     buildWhen: (previous, current) => current is EventsReturned
                      //     builder: (context, state) {
                      //       if (state is EventsReturned) {
                      //         _resolutions = state.events.toList();
                      //         var groupedEvents =
                      //             groupEventsForCurrentMonth(_resolutions);
                      //         if (_resolutions.isEmpty || groupedEvents.isEmpty) {
                      //           return buildEmptyEventContainer(context);
                      //         } else {
                      //           return ShowUp(
                      //             child: Padding(
                      //               padding: const EdgeInsets.only(top: 15.0),
                      //               child: EventList(events: groupedEvents),
                      //             ),
                      //           );
                      //         }
                      //       }
                      //       if (state is EventsInSelectedMonth) {
                      //         // _events = state.events.toList();
                      //         var groupedEvents =
                      //             groupEvents(_resolutions, state.month);
                      //         if (_resolutions.isEmpty || groupedEvents.isEmpty) {
                      //           return buildEmptyEventContainer(context);
                      //         } else {
                      //           return ShowUp(
                      //             child: Padding(
                      //               padding: const EdgeInsets.only(top: 15.0),
                      //               child: EventList(events: groupedEvents),
                      //             ),
                      //           );
                      //         }
                      //       } else if (state is GettingEvents) {}
                      //       return buildEmptyEventContainer(context);
                      //     }),
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
              // Navigator.pushNamed(context, Routes.newEvent);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "No upcoming events, create one",
            textAlign: TextAlign.center,
            style: TextStyle(),
          )),
        ],
      ),
    );
  }
}
