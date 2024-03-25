import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/presentation/themeData/themeDataColors.dart';


class custom_showDate extends StatelessWidget {
  const custom_showDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now(),
      height: 90,
      width: 60,
      initialSelectedDate: DateTime.now(),
      dayTextStyle: ThemeDataColors.roboto(
        colors: Colors.white
      ),
      monthTextStyle: ThemeDataColors.roboto(
        colors: Colors.white)
      ,
      selectionColor: Colors.green,
      selectedTextColor: Colors.white,
      dateTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}
