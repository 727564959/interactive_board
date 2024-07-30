import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_board/mirra_style.dart';
import 'package:signature/signature.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

String _generateRandomString(int length) {
  const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  String result = '';

  for (int i = 0; i < length; i++) {
    int randomIndex = random.nextInt(charset.length);
    result += charset[randomIndex];
  }

  return result;
}

class WaiverController {
  SignatureController signatureController = SignatureController();
  WidgetsToImageController widgetsToImageController = WidgetsToImageController();
  bool get isSignatureNotEmpty => signatureController.isNotEmpty;

  void clearSignatureBar() {
    signatureController.clear();
  }

  Future<void> uploadSignature(String name) async {
    final date = DateFormat("yyyyMMdd").format(DateTime.now());
    final dio = Dio();
    final captureFuture = widgetsToImageController.capture(pixelRatio: 0.5);
    final presignedFuture = dio.get(
      "https://inb27b1nma.execute-api.us-east-1.amazonaws.com/put_signature_pic_to_s3",
      queryParameters: {"object_name": "$date/$name-${_generateRandomString(6)}"},
    );
    final [data, response as Response] = await Future.wait([captureFuture, presignedFuture]);
    if (data == null) throw Exception("Signature data is Null!");
    String presignedUrl = jsonDecode(response.data)["presigned_url"];
    await dio.put(
      presignedUrl,
      data: data,
      options: Options(contentType: "image/png"),
    );
  }
}

class WaiverComponent extends StatefulWidget {
  const WaiverComponent({super.key, required this.controller});
  final WaiverController controller;
  @override
  State<WaiverComponent> createState() => _WaiverComponentState();
}

class _WaiverComponentState extends State<WaiverComponent> {
  String? content;
  @override
  void initState() {
    rootBundle.loadString("assets/terms/RISK_INDEMNITY_ARBITRATION.md").then((value) {
      content = value.replaceAll("<br>", ' \n');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1600.w,
      height: 650.w,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.cyan,
      ),
      child: content == null
          ? Container()
          : RawScrollbar(
              mainAxisMargin: 20.w,
              padding: EdgeInsets.only(right: 10.w),
              thumbColor: const Color(0xff7b7b7b),
              thickness: 20.w,
              radius: Radius.circular(10.w),
              child: SingleChildScrollView(
                child: WidgetsToImage(
                  controller: widget.controller.widgetsToImageController,
                  child: Container(
                    padding: EdgeInsets.only(top: 20.w, bottom: 50.w),
                    color: const Color(0xFFDBE2E3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 100.w, right: 100.w, top: 80.w, bottom: 50.w),
                          child: MarkdownBody(
                            data: content!,
                            styleSheet: MarkdownStyleSheet(
                              listBullet: CustomTextStyles.notice(color: const Color(0XFF9B9B9B), fontSize: 30.sp),
                              h1: CustomTextStyles.textNormal(color: Colors.black, fontSize: 40.sp),
                              h2: CustomTextStyles.title6(color: Colors.black, fontSize: 35.sp),
                              h2Padding: EdgeInsets.only(top: 60.w),
                              p: CustomTextStyles.notice(color: const Color(0XFF9B9B9B), fontSize: 30.sp),
                              pPadding: EdgeInsets.only(top: 20.w),
                            ),
                          ),
                        ),
                        Text(
                          "Signature",
                          style: CustomTextStyles.textNormal(
                            color: Colors.black,
                            fontSize: 35.sp,
                          ),
                        ),
                        Container(
                          height: 500.w,
                          margin: EdgeInsets.only(top: 20.w, bottom: 30.w, left: 50.w, right: 50.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: const Color(0xff4D797F), width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Signature(
                              controller: widget.controller.signatureController,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
