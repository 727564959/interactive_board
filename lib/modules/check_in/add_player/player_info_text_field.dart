import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../mirra_style.dart';

class PlayerInfoTextField extends StatelessWidget {
  const PlayerInfoTextField({
    Key? key,
    required this.title,
    required this.controller,
    required this.onEditingComplete,
    this.inputFormatters,
    this.validator,
    this.keyboardType,
  }) : super(key: key);
  final String title;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String?>? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onEditingComplete;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 670.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20.w),
            child: Text(
              title,
              style: CustomTextStyles.title5(color: Colors.white, fontSize: 36.sp),
            ),
          ),
          SizedBox(
            height: 200.w,
            child: TextFormField(
              keyboardType: keyboardType,
              controller: controller,
              validator: validator,
              inputFormatters: inputFormatters,
              style: CustomTextStyles.title5(color: Colors.black, fontSize: 34.sp),
              onEditingComplete: onEditingComplete,
              decoration: InputDecoration(
                fillColor: const Color(0xFFDBE2E3),
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 25.w, horizontal: 50.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(style: BorderStyle.none),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                errorStyle: const TextStyle(fontSize: 18),
                errorMaxLines: 1,
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
