
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/data_controller.dart';
import '../models/job_data.dart';


class HomePage extends StatelessWidget {
  final controller = Get.put(DataController());

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final countryController = TextEditingController();

  void openAddDialog({int? editIndex}) {
    if (editIndex != null) {
      final job = controller.dataList[editIndex];
      titleController.text = job.title;
      descController.text = job.description;
      countryController.text = job.countries.join(', ');
    } else {
      titleController.clear();
      descController.clear();
      countryController.clear();
    }

    Get.defaultDialog(
      title: editIndex == null ? "Add Job" : "Edit Job",
      content: Column(
        children: [
          TextField(controller: titleController, decoration: InputDecoration(labelText: 'Title')),
          TextField(controller: descController, decoration: InputDecoration(labelText: 'Description')),
          TextField(controller: countryController, decoration: InputDecoration(labelText: 'Countries (comma separated)')),
        ],
      ),
      textConfirm: "Save",
      onConfirm: () {
        final job = JobData(
          title: titleController.text,
          description: descController.text,
          countries: countryController.text.split(',').map((e) => e.trim()).toList(),
        );
        if (editIndex == null) {
          controller.addJob(job);
        } else {
          controller.updateJob(editIndex, job);
        }
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => openAddDialog(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.dataList.isEmpty) {
          return Center(child: Text("No data yet"));
        }
        return ListView.builder(
          itemCount: controller.dataList.length,
          itemBuilder: (context, index) {
            final job = controller.dataList[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(job.title),
                subtitle: Text("${job.description}\nCountries: ${job.countries.join(', ')}"),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: Icon(Icons.edit), onPressed: () => openAddDialog(editIndex: index)),
                    IconButton(icon: Icon(Icons.delete), onPressed: () => controller.deleteJob(index)),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
