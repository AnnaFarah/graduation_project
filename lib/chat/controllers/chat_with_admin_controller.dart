import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../component/getAndPost.dart';
import '../../constant/appliApis.dart';
import '../../main.dart';
import '../model/messages.dart';

class ChatController extends GetxController {
  //
  RxList<Message> message = <Message>[].obs;
  RxList<Message> message2 = <Message>[].obs; // patient
  //
  Rx<ScrollController> scrollController = ScrollController().obs;
  //
  Timer? _timer;
  //
  RxBool isLoading = true.obs;
  //
  RxBool isEmpty = false.obs;
  //
  RxBool isLoadingSend = false.obs;
  //
  @override
  void dispose() {
    _timer!.cancel();
    print("Dispose");
    super.dispose();
  }

  //
  @override
  void onInit() {
    super.onInit();
    print("fetch Messages");
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      print("fetch Messages");
      await fetchMessages();
    });
  }

  //
  @override
  void onClose() {
    _timer!.cancel();
    //THIS IS NEVER HIT
    super.onClose();
  }

  //
  //
  RxString? text = "".obs;
  //4
  GetPost getPost = GetPost();

  //
  Future fetchMessages() async {
    isLoading.value = true;
    // ApiRespons? apiRespons = await Get.find<BaseService>().goApi(
    //   url: "receiveMessage",
    //   method: Method.post,
    //   params: {'user_id': Get.find<BaseService>().userInfo?.user!.userId},
    // );

    var responseBody = await getPost.getRequest(
      '$url/api/getMessages/${Get.arguments['doctor_id']}/${Get.arguments['patient_id']}',
      {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${studentSharedPreferences.getString('token')}'
      },
    );
    var responseBody2 = await getPost.getRequest(
      '$url/api/getMessages/${Get.arguments['patient_id']}/${Get.arguments['doctor_id']}',
      {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${patientSharedPreferences.getString('token')}'
      },
    );
    isLoading.value = false;
    //
    if (responseBody?['data'] == null) {
      text?.value = responseBody?.message ?? "";

      return;
      Get.defaultDialog(
        title: "خطأ",
        titleStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
        content: Text(
          responseBody?.message ?? "يرجى المحاولة لاحقاً",
          textAlign: TextAlign.right,
        ),
      );
    }

    //
    List<Message>? temp = (responseBody?['data'] as List?)
        ?.map((dynamic e) => Message.fromJson(e as Map<String, dynamic>))
        .toList()
        .obs;
    List<Message>? temp2 = (responseBody2?['data'] as List?)
        ?.map((dynamic e) => Message.fromJson(e as Map<String, dynamic>))
        .toList()
        .obs;
    //
    //
    if ((temp?.length ?? 0) > message.length ||
        (temp2?.length ?? 0) > message2.length) {
      isLoading.value = false;
      message.value = temp!;
      message.value.addAll(temp2!);
      message.sort((a, b) => a.id!.compareTo(b.id!));
      inspect(message);
      scrollController.value.animateTo(
        scrollController.value.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  //
  Future postMessage(String? message, int id) async {
    log(id.toString());
    // return;
    isLoadingSend.value = true;
    var responseBody = http.post(
      Uri.parse('$url/api/sendMessage'),
      headers: {
        'Accept': 'application/json',
        'Authorization': Get.arguments['isDoctor']
            ? 'Bearer ${studentSharedPreferences.getString('token')}'
            : 'Bearer ${patientSharedPreferences.getString('token')}',
      },
      body: ({
        'reciver_id': id.toString(),
        'text': message,
      }),
    );
    inspect(responseBody);

    await fetchMessages();
    isLoadingSend.value = false;
  }
}
