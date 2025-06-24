import 'package:get/get.dart';
import 'package:flutter/material.dart';
//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//models
import '../../../data/models/user_model.dart';
//google sign in
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthController extends GetxController {
  //variables
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //user
  late String uid;
  final Rx<String> userName = ''.obs;
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  final Rx<String> userProfilePictureUrl = ''.obs;
  final Rx<String> userDni = ''.obs;
  final Rx<String> userPhoneNumber = ''.obs;
  final Rx<String> userType = ''.obs;
  final Rx<DateTime> userCreatedAt = DateTime.now().obs;
  final Rx<AuthStatus> authStatus = AuthStatus.initial.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAuth();
  }

  void _initializeAuth() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        uid = currentUser.uid;
        await _loadUserData();
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }

  Future<void> _loadUserData() async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data()!;
        userName.value = userData['name'] ?? '';
        userEmail.value = userData['email'] ?? '';
        userProfilePictureUrl.value = userData['profilePictureUrl'] ?? '';
        userDni.value = userData['dni'] ?? '';
        userPhoneNumber.value = userData['phoneNumber'] ?? '';
        userType.value = userData['type'] ?? '';
        userCreatedAt.value = (userData['createdAt'] as Timestamp).toDate();
      }
    } catch (e) {
      debugPrint("Error loading user data: ${e.toString()}");
    }
  }

  //email and password
  Future<void> loginWithEmailAndPassword(String email, String password) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await _loadUserData();
      authStatus.value = AuthStatus.authenticated;

      Get.offAllNamed('/home');

    }catch (e){
      debugPrint("Error: ${e.toString()}");
    }
  }
}
