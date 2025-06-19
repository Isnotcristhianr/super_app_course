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
  final Rx<String> userName = ''.obs;
  final Rx<String> userEmail = ''.obs;
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

  void _initializeAuth() {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        userName.value = currentUser.displayName ?? '';
        userEmail.value = currentUser.email ?? '';
        userProfilePictureUrl.value = currentUser.photoURL ?? '';
        userDni.value = '';
        userPhoneNumber.value = '';
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }
}
