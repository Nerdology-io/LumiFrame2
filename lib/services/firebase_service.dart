import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/Get.dart';
import 'dart:io';

class FirebaseService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      Get.snackbar('Error', 'Sign-in failed: $e');
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    Get.snackbar('Info', 'Google Sign-In not implemented yet.');
    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<String?> uploadMedia(String path, String fileName) async {
    if (currentUser == null) return null;
    final ref = _storage.ref('users/${currentUser!.uid}/media/$fileName');
    final uploadTask = ref.putFile(File(path));
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> syncSettings(Map<String, dynamic> settings) async {
    if (currentUser != null) {
      await _firestore.collection('users').doc(currentUser!.uid).set(settings, SetOptions(merge: true));
    }
  }
}