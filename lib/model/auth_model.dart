
class AuthModel {

   String? email;
   String? password;
   String? deviceType;
   String? fcmToken;

   AuthModel({this.email,this.password,this.deviceType,this.fcmToken});

   Map<String,dynamic> toJson(){
      return {
         'email' : email,
         'password' : password,
         'device_type' : deviceType,
         'fcm_token' : fcmToken
      };
   }

   AuthModel.fromJson(Map<String,dynamic> json)
       : email = json['email'],
          password = json['password'],
          deviceType = json['device_type'],
          fcmToken = json['fcm_token'];

}