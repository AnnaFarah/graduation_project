import '../constant/validMessages.dart';

validator(String val, int min, int max) {
  if (val.isEmpty) {
    return "$emptyField";
  } else if (val.length < min) {
    return "$minLength";
  } else if (val.length > max) {
    return "$maxLength";
  }
}
