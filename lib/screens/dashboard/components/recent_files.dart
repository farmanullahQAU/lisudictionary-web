import 'package:bot_toast/bot_toast.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lisudictionary_web/controllers/recent_controller.dart';
import 'package:lisudictionary_web/core/services/firestore_services.dart';
import 'package:lisudictionary_web/models/word_model.dart';
import 'package:lottie/lottie.dart';

import '../../../constants.dart';


class WordsTable extends StatelessWidget {


  WordsTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecentController>(
      builder:(controller)=> Card(
        color: secondaryColor,
        child: FutureBuilder(
          future: Get.find<FirestoreService>().getWords(),
          builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {

            if(snapshot.hasData)
            {
           return   SizedBox(
             width: double.infinity,
             child: DataTable2(


                  columnSpacing: defaultPadding,
                  minWidth: 600,
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
                      label: Text("Action"),
                    ),
                    DataColumn(
                      label: Text("Edit"),
                    ),
                  ],


                  rows:snapshot.data!.map((e) =>recentFileDataRow(e,1) ).toList()
                  // List.generate(
                  //   controller.words?.length??0,
                  //   (index) => recentFileDataRow(controller.words!=null?controller.words![index]:null,index),
                  // ),


                ),
           );

            }
            if(!snapshot.hasData)
              {
               return  AlertDialog(
                 content: Lottie.asset("assets/lottie/loader.json",width: Get.width*0.1,height: Get.width*0.1),
                 elevation: 0.0,
                 backgroundColor: secondaryColor,
               );


              }
            return const Text("Something went wrong");
          },),
      ),
    );
  }
}

DataRow recentFileDataRow(Word? fileInfo,int index) {
  final controller=Get.find<RecentController>();
  return DataRow(

    cells: [

      DataCell(




          Text(fileInfo?.word??""),



      ),
      DataCell(Text(fileInfo?.engDefinition??"")),

      DataCell(Text("${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}")),
      DataCell(
     fileInfo?.isVerified==true? IconButton(icon: Icon(Icons.check,color: Colors.green,),onPressed: (){


     },):  Row(
          children:
          [
        IconButton(onPressed: ()async{

await controller.myAction(fileInfo,true);
          BotToast.showText(text: "Verified");

          controller.update();
        }, icon: Icon(Icons.check)),
  IconButton(onPressed: (){
   // BotToast.showSimpleNotification(title: "init",align: Alignment.bottomCenter,backgroundColor: Colors.red);
    BotToast.showText(text: "Rejected",contentColor: Colors.red);
    controller.update();

  }, icon: Icon(Icons.cancel,color: Colors.red,)),
  ])

  ),
      DataCell(


          Icon(Icons.edit),
      onTap: (){
controller.updateWord(fileInfo!);

      }
      )

    ],
  );
}
