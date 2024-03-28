import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tabbed_sliverlist/tabbed_sliverlist.dart';

import '../../../../common.dart';
import '../logic.dart';

import 'dart:math';

class AvatarModel extends StatelessWidget {
  AvatarModel({Key? key}) : super(key: key);

  final logic = Get.find<SetAvatarLogic>();
  final listitems = [
    'item1','item2','item3'
  ];

  @override
  Widget build(BuildContext context) {
    // print("1111111 ${logic.userList}");
    print("2222222 ${logic}");
    print("1111111 ${logic.avatarInfo}");
    print("1111111 ${(logic.gameItemInfoHead.length / 3).ceil()}");
    // int remainderData = logic.gameItemInfoHead.length % 3;
    // print("余数: ${remainderData}");
    return Scaffold(
      body: TabbedList(
          tabLength: 2,
          sliverTabBar: const SliverTabBar(
              // title: Text('Tabbed SliverList'),
              centerTitle: false,
              tabBar: TabBar(
                tabs: [
                  Tab(
                    text: 'Head',
                  ),
                  Tab(
                    text: 'Body',
                  ),
                ],
              )),
          tabLists: [
            TabListBuilder(
                uniquePageKey: 'page1',
                // length: listitems.length,
                length: (logic.gameItemInfoHead.length / 3).ceil(),
                // length: 1,
                builder: (BuildContext context, index) {
                  // print("yyyyy ${index}");
                  return Padding(
                      padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Image.asset(
                                //   Global.getSetAvatarImageUrl('set_avatar_edit_icon.png'),
                                //   fit: BoxFit.fitHeight,
                                // ),
                                GestureDetector(
                                  onTapUp: (detail) {
                                    print("kkkk嘎嘎嘎嘎是");
                                    print("gfgfgfg: ${logic.avatarInfo}");
                                    print("gfgfgfg: ${logic.gameItemInfoHead}");
                                    // logic.clickHead(
                                    //     logic.avatarInfo[0].id,
                                    //     logic.avatarInfo[0]
                                    //         .url);
                                    logic.clickHead(
                                        logic.gameItemInfoHead[index * 3].id.toString(),
                                        logic.gameItemInfoHead[index * 3]
                                            .icon);
                                  },
                                  child: CachedNetworkImage(
                                    width: 210.w,
                                    // imageUrl: logic.avatarInfo[0].url,
                                    imageUrl: logic.gameItemInfoHead[index * 3].icon,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                if(logic.gameItemInfoHead.length > (index * 3) + 1)GestureDetector(
                                  onTapUp: (detail) {
                                    print("kkkk嘎嘎嘎嘎是");
                                    // logic.clickHead(
                                    //     logic.avatarInfo[1].id,
                                    //     logic.avatarInfo[1]
                                    //         .url);
                                    logic.clickHead(
                                        logic.gameItemInfoHead[(index * 3) + 1].id.toString(),
                                        logic.gameItemInfoHead[(index * 3) + 1]
                                            .icon);
                                  },
                                  child: CachedNetworkImage(
                                    width: 210.w,
                                    // imageUrl: logic.avatarInfo[1].url,
                                    imageUrl: logic.gameItemInfoHead[(index * 3) + 1].icon,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                if(logic.gameItemInfoHead.length > (index * 3) + 2)GestureDetector(
                                  onTapUp: (detail) {
                                    print("kkkk嘎嘎嘎嘎是");
                                    // logic.clickHead(
                                    //     logic.avatarInfo[2].id,
                                    //     logic.avatarInfo[2]
                                    //         .url);
                                    logic.clickHead(
                                        logic.gameItemInfoHead[(index * 3) + 2].id.toString(),
                                        logic.gameItemInfoHead[(index * 3) + 2]
                                            .icon);
                                  },
                                  child: CachedNetworkImage(
                                    width: 210.w,
                                    // imageUrl: logic.avatarInfo[2].url,
                                    imageUrl: logic.gameItemInfoHead[(index * 3) + 2].icon,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                // ParallelogramAvatar(
                                //     width: 180.w, avatarUrl: logic.avatarInfo[3].url, isRequest: true),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     // Image.asset(
                            //     //   Global.getSetAvatarImageUrl('set_avatar_edit_icon.png'),
                            //     //   fit: BoxFit.fitHeight,
                            //     // ),
                            //     GestureDetector(
                            //       onTapUp: (detail) {
                            //         print("kkkk嘎嘎嘎嘎是");
                            //         print("gfgfgfg: ${logic.avatarInfo}");
                            //         logic.clickHead(
                            //             logic.avatarInfo[3].id,
                            //             logic.avatarInfo[3]
                            //                 .url);
                            //       },
                            //       child: CachedNetworkImage(
                            //         width: 210.w,
                            //         imageUrl: logic.avatarInfo[3].url,
                            //         fit: BoxFit.fill,
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTapUp: (detail) {
                            //         print("kkkk嘎嘎嘎嘎是");
                            //         logic.clickHead(
                            //             logic.avatarInfo[4].id,
                            //             logic.avatarInfo[4]
                            //                 .url);
                            //       },
                            //       child: CachedNetworkImage(
                            //         width: 210.w,
                            //         imageUrl: logic.avatarInfo[4].url,
                            //         fit: BoxFit.fill,
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTapUp: (detail) {
                            //         print("kkkk嘎嘎嘎嘎是");
                            //         logic.clickHead(
                            //             logic.avatarInfo[5].id,
                            //             logic.avatarInfo[5]
                            //                 .url);
                            //       },
                            //       child: CachedNetworkImage(
                            //         width: 210.w,
                            //         imageUrl: logic.avatarInfo[5].url,
                            //         fit: BoxFit.fill,
                            //       ),
                            //     ),
                            //     // ParallelogramAvatar(
                            //     //     width: 180.w, avatarUrl: logic.avatarInfo[3].url, isRequest: true),
                            //   ],
                            // ),
                            // Row(
                            //   children: [
                            //     // Image.asset(
                            //     //   Global.getSetAvatarImageUrl('set_avatar_edit_icon.png'),
                            //     //   fit: BoxFit.fitHeight,
                            //     // ),
                            //     GestureDetector(
                            //       onTapUp: (detail) {
                            //         print("kkkk嘎嘎嘎嘎是");
                            //         print("gfgfgfg: ${logic.avatarInfo}");
                            //         logic.clickHead(
                            //             logic.avatarInfo[6].id,
                            //             logic.avatarInfo[6]
                            //                 .url);
                            //       },
                            //       child: CachedNetworkImage(
                            //         width: 210.w,
                            //         imageUrl: logic.avatarInfo[6].url,
                            //         fit: BoxFit.fill,
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTapUp: (detail) {
                            //         print("kkkk嘎嘎嘎嘎是");
                            //         logic.clickHead(
                            //             logic.avatarInfo[7].id,
                            //             logic.avatarInfo[7]
                            //                 .url);
                            //       },
                            //       child: CachedNetworkImage(
                            //         width: 210.w,
                            //         imageUrl: logic.avatarInfo[7].url,
                            //         fit: BoxFit.fill,
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTapUp: (detail) {
                            //         print("kkkk嘎嘎嘎嘎是");
                            //         logic.clickHead(
                            //             logic.avatarInfo[8].id,
                            //             logic.avatarInfo[8]
                            //                 .url);
                            //       },
                            //       child: CachedNetworkImage(
                            //         width: 210.w,
                            //         imageUrl: logic.avatarInfo[8].url,
                            //         fit: BoxFit.fill,
                            //       ),
                            //     ),
                            //     // ParallelogramAvatar(
                            //     //     width: 180.w, avatarUrl: logic.avatarInfo[3].url, isRequest: true),
                            //   ],
                            // ),
                          ],
                        ),
                      // child: ListTile(
                      //   title: Text(listitems[index].toString()),
                      //   leading: CircleAvatar(
                      //     backgroundImage: NetworkImage(Global.getSetAvatarImageUrl('take_a_rest_icon.png')),
                      //   ),
                      //   tileColor: Colors.white,
                  );
                }),
            TabListBuilder(
                uniquePageKey: 'page2',
                // length: listitems.length - 2,
                length: (logic.gameItemInfoBody.length / 3).ceil(),
                builder: (context, index) {
                  // print("xxxxx ${index}");
                  return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      // child: ListTile(
                      //   title: Text(listitems[index].toString()),
                      //   tileColor: Colors.white,
                      // )
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTapUp: (detail) {
                                  logic.clickBody(true);
                                },
                                child: CachedNetworkImage(
                                  width: 210.w,
                                  imageUrl: logic.gameItemInfoBody[0].icon,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              GestureDetector(
                                onTapUp: (detail) {
                                  logic.clickBody(false);
                                },
                                child: CachedNetworkImage(
                                  width: 210.w,
                                  imageUrl: logic.gameItemInfoBody[1].icon,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                          // Global.team == 0 ? Row(
                          //     children: [
                          //       GestureDetector(
                          //         onTapUp: (detail) {
                          //           logic.clickBody(true);
                          //         },
                          //         // child: Image.asset(
                          //         //   Global.getCheckInImageUrl('selection_panel/Red_man_s.png'),
                          //         //   fit: BoxFit.fitHeight,
                          //         //   width: 210.w,
                          //         // ),
                          //       ),
                          //       GestureDetector(
                          //         onTapUp: (detail) {
                          //           logic.clickBody(false);
                          //         },
                          //         child: Image.asset(
                          //           Global.getCheckInImageUrl('selection_panel/Red_Women_s.png'),
                          //           fit: BoxFit.fitHeight,
                          //           width: 210.w,
                          //         ),
                          //       ),
                          //     ]
                          // ) : Row(
                          //     children: [
                          //       GestureDetector(
                          //         onTapUp: (detail) {
                          //           logic.clickBody(true);
                          //         },
                          //         child: Image.asset(
                          //           Global.getCheckInImageUrl('selection_panel/Blue_man_s.png'),
                          //           fit: BoxFit.fitHeight,
                          //           width: 210.w,
                          //         ),
                          //       ),
                          //       GestureDetector(
                          //         onTapUp: (detail) {
                          //           logic.clickBody(false);
                          //         },
                          //         child: Image.asset(
                          //           Global.getCheckInImageUrl('selection_panel/Blue_Women_s.png'),
                          //           fit: BoxFit.fitHeight,
                          //           width: 210.w,
                          //         ),
                          //       ),
                          //     ]
                          // ),
                        ],
                      ),
                  );
                }),
          ]),
    );
  }
}