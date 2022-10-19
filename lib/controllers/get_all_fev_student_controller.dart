import 'package:get/get.dart';

import '../models/res/get_all_fev_student_res_model.dart';
import '../repo/get_all_fev_student_repo.dart';

class GetAllFevStudentController extends GetxController {
  var isLoading = false.obs;
  GetAllFevStudentResModel? getAllFevStudentList;

  @override
  void onInit() {
    fetchAllStudent();
    super.onInit();
    update();
  }

  void fetchAllStudent() async {
    try {
      isLoading(true);
      var allStudents = await GetAllFevStudentRepo.getAllFevStudentRepo();
      if (allStudents != null) {
        getAllFevStudentList = allStudents;

        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }
}
