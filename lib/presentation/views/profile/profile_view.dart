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
  }

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
          listaPerfil(title: "Nombre", icon: Icons.person),
          FormField(
            builder: (context) {
              return TextField(
                decoration: InputDecoration(labelText: "Nombre"),
                controller:
                    profilecontroller.name != null
                        ? TextEditingController(
                          text: profilecontroller.name.value,
                        )
                        : null,
              );
            },
          ),
          SizedBox(height: 20),
          listaPerfil(title: "Email", icon: Icons.mail),
          FormField(
            builder: (context) {
              return TextField(
                decoration: InputDecoration(labelText: "Email"),
                controller:
                    profilecontroller.email != null
                        ? TextEditingController(
                          text: profilecontroller.email.value,
                        )
                        : null,
              );
            },
          ),
          SizedBox(height: 20),
          ListTile(leading: Icon(Icons.phone), title: Text("Teléfono")),
          FormField(
            builder: (context) {
              return TextField(
                decoration: InputDecoration(labelText: "Teléfono"),
                controller:
                    profilecontroller.phone != null
                        ? TextEditingController(
                          text: profilecontroller.phone.value,
                        )
                        : null,
              );
            },
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
