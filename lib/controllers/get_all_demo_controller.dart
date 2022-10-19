import 'package:codeline_info_responsive_ui/models/res/get_all_demo_res_model.dart';
import 'package:codeline_info_responsive_ui/repo/get_all_demo_repo.dart';
import 'package:get/get.dart';

class GetAllDemoController extends GetxController {
  var isLoading = false.obs;
  GetAllDemoResModel? allDemoStudentList;
  RxBool isSearch = false.obs;

  @override
  void onInit() {
    fetchAllDemoStudent();
    super.onInit();
    update();
  }

  void fetchAllDemoStudent() async {
    try {
      isLoading(true);
      var allStudents = await GetAllDemoRepo.getAllDemorepo();
      if (allStudents != null) {
        allDemoStudentList = allStudents;
        print("------------->>>>>>>>>>>>>$allDemoStudentList");

        print("Student_Count:${allDemoStudentList!.data![0].fullName}");

        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }
}
