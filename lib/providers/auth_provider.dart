import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _user;

  UserModel? get user => _user;
  bool get isAuthenticated => _auth.currentUser != null;

  // Connexion utilisateur
  Future<void> signIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = await FirestoreService().getUser(credential.user!.uid);
      notifyListeners();
    } catch (e) {
      throw Exception("Échec de la connexion: ${e.toString()}");
    }
  }

  // Inscription utilisateur
  Future<void> signUp(String name, String email, String password, String phone) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = UserModel(
        uid: credential.user!.uid,
        name: name,
        email: email,
        phoneNumber: phone,
      );
      await FirestoreService().saveUser(_user!);
      notifyListeners();
    } catch (e) {
      throw Exception("Échec de l'inscription: ${e.toString()}");
    }
  }

  // Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
