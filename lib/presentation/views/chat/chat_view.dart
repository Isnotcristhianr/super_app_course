import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import '../../../bloc/controllers/chat_ia_controller.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  ChatViewState createState() => ChatViewState();
}

class ChatViewState extends State<ChatView> {
  late InMemoryChatController _chatController;
  final ChatIaController _iaController = Get.put(ChatIaController());

  @override
  void initState() {
    super.initState();
    _chatController = InMemoryChatController();
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat IA'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _iaController.clearChatHistory();
              // Limpiar mensajes del chat
              _chatController.dispose();
              setState(() {
                _chatController = InMemoryChatController();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Chat(
              chatController: _chatController,
              currentUserId: 'user',
              onMessageSend: (text) async {
                // Insertar mensaje del usuario
                _chatController.insertMessage(
                  TextMessage(
                    id: '${Random().nextInt(1000) + 1}',
                    authorId: 'user',
                    createdAt: DateTime.now().toUtc(),
                    text: text,
                  ),
                );

                // Enviar mensaje a la IA y obtener respuesta
                final response = await _iaController.sendMessage(text);

                // Insertar respuesta de la IA
                _chatController.insertMessage(
                  TextMessage(
                    id: '${Random().nextInt(1000) + 1001}',
                    authorId: 'ia',
                    createdAt: DateTime.now().toUtc(),
                    text: response,
                  ),
                );
              },
              resolveUser: (UserID id) async {
                if (id == 'user') {
                  return User(id: id, name: 'Usuario');
                } else {
                  return User(id: id, name: 'IA Asistente');
                }
              },
            ),
          ),
          // Indicador de carga
          Obx(() {
            if (_iaController.isLoading.value) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 16),
                    Text('IA pensando...'),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
