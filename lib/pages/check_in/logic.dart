import 'package:get/get.dart';
import '../../data/network/show_repository.dart';
import '../../common.dart';
import 'data/avatar_info.dart';
import 'data/checkin_api.dart';
import 'data/user_info.dart';

class CheckInLogic extends GetxController {
  final checkInApi = CheckInApi();
  String get gameName => GameShowRepository().gameName!;
  List<UserInfo> userList = [];
  List<AvatarInfo> avatarInfo = [];
  bool isCheckIn = false;
  String currentNickName = "";
  String isAvatarType = "head";
  String headId = "";
  bool? currentIsMale;

  String? selectedId;
  void clickItem(String id, String nickname) {
    print("点击了item");
    currentNickName = nickname;
    if (id == selectedId) {
      selectedId = null;
    } else {
      selectedId = id;
    }
    update();
  }

  void clickHead(String id) {
    print("点击了头像");
    print("头像的id: $id");
    headId = id;
  }

  void clickBody(bool gender) {
    print("点击了身体");
    print("身体的id: $gender");
    currentIsMale = gender;
  }

  void clickCut(String type) {
    print("切换");
    print("12345: $type");
    isAvatarType = type;
    update(['typePage']);
  }

  void checkInFun(bool isClick) async {
    print("调用了");
    // update(["avatarSelect"]);
    if (isClick) {
      isCheckIn = true;
    } else {
      isCheckIn = false;
    }
    // isCheckIn = true;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    userList = await checkInApi.fetchUsers();
    currentNickName = userList[0].nickname;
    avatarInfo = await checkInApi.fetchAvatars();
    print("头像: $avatarInfo");
  }

  @override
  void onClose() {
    super.onClose();
  }
}
