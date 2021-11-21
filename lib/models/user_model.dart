

class UserModel {
  String? id;
  String? name;
  String? email;
  bool? isAdmin;

  UserModel(
      {this.id,
        this.name,
      this.email,
        this.isAdmin,

      });
  UserModel.fromJson(Map data, String userId, ) {
    id = userId;
    name = data['name'];
    email = data['email'];
    isAdmin=data["isAdmin"];



  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'isAdmin': isAdmin,

    };
  }
}

