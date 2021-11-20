

// class UserModel {
//   String? id;
//   String? name;
//   String? lastName;
//   String? phoneNumber;
//   String? email;
//   bool? isSelected;
//   String? imageUrl;
//   Round? round;
//   List<String>? invations;
//
//   UserModel(
//       {this.id,
//         this.name,
//         this.phoneNumber,
//         this.email,
//         this.isSelected,
//         this.lastName,
//         this.imageUrl,
//         this.round,
//         this.invations
//
//       });
//   UserModel.fromJson(Map data, String id, {bool? isSelect = false}) {
//     this.id = id;
//     name = data['name'];
//     phoneNumber = data['phoneNumber'];
//     email = data['email'];
//     round = this.round == null ? null : Round.fromJson(data["round"]);
//     imageUrl = data["imageUrl"] ?? null;
//     lastName = data["lastName"] ?? null;
//     invations=data["invations"]!=null?List.from(data["invations"]):null;
//
//
//     isSelected = isSelect;
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'email': email,
//       'phoneNumber': this.phoneNumber,
//       'lastName': this.lastName ?? null,
//       'imageUrl': this.imageUrl,
//       'round': this.round ?? null,
//       'invations':this.invations??null,
//     };
//   }
// }
class Word {
  String? id;

  String? lisuDefinition;
  String? engDefinition;
  String? burmerDefinition;
  List<String>? engExamples;
  List<String>? lisuExamples;

  List<String>? burmerExamples;
  String? word;
  bool? isVerified;

  Word({
    this.id,
    this.isVerified,
    this.engDefinition,
    this.burmerDefinition,
    this.engExamples,
    this.burmerExamples,
    this.lisuDefinition,
    this.word,
    this.lisuExamples});


  Word.fromJson(Map data, String wordId,) {
    id=wordId;
    isVerified = data["isVerified"];
    engDefinition = data["engDefinition"];
    engExamples =
    data["engExamples"] != null ? List.from(data["engExamples"]) : null;
    lisuDefinition = data["lisuDefinition"];
    lisuExamples =
    data["lisuExamples"] != null ? List.from(data["lisuExamples"]) : null;

    burmerDefinition = data["burmerDefinition"] ?? "";
    burmerExamples =
    data["burmerExamples"] != null ? List.from(data["burmerExamples"]) : null;
  }

  Map<String, dynamic> toMap() {
    return {
      'isVerified': isVerified,
      'engDefinition':engDefinition,
      'engExamples': engExamples ?? null,
      'lisuDefinition': lisuDefinition??"",
      'lisuExamples':lisuExamples??null,

      'burmerDefinition':burmerDefinition??"",
      'burmerExamples':burmerExamples??null,

    };
  }
}
