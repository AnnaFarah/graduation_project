import 'package:get/get.dart';

class RequestInfoController extends GetxController {
  String fullName = 'Anna Farah';
  String phonenumber = '0968581480';

  void setName(String name) {
    this.fullName = name;
  }

  void setNumber(String number) {
    this.phonenumber = number;
  }

  String getName() {
    return this.fullName;
  }

  String getNumber() {
    return this.phonenumber;
  }
}
