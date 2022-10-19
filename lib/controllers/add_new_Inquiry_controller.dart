import 'package:get/get.dart';

class AddNewInquiryController extends GetxController {
  List<String> course = [];
  List<String> counsellerList = [];
  var counseller;

  var counsellerSelected;

  void addCourse(String course1) {
    course.add(course1);
    update();
  }

  void removeCourse(String course1) {
    course.remove(course1);
    update();
  }
}
