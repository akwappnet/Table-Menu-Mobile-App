
class UserModel {
  String name;
  String email;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;
  String customerReview;
  String customerRating;

  UserModel({
    required this.name,
    required this.email,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
    required this.customerRating,
    required this.customerReview
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> firestore) {
    return UserModel(
      name: firestore['name'] ?? '',
      email: firestore['email'] ?? '',
      uid: firestore['uid'] ?? '',
      phoneNumber: firestore['phoneNumber'] ?? '',
      createdAt: firestore['createdAt'] ?? '',
      profilePic: firestore['profilePic'] ?? '',
      customerRating: firestore['customerRating'] ?? '',
      customerReview: firestore['customerReview'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "customerRating": customerRating,
      "customerReview": customerReview,
    };
  }
}