import 'package:bot_toast/bot_toast.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lisudictionary_web/controllers/allwords_controller.dart';
import 'package:lisudictionary_web/controllers/user_controller.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lisudictionary_web/core/services/get_storage_services.dart';
import 'package:lisudictionary_web/models/word_model.dart';
import 'package:lottie/lottie.dart';

import '../../../constants.dart';

class WordsTable extends StatelessWidget {
  const WordsTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecentController>(
      builder: (controller) {
        return Card(
          color: secondaryColor,
          child: FutureBuilder(
            future: Get.find<GetStorageServices>().isAdmin == true
                ? Get.find<FirestoreService>().getWords()
                : Get.find<FirestoreService>()
                    .getContributorWords(Get.find<GetStorageServices>().getId!),
            builder:
                (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                    width: double.infinity,
                    child:

                        // DataTable2(
                        //
                        //
                        //        columnSpacing: defaultPadding,
                        //        minWidth: 600,
                        //        columns: const [
                        //          DataColumn(
                        //            label: Text("Word"),
                        //          ),
                        //          DataColumn(
                        //            label: Text("Definition"),
                        //          ),
                        //          DataColumn(
                        //            label: Text("Date Added"),
                        //          ),
                        //          DataColumn(
                        //            label: Text("Action"),
                        //          ),
                        //          DataColumn(
                        //            label: Text("Edit"),
                        //          ),
                        //        ],
                        //
                        //
                        //        rows:snapshot.data!.map((e) =>recentFileDataRow(e,1) ).toList()
                        //
                        //
                        //
                        //    ):addContributorWords( snapshot),

                        Theme(
                      data: Theme.of(context).copyWith(
                          cardColor: bgColor,
                          textTheme: TextTheme(
                              subtitle2: TextStyle(
                                color: Colors.white,
                              ),
                              bodyText2: TextStyle(color: Colors.white),
                              caption: TextStyle(color: Colors.white))),
                      child: PaginatedDataTable(
                        showCheckboxColumn: false,
                        header: Text(
                          'Added Words',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        rowsPerPage: 30,
                        columns: [
                          DataColumn(
                            label: Text("Word"),
                          ),
                          DataColumn(
                            label: Text("Definition"),
                          ),
                          DataColumn(
                            label: Text("Date Added"),
                          ),
                          DataColumn(
                            label: Text("Status"),
                          ),
                          DataColumn(
                            label: Text("Edit"),
                          ),
                        ],
                        source: Get.find<UserController>().isAdmin() == true
                            ? _AdminDataRow(context, snapshot)
                            : _Contributor(context, snapshot),
                      ),
                    ));
              }
              if (!snapshot.hasData) {
                return AlertDialog(
                  content: Lottie.asset("assets/lottie/loader.json",
                      width: Get.width * 0.1, height: Get.width * 0.1),
                  elevation: 0.0,
                  backgroundColor: secondaryColor,
                );
              }
              return Container(
                  width: 300,
                  height: 100,
                  color: Colors.red,
                  child: const Text("Something went wrong"));
            },
          ),
        );
      },
    );
  }
}

class _AdminDataRow extends DataTableSource {
  AsyncSnapshot<List<Word>>? snapshot;
  _AdminDataRow(this.context, this.snapshot);

  final BuildContext? context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= snapshot!.data!.length) return null;
    final word = snapshot!.data![index];
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (value) {},
      cells: [
        DataCell(
            Container(
                width: Get.width * 0.1,
                child: Text(
                  word.word ?? "",
                  overflow: TextOverflow.ellipsis,
                )), onTap: () async {
          await showDetailDialogue(word.word ?? "");
        }),
        DataCell(
            Container(
              width: Get.width * 0.2,
              child: Text(
                word.engDefinition ?? "",
                overflow: TextOverflow.ellipsis,
              ),
            ), onTap: () async {
          await showDetailDialogue(word.engDefinition ?? "");
        }),
        DataCell(Text(DateFormat.yMMMMd('en_US')
            .format(word.dateAdded ?? DateTime.now()))),
        DataCell(word.isVerified == true
            ? IconButton(
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPressed: () {},
              )
            : Row(children: [
                IconButton(
                    onPressed: () async {
                      await Get.find<RecentController>().myAction(word, true);
                      BotToast.showText(text: "Verified");

                      Get.find<RecentController>().update();
                    },
                    icon: const Icon(Icons.check)),
                IconButton(
                    onPressed: () async {
                      Get.defaultDialog(
                          title: "Confirm",
                          middleText: "Are you sure to reject this word?",
                          onCancel: () {},
                          onConfirm: () async {
                            Get.back();
                            BotToast.showLoading();
                            await Get.find<RecentController>()
                                .myAction(word, false);
                            BotToast.closeAllLoading();
                            Get.find<RecentController>().update();
                            // BotToast.showSimpleNotification(title: "init",align: Alignment.bottomCenter,backgroundColor: Colors.red);
                            BotToast.showText(
                                text: "Rejected", contentColor: Colors.red);
                          });
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                    )),
              ])),
        DataCell(const Icon(Icons.edit), onTap: () {
          Get.find<RecentController>().updateWord(word);
        })
      ],
    );
  }

  @override
  int get rowCount => snapshot!.data!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

class _Contributor extends DataTableSource {
  AsyncSnapshot<List<Word>>? snapshot;

  _Contributor(this.context, this.snapshot);

  final BuildContext? context;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= snapshot!.data!.length) return null;
    final word = snapshot!.data![index];
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (value) {
        // if (row.selected != value) {
        //   _selectedCount += value! ? 1 : -1;
        //   assert(_selectedCount >= 0);
        //   row.selected = value;
        //   notifyListeners();
        // }
      },
      cells: [
        DataCell(
            Container(
                width: Get.width * 0.1,
                child: Text(
                  word.word ?? "",
                  overflow: TextOverflow.ellipsis,
                )), onTap: () async {
          await showDetailDialogue(word.word ?? "");
        }),
        DataCell(
            Container(
                width: Get.width * 0.2,
                child: Text(
                  word.engDefinition ?? "",
                  overflow: TextOverflow.ellipsis,
                )), onTap: () async {
          await showDetailDialogue(word.word ?? "");
        }),
        DataCell(Text(DateFormat.yMMMMd('en_US')
            .format(word.dateAdded ?? DateTime.now()))),
        DataCell(word.isVerified == true ? Text("Verified") : Text("Pending")),
        DataCell(const Icon(Icons.edit), onTap: () {
          Get.find<RecentController>().updateWord(word);
        })
      ],
    );
  }

  @override
  int get rowCount => snapshot!.data!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

Future showDetailDialogue(String contents) async {
  return await Get.defaultDialog(
    title: "",
    content: Container(
        width: Get.width * 0.5,
        height: Get.width * 0.2,
        child: Center(child: Text(contents))),
    onCancel: () {},
  );
}
