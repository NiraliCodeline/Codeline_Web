import 'package:get/get.dart';

import '../models/res/get_Inquiry_details_res_model.dart';
import '../repo/get_Inquiry_details_repo.dart';

class GetInquiryDetailsController extends GetxController {
  final int id;
  var isLoading = false.obs;
  GetInquiryDetailsResModel? allInquiryDetailsList;

  GetInquiryDetailsController(this.id);

  @override
  void onInit() {
    fetchInquiryDetailsStudent();
    super.onInit();
    update();
  }

  void fetchInquiryDetailsStudent() async {
    try {
      isLoading(true);
      var allStudents = await GetInquiryDetailsRepo.getInquiryDetailsrepo(id);
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
