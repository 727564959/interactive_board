import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_board/mirra_style.dart';
import 'package:interactive_board/3rd_libs/flutter_holo_date_pick-1.1.3/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.initialDate,
    required this.onChange,
  }) : super(key: key);
  final Function(DateTime) onChange;
  final DateTime initialDate;
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime _selectedDate = widget.initialDate;
  String get dateString => DateFormat('MMM d, yyyy').format(_selectedDate);
  final layerLink = LayerLink();
  late final tapBackGround = OverlayEntry(builder: (context) {
    return GestureDetector(onTapUp: (details) => removeDropdownBubble());
  });
  late final dropdownBubble = OverlayEntry(
    builder: (context) {
      int year = DateTime.now().year - 10;
      return Positioned(
        width: 800.w,
        height: 500.w,
        child: CompositedTransformFollower(
          offset: Offset(0.0, 210.w),
          link: layerLink,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              color: Color(0xffF0F0F0),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 90.w,
                  color: const Color(0xffC1D3D4),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: DatePickerWidget(
                    pickerTheme: DateTimePickerTheme(
                      itemHeight: 90.w,
                      pickerHeight: 440.w,
                      backgroundColor: Colors.transparent,
                      itemTextStyle: CustomTextStyles.textNormal(color: Colors.black, fontSize: 35.sp),
                      dividerColor: Colors.transparent,
                    ),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(year, 12, 31),
                    initialDate: _selectedDate,
                    dateFormat: "MMM/d/yyyy",
                    locale: DateTimePickerLocale.en_us,
                    onChange: (DateTime newDate, _) {
                      widget.onChange(newDate);
                      setState(() {
                        _selectedDate = newDate;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  void removeDropdownBubble() {
    tapBackGround.remove();
    dropdownBubble.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: GestureDetector(
        onTapUp: (details) {
          Overlay.of(context).insert(tapBackGround);
          Overlay.of(context).insert(dropdownBubble);
        },
        child: CompositedTransformTarget(
          link: layerLink,
          child: Container(
            width: 800.w,
            height: 210.w,
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            decoration: const BoxDecoration(
              color: Color(0xff4D797F),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateString,
                  style: CustomTextStyles.title2(
                    color: Colors.white,
                    fontSize: 63.sp,
                  ),
                ),
                Image.asset(
                  MirraIcons.getCheckInIconPath("arrow_down.png"),
                  width: 35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
