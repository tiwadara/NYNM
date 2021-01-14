import 'package:flutter/material.dart';
import 'package:resolution/src/commons/constants/app_colors.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';

class ResolutionListItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
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
                      resolution.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor),
                    ),
                    Text(resolution.description),
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
          color: position.isEven
              ? AppColors.borderGrey.withOpacity(0.2)
              : AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
