import 'package:get/get.dart';

import '../models/res/get_allInquiry_res_model.dart';
import '../repo/get_allInquiry_repo.dart';

class GetAllInquiryController extends GetxController {
  var isLoading = false.obs;
  List<Datum> searchResult = [];
  GetAllInquiryResModel? allInquiryStudentList;
  var id = 0.obs;

  @override
  void onInit() {
    fetchAllInquiryStudent();
    super.onInit();
    update();
  }

  void fetchAllInquiryStudent() async {
    try {
      isLoading(true);
      var allStudents = await GetAllInquiryRepo.getAllInquiryrepo();
      if (allStudents != null) {
        allInquiryStudentList = allStudents;

        print(
            "InquiryStudent:--------${allInquiryStudentList!.data![0].fullName}");
        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  void addSearchResult(Datum value) {
    searchResult.add(value);
    update();
  }

  void onItemTapped(int inquiryId) {
    id.value = inquiryId;
    update();
  }
}
