import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  //varibles
  final RxString name = "".obs;
  final RxString email = "".obs;
  final RxString phone = "".obs;
  final RxString address = "".obs;
  final RxString city = "".obs;
  final RxString state = "".obs;
  final RxString zipCode = "".obs;
  final RxString country = "".obs;
  final RxString dni = "".obs;

  //metodos
  Future<void> getProfileUid() async {
    try {
      //1. obtener el uid del usuario
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        //2. obtener el usuario
        final userdb = FirebaseFirestore.instance.collection("users");
        final user = await userdb.doc(uid).get();
        if (user.exists) {
          //3. obtener los datos del usuario
          final data = user.data();
          name.value = data?["name"] ?? "";
          email.value = data?["email"] ?? "";
          phone.value = data?["phone"] ?? "";
          address.value = data?["address"] ?? "";
          city.value = data?["city"] ?? "";
          state.value = data?["state"] ?? "";
          zipCode.value = data?["zipCode"] ?? "";
          country.value = data?["country"] ?? "";
          dni.value = data?["dni"] ?? "";
          debugPrint("name: ${name.value}");
          debugPrint("email: ${email.value}");
          debugPrint("phone: ${phone.value}");
          debugPrint("address: ${address.value}");
          debugPrint("city: ${city.value}");
          debugPrint("state: ${state.value}");
          debugPrint("zipCode: ${zipCode.value}");
          debugPrint("country: ${country.value}");
          debugPrint("dni: ${dni.value}");
        }
      } else {
        debugPrint("No hay usuario autenticado");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //actualizar perfil
  Future<void> updateProfile(
    String name,
    String phone,
    String address,
    String city,
    String state,
    String zipCode,
    String country,
    String dni,
  ) async {
    try {
      //1. obtener uid
      final uid = FirebaseAuth.instance.currentUser?.uid;

      //2. actualizar
      final userdb = FirebaseFirestore.instance.collection("users");
      await userdb.doc(uid).update({
        "name": name,
        "phone": phone,
        "address": address,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "country": country,
        "dni": dni,
      });
      debugPrint("Perfil actualizado correctamente");
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
