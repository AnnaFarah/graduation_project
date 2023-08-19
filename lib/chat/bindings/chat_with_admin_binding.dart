import 'package:get/get.dart';

import '../controllers/chat_with_admin_controller.dart';

class ChatWithAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
  }
}
