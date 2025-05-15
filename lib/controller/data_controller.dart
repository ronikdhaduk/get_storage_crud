
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import '../models/job_data.dart';

class DataController extends GetxController {
  final box = GetStorage();
  final dataList = <JobData>[].obs;

  final storageKey = 'job_list';

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    final stored = box.read(storageKey);
    if (stored != null) {
      final List decoded = jsonDecode(stored);
      dataList.value = decoded.map((e) => JobData.fromJson(e)).toList();
    }
  }

  void saveData() {
    final encoded = jsonEncode(dataList.map((e) => e.toJson()).toList());
    box.write(storageKey, encoded);
  }

  void addJob(JobData job) {
    dataList.add(job);
    saveData();
  }

  void updateJob(int index, JobData job) {
    dataList[index] = job;
    saveData();
  }

  void deleteJob(int index) {
    dataList.removeAt(index);
    saveData();
  }
}
