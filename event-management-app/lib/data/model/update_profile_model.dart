class UpdateProfile {
   String? name;
   String? phone;
   String? email;
   String? dateOfBirth;
   String? nidNo;
   String? passportNo;

   UpdateProfile({this.name, this.phone, this.email, this.dateOfBirth, this.nidNo,
      this.passportNo});

   Map<String, dynamic> toJson() =>{
     'name':name,
     'phone':phone,
     'email':email,
     'date_of_birth':dateOfBirth,
     'nid':nidNo,
     'passport':passportNo
   };
}

class UpdatePassword{
   String? oldPassword;
   String? password;
   String? confirmPassword;

  UpdatePassword({this.oldPassword, this.password, this.confirmPassword});

  Map<String,dynamic> toJson() =>{
    'old_password':oldPassword,
    'new_password':password,
  };
}