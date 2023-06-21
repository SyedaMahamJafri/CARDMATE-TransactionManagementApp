import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/screens/update/model/updateModel.dart';

class UpdateUIRepository {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserByUid(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size > 0) {
        return querySnapshot.docs.first;
      } else {
        throw Exception('User not found');
      }
    });
  }

  updateUser(String uid, UpdateUserModel updatedUser) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (updatedUser.email != user?.email && updatedUser.password.length >= 6) {
      await user
          ?.updateEmail(updatedUser.email)
          .then((value) => {
                user.updatePassword(updatedUser.password),
                print("User email updated successfully!")
              })
          .onError((error, stackTrace) => {
                print("Failed to update user email: $error"),
                updatedUser.email = user.email!
              });
    } else if (updatedUser.password.length > 6) {
      await user?.updatePassword(updatedUser.password);
    } else {
      await user?.updateEmail(updatedUser.email);
    }

    return FirebaseFirestore.instance.collection('users').doc(uid).update({
      'firstName': updatedUser.firstName,
      'lastName': updatedUser.lastName,
      'phoneNumber': updatedUser.phoneNumber,
    });
  }

  deleteUser() {
    FirebaseAuth.instance.currentUser?.delete();
    // FirebaseFirestore.instance.collection('users').doc(user?.uid).delete();
    // return FirebaseAuth.instance.currentUser?.delete();
  }
}
