import 'package:get/get.dart';
import 'package:firebase_ai/firebase_ai.dart';
import "../../../data/models/ia_chat_model.dart";

class ChatIaController extends GetxController {
  //variables
  final RxString message = ''.obs;
  final RxString response = ''.obs;
  final RxString lastMessage = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<IaChatModel> chatHistory = <IaChatModel>[].obs;

  // Initialize the Vertex AI Gemini API backend service
  // Create a `GenerativeModel` instance with a model that supports your use case
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
  );

  // Provide a prompt that contains text
  final prompt = [
    Content.text(
      'Eres un chatbot que responde preguntas sobre la app de venta de productos de tecnologia',
    ),
  ];

  //metodos
  Future<String> sendMessage(String message) async {
    try {
      isLoading.value = true;

      //1. agregar el mensaje del usuario al historial
      chatHistory.add(
        IaChatModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          lastMessage: message,
          timestamp: DateTime.now(),
          isUser: true,
        ),
      );

      //2. obtener la respuesta de la IA
      final response = await model.generateContent(prompt);
      final responseText = response.text;

      //3. agregar la respuesta de la IA al historial
      chatHistory.add(
        IaChatModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          lastMessage: responseText ?? "No hay respuesta",
          timestamp: DateTime.now(),
          isUser: false,
        ),
      );

      //4. actualizar el ultimo mensaje
      lastMessage.value = responseText ?? "No hay respuesta";
      isLoading.value = false;

      return responseText ?? "No hay respuesta";
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
      return "No hay respuesta";
    }
  }

  // Método para obtener el historial de chat
  List<IaChatModel> getChatHistory() {
    return chatHistory.toList();
  }

  // Método para limpiar el historial
  void clearChatHistory() {
    chatHistory.clear();
  }

  // Método para obtener el último mensaje
  String getLastMessage() {
    return lastMessage.value;
  }

  // Método para verificar si está cargando
  bool getIsLoading() {
    return isLoading.value;
  }
}
