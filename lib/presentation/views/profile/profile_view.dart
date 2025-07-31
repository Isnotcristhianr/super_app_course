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
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Column(
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
          listaPerfil(title: "Nombre", icon: Icons.person),
          FormField(
            builder: (context) {
              return TextField(
                decoration: InputDecoration(labelText: "Nombre"),
                controller: nameController,
              );
            },
          ),
          SizedBox(height: 20),

          SizedBox(height: 20),
          ListTile(leading: Icon(Icons.phone), title: Text("Teléfono")),
          FormField(
            builder: (context) {
              return TextField(
                decoration: InputDecoration(labelText: "Teléfono"),
                controller: phoneController,
              );
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              profilecontroller.updateProfile(
                nameController.text,
                phoneController.text,
              );
            },
            child: Text(
              "Actualizar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
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
