import 'package:get/get.dart';

class AddNewStudentController extends GetxController {
  List<int> installments = [];
  List<String> course = [];
  List<String> batches = [];
  var batchesTime;

  var batchSelected;

  /*void setSelected(String value) {
    batchSelected.value = value;
  }*/

  /*void addBatchTime(String value) {
    batchesTime = value;
    update();
  }*/

  void addInstallment(int amount) {
    installments.add(amount);
    update();
  }

  void removeInstallment(int index) {
    installments.removeAt(index);
    update();
  }

  void addCourse(String course1) {
    course.add(course1);
    update();
  }

  void removeCourse(String course1) {
    course.remove(course1);
    update();
  }
}
