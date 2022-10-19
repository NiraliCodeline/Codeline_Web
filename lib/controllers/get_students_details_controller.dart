import 'package:codeline_info_responsive_ui/constant/const.dart';
import 'package:codeline_info_responsive_ui/models/req/add_installment_req_model.dart';
import 'package:codeline_info_responsive_ui/repo/add_installment_repo.dart';
import 'package:codeline_info_responsive_ui/repo/update_batch_repo.dart';
import 'package:get/get.dart';
import '../models/req/update_batch_res_model.dart';
import '../models/res/get_students_details_res_model.dart';
import '../repo/get_students_details_repo.dart';

class GetStudentsDetailsController extends GetxController {
  // final id;
  var isLoading = false.obs;
  var isInitialLoading = false.obs;
  RxBool iconSeen = false.obs;

  GetStudentsDetailsResModel? StudentDetailsList;

  // GetStudentsDetailsController(this.id);
  //RxList<Datum> allData = <Datum>[].obs;

  List<AllInstallment>? allInstallment;
  List<Batch>? allbatch;

  @override
  void onInit() {
    //fetchAllStudentDetails();

    super.onInit();
  }

  Future fetchAllStudentDetails({int? id}) async {
    try {
      isInitialLoading(true);
      update();
      var allStudentsDetails =
          await GetStudentsDetailsRepo.getStudentsDetails(id!);
      if (allStudentsDetails != null) {
        StudentDetailsList = allStudentsDetails;
        allInstallment = List.generate(
            StudentDetailsList!.studentDetails!.allInstallments!.length,
            (index) {
          print(
              "check:${StudentDetailsList!.studentDetails!.allInstallments![index].installmentId}");
          var x = AllInstallment(
              installmentId: StudentDetailsList!
                  .studentDetails!.allInstallments![index].installmentId,
              amount: StudentDetailsList!
                  .studentDetails!.allInstallments![index].amount,
              completed: StudentDetailsList!
                  .studentDetails!.allInstallments![index].completed,
              date: StudentDetailsList!
                  .studentDetails!.allInstallments![index].date);

          print("XXXXXXXXXXXXXXX----------${allInstallment}");
          return x;
        });

        allbatch = List.generate(
            StudentDetailsList!.studentDetails!.batch!.length, (index) {
          var a = Batch(
            batch: StudentDetailsList!.studentDetails!.batch![index].batch,
            currentBatch:
                StudentDetailsList!.studentDetails!.batch![index].currentBatch,
          );
          return a;
        });

        update();
        print("new---------${allInstallment![0].installmentId}");
        print("BATCH ID---------${allbatch![2].batch}");
      }
    } finally {
      isInitialLoading(false);
      update();
    }
  }

  void updateLocalInstallment({
    required int index,
    required String isDone,
  }) async {
    if (StudentDetailsList!.studentDetails!.allInstallments![index].completed ==
            "0" &&
        index == 0) {
      iconSeen = true.obs;
      allInstallment![index].completed = isDone;
      //allInstallment![index].date = DateTime.now().toString().split(".")[0];
      allInstallment![index].date = dateTime == null
          ? DateTime.now().toString().split(".")[0]
          : dateSelected;

      update();
    } else if (StudentDetailsList!
                .studentDetails!.allInstallments![index].completed ==
            "0" &&
        StudentDetailsList!
                .studentDetails!.allInstallments![index - 1].completed !=
            "0") {
      iconSeen = true.obs;
      allInstallment![index].completed = isDone;
      //allInstallment![index].date = DateTime.now().toString().split(".")[0];
      allInstallment![index].date = dateTime == null
          ? DateTime.now().toString().split(".")[0]
          : dateSelected;

      update();
    } else {
      iconSeen = false.obs;
      update();
    }
  }

  void resetInstallmentPopup() {
    allInstallment = List.generate(
        StudentDetailsList!.studentDetails!.allInstallments!.length,
        (index) => AllInstallment(
            installmentId: StudentDetailsList!
                .studentDetails!.allInstallments![index].installmentId,
            amount: StudentDetailsList!
                .studentDetails!.allInstallments![index].amount,
            completed: StudentDetailsList!
                .studentDetails!.allInstallments![index].completed,
            date: StudentDetailsList!
                .studentDetails!.allInstallments![index].date));
    update();
  }

  Future<bool> updateServerInstallment(int studentId) async {
    isLoading(true);
    update();
    List<Installment>? installments = [];
    allInstallment!.forEach((element) {
      installments.add(Installment(
          date: element.date,
          completed: element.completed,
          installmentId: int.parse(element.installmentId!)));
    });
    AddInstallmentReqModel addInstallmentResModel = AddInstallmentReqModel(
        studentId: studentId, installments: installments);

    print("studentId:$studentId");

    bool result =
        await AddInstallmentRepo.updateInstallment(addInstallmentResModel);

    StudentDetailsList!.studentDetails!.allInstallments = List.generate(
        allInstallment!.length,
        (index) => AllInstallment(
            installmentId: allInstallment![index].installmentId,
            amount: allInstallment![index].amount,
            completed: allInstallment![index].completed,
            date: allInstallment![index].date));

    isLoading(false);
    update();
    return result;
  }

  void updateLocalBatch({required int index, required var isDone}) async {
    if (StudentDetailsList!.studentDetails!.batch![index].currentBatch == 0) {
      allbatch![index].currentBatch = isDone;
      update();
    }
  }

  void updateLocalCourse({required int index, required var course}) async {
    StudentDetailsList!.studentDetails!.currentCourse = course;
    update();
  }

  void updateStudentDetails({
    required String updateName,
    required String updateEmail,
    required String updatePhoneNumber,
    required String updateAddress,
  }) {
    StudentDetailsList!.studentDetails!.fullName = updateName;
    StudentDetailsList!.studentDetails!.email = updateEmail;
    StudentDetailsList!.studentDetails!.mobile = updatePhoneNumber;
    StudentDetailsList!.studentDetails!.address = updateAddress;
    update();
  }

  void resetBatch() {
    allbatch = List.generate(
        StudentDetailsList!.studentDetails!.batch!.length,
        (index) => Batch(
              batch: StudentDetailsList!.studentDetails!.batch![index].batch,
              currentBatch: StudentDetailsList!
                  .studentDetails!.batch![index].currentBatch,
            ));
    update();
  }

  Future<bool> updateServerBatch(int studentId) async {
    isLoading(true);
    update();
    List<Batches> batch = [];
    allbatch!.forEach((element) {
      batch.add(
          Batches(batch: element.batch, currentBatch: element.currentBatch));
    });

    UpdateBatchReqModel updateBatchReqModel =
        UpdateBatchReqModel(studentId: studentId, batch: batch);

    bool result =
        await UpdateBatchRepo.updateCurrentBatchRepo(updateBatchReqModel);
    StudentDetailsList!.studentDetails!.batch = List.generate(
        allbatch!.length,
        (index) => Batch(
            batch: allbatch![index].batch,
            currentBatch: allbatch![index].currentBatch));
    isLoading(false);
    update();
    return result;
  }
}
