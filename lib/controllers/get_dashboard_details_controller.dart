import 'package:codeline_info_responsive_ui/models/res/get_dashboard_details_res_model.dart';
import 'package:codeline_info_responsive_ui/repo/get_dashboard_details_repo.dart';
import 'package:get/get.dart';

class GetDashboardDetailsController extends GetxController {
  var isLoading = false.obs;
  GetDashboardDetailsResModel? allDashboardDetailsList;

  @override
  void onInit() {
    super.onInit();
    update();
  }

  Future<void> fetchAllDashboardDetails() async {
    //await Future.delayed(Duration(seconds: 3));
    try {
      isLoading(true);
      var allStudents = await GetDashboardDetailsRepo.getDashboardDetailsrepo();
      if (allStudents != null) {
        allDashboardDetailsList = allStudents;

        print(
            "CompletedStudent:--------${allDashboardDetailsList!.completedStudent}");
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
      update();
    }
  }
}
