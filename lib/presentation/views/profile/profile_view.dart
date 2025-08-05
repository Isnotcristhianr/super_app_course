import 'package:flutter/material.dart';
import 'package:get/get.dart';
//controllers
import '../../../bloc/controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController profilecontroller = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    profilecontroller.getProfileUid();

    ever(profilecontroller.email, (value) => emailController.text = value);
    ever(profilecontroller.phone, (value) => phoneController.text = value);
    ever(profilecontroller.name, (value) => nameController.text = value);
    ever(profilecontroller.address, (value) => addressController.text = value);
    ever(profilecontroller.city, (value) => cityController.text = value);
    ever(profilecontroller.state, (value) => stateController.text = value);
    ever(profilecontroller.zipCode, (value) => zipCodeController.text = value);
    ever(profilecontroller.country, (value) => countryController.text = value);
    ever(profilecontroller.dni, (value) => dniController.text = value);
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countryController = TextEditingController();
  final dniController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Editar Perfil",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            listaPerfil(
              title: "Email: ${emailController.text}",
              icon: Icons.mail,
            ),
            listaPerfil(
              title: "Nombre: ${nameController.text}",
              icon: Icons.person,
            ),
            FormField(
              builder: (context) {
                return TextField(
                  decoration: InputDecoration(labelText: "Nombre"),
                  controller: nameController,
                );
              },
            ),
            SizedBox(height: 20),
            listaPerfil(
              title: "Teléfono: ${phoneController.text}",
              icon: Icons.phone,
            ),
            FormField(
              builder: (context) {
                return TextField(
                  decoration: InputDecoration(labelText: "Teléfono"),
                  controller: phoneController,
                );
              },
            ),
            SizedBox(height: 20),
            listaPerfil(
              title: "DNI: ${dniController.text}",
              icon: Icons.person,
            ),
            FormField(
              builder: (context) {
                return TextField(
                  decoration: InputDecoration(labelText: "DNI"),
                  controller: dniController,
                );
              },
            ),
            listaPerfil(
              title: "Dirección: ${addressController.text}",
              icon: Icons.person,
            ),
            FormField(
              builder: (context) {
                return TextField(
                  decoration: InputDecoration(labelText: "Dirección"),
                  controller: addressController,
                );
              },
            ),
            listaPerfil(
              title: "Ciudad: ${cityController.text}",
              icon: Icons.person,
            ),
            FormField(
              builder: (context) {
                return TextField(
                  decoration: InputDecoration(labelText: "Ciudad"),
                  controller: cityController,
                );
              },
            ),
            listaPerfil(
              title: "Estado: ${stateController.text}",
              icon: Icons.person,
            ),
            FormField(
              builder: (context) {
                return TextField(
                  decoration: InputDecoration(labelText: "Estado"),
                  controller: stateController,
                );
              },
            ),
            listaPerfil(
              title: "Código Postal: ${zipCodeController.text}",
              icon: Icons.person,
            ),
            FormField(
              builder: (context) {
                return TextField(
                  decoration: InputDecoration(labelText: "Código Postal"),
                  controller: zipCodeController,
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                profilecontroller.updateProfile(
                  nameController.text,
                  phoneController.text,
                  addressController.text,
                  cityController.text,
                  stateController.text,
                  zipCodeController.text,
                  countryController.text,
                  dniController.text,
                );
              },
              child: Text(
                "Actualizar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class listaPerfil extends StatelessWidget {
  final String title;
  final IconData icon;

  const listaPerfil({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Icon(icon), title: Text(title));
  }
}
