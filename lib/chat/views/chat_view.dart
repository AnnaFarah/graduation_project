import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/appColor.dart';
import '../controllers/chat_with_admin_controller.dart';

class ChatView extends GetView<ChatController> {
  ChatView({
    required this.name,
    required this.doctor_id,
    required this.patient_id,
    required this.isDocotor,
  });
  //
  String name;
  int doctor_id;
  int patient_id;
  bool isDocotor;
  final text = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // ChatWithAdminView({Key? key}) : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    inspect(controller.message.value);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: Color(newDarkBlue),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Expanded(
              child: SingleChildScrollView(
                  controller: controller.scrollController.value,
                  child: Obx(
                    () {
                      return controller.isLoading.value &&
                              controller.message.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.black))
                          : controller.message.isEmpty
                              ? Center(
                                  child: const Text(
                                    "ليس هنا رسائل بعد",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              : Column(
                                  children: controller.message
                                      .map(
                                        (e) => MessageWidget(
                                          text: e.text,
                                          date: e.updatedAt,
                                          isAdmin: !isDocotor
                                              ? e.senderId == doctor_id
                                              : e.senderId == patient_id,
                                        ),
                                      )
                                      .toList(),
                                );
                    },
                  )
                  // child: 5 == 8
                  //     ? const Center(
                  //         child: CircularProgressIndicator(
                  //           color: Colors.black,
                  //         ),
                  //       )
                  //     : 5 == 4
                  //         ? const Text("ليس هنا رسائل بعد")
                  //         : Column(
                  //             children:
                  //                 //   MessageWidget(true, "السلام عليكم ورحمة الله",
                  //                 //       DateTime.now().toString()),
                  //                 //   const SizedBox(height: 24),
                  //                 //   MessageWidget(false, "السلام عليكم ورحمة الله",
                  //                 //       DateTime.now().toString()),
                  //                 //   const SizedBox(height: 24),
                  //                 //   MessageWidget(true, "السلام عليكم ورحمة الله",
                  //                 //       DateTime.now().toString()),
                  //                 //   const SizedBox(height: 24),
                  //                 //   MessageWidget(false, "السلام عليكم ورحمة الله",
                  //                 //       DateTime.now().toString()),
                  //                 // ]
                  //                 controller.message

                  //                     .toList(),
                  )

              // : Text("No Messages found")),

              ),
          SizedBox(
            height: 70,
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     width: 1,
            //     color: Theme.of(context).accentColor,
            //   ),
            // ),
            // color: Colors.white,
            child: Form(
              key: formKey,
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  IconButton(
                    onPressed: () async {
                      // setState(() {
                      //   messages.add(
                      //     MessageWidget(false, text.text, DateTime.now()),
                      //   );
                      // });
                      //
                      if (!(formKey.currentState?.validate() ?? false)) return;
                      //
                      await controller.postMessage(
                        text.text,
                        isDocotor ? patient_id : doctor_id,
                      );
                      //
                      debugPrint("HERE");
                      text.clear();
                      controller.scrollController.value.animateTo(
                        controller.scrollController.value.position
                                .maxScrollExtent +
                            100,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    icon: Obx(() => !controller.isLoadingSend.value
                        ? const Icon(
                            Icons.send,
                            textDirection: TextDirection.ltr,
                          )
                        : const CircularProgressIndicator()),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: text,
                      validator: (s) => s?.isEmpty ?? true
                          ? "please write message here"
                          : null,
                      textDirection: TextDirection.rtl,
                      style: Get.theme.textTheme.bodyLarge,
                      decoration: InputDecoration(
                        // hintText: "اكتب رسالة",
                        hintTextDirection: TextDirection.rtl,
                        labelText: "send message",
                        // suffixIcon: const Icon(Icons.camera),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFDEDEDE), width: 1.0),
                        ),
                        // filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: const Color(0xFF707070).withOpacity(0.09),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  MessageWidget(
      {required this.isAdmin,
      required this.text,
      required this.date,
      Key? key});

  final bool? isAdmin;
  final String? text;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: isAdmin! ? TextDirection.ltr : TextDirection.rtl,
      // mainAxisAlignment:
      //     isAdmin! ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        const SizedBox(width: 6),
        const CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("icons/user.png"),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Column(
            crossAxisAlignment:
                isAdmin! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  text!,
                  // maxLines: 10,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 15,
                    color: isAdmin!
                        ? Colors.white
                        : const Color(
                            0xFF626C75,
                          ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: isAdmin! ? Colors.grey : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        spreadRadius: 2,
                        offset: Offset(
                          0,
                          3,
                        ),
                      )
                    ]),
              ),
              const SizedBox(height: 5),
              Text(
                // date!,
                date?.split("T")[1].split(".")[0].substring(0, 5) ?? "",
                style: Get.theme.textTheme.bodyLarge!.copyWith(fontSize: 10),
                // textAlign: isAdmin! ? TextAlign.left : TextAlign.left,
              )
            ],
          ),
        ),
        const SizedBox(
          width: 16,
        ),
      ],
    ).marginAll(5);
  }
}

class ChoosAdmin extends StatelessWidget {
  const ChoosAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
    );
  }
}
