import 'package:get/get.dart';
import '../../data/network/show_repository.dart';
import '../../common.dart';
import 'data/checkin_api.dart';
import 'data/user_info.dart';

class CheckInLogic extends GetxController {
  final checkInApi = CheckInApi();
  String get gameName => GameShowRepository().gameName!;
  List<UserInfo> userList = [];
  bool isCheckIn = false;
  String currentNickName = "";

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
  }

  @override
  void onClose() {
    super.onClose();
  }
}
