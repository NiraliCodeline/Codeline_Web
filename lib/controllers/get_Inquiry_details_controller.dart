import 'package:codeline_info_responsive_ui/models/res/get_Inquiry_details_res_model.dart';
import 'package:codeline_info_responsive_ui/repo/get_Inquiry_details_repo.dart';
import 'package:get/get.dart';

class GetInquiryDetailsController extends GetxController {
  //final int id;
  final isLoading = false.obs;
  GetInquiryDetailsResModel? allInquiryDetailsList;

  //GetInquiryDetailsController(this.id);

  @override
  void onInit() {
    //fetchInquiryDetailsStudent();
    super.onInit();
    //update();
  }

  void fetchInquiryDetailsStudent({int? id}) async {
    try {
      isLoading.value = true;

      var allStudents = await GetInquiryDetailsRepo.getInquiryDetailsrepo(id!);
      if (allStudents != null) {
        allInquiryDetailsList = allStudents;

        print(
            "InquiryStudentDetails:--------${allInquiryDetailsList!.inquiryDetails![0].fullName}");
        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }
}
