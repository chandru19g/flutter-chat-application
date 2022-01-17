import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserDao extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  String? userId() {
    return auth.currentUser?.uid;
  }

  String? email() {
    return auth.currentUser?.email;
  }

  void signup(String email, String password, BuildContext context) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showError(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showError(context, 'The account already exists for that email.');
      } else {
        showError(context, e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  void login(String email, String password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showError(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showError(context, 'The account already exists for that email.');
      } else {
        showError(context, e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    await auth.signOut();
    notifyListeners();
  }

  showError(BuildContext context, errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            )
          ],
        );
      },
    );
  }
}
