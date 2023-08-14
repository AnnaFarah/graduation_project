import 'package:get/get.dart';
import 'package:newstart/component/getAndPost.dart';

import '../constant/appliApis.dart';
import '../main.dart';

class TaskController extends GetxController {
  List posts = [];
  bool isLoading = false;
  GetPost getPost = GetPost();

  getAllTasks() async {
    isLoading = true;

    var responseBody = await getPost.getRequest(showAllTasksApi, {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
    });
    isLoading = false;

    if (responseBody['message'] ==
        "All tasks has been  fetched successfully ") {
      posts.addAll(responseBody['data']);
      print('My posts : ${posts}');
      print("success in getting tasks");
    } else {
      print('error');
    }
  }

  // @override
  // void onInit() {
  //   getAllTasks();
  //   super.onInit();
  // }
}
