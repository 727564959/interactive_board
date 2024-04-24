import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../mirra_style.dart';
import '../logic.dart';

class AvatarDesign extends StatefulWidget {
  @override
  _AvatarDesignState createState() => _AvatarDesignState();
}

class _AvatarDesignState extends State<AvatarDesign> {
  final logic = Get.find<SetAvatarLogic>();

  int selectedAvatarIndex = 0;
  int selectedBodyIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Head',
              style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 210,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: logic.gameItemInfoHead.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatarIndex = index;
                      logic.clickHead(
                          logic.gameItemInfoHead[index].id.toString(),
                          logic.gameItemInfoHead[index].icon);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: index == selectedAvatarIndex ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: CachedNetworkImage(
                            imageUrl: logic.gameItemInfoHead[index].icon,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          color: Color(0xFFDBE2E3),
                          width: 160,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              logic.gameItemInfoHead[index].name,
                              maxLines: 1, // 最大显示行数
                              overflow: TextOverflow.ellipsis, // 超出部分的省略样式
                              style: CustomTextStyles.notice(color: Color(0xFF5A5858), fontSize: 24.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Body',
              style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: logic.gameItemInfoBody.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBodyIndex = index;
                      logic.clickBody(
                          logic.gameItemInfoBody[index].id.toString(),
                          logic.gameItemInfoBody[index].icon);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: index == selectedBodyIndex ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: CachedNetworkImage(
                            height: 210,
                            imageUrl: logic.gameItemInfoBody[index].icon,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          color: Color(0xFFDBE2E3),
                          width: 160,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              logic.gameItemInfoBody[index].name,
                              maxLines: 1, // 最大显示行数
                              overflow: TextOverflow.ellipsis, // 超出部分的省略样式
                              style: CustomTextStyles.notice(color: Color(0xFF5A5858), fontSize: 24.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}