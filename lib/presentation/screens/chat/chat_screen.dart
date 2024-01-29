import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_providers.dart';
import 'package:yes_no_app/presentation/screens/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/screens/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/screens/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, Key? customKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0), // Ajuste de margen izquierdo
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://media-bog1-1.cdn.whatsapp.net/v/t61.24694-24/421098546_1393597108194765_4758174830743289655_n.jpg?ccb=11-4&oh=01_AdQpFNrtLpZ-X5xvr0EfUNvtTmjqAcy28pgfhNnGnKVWZw&oe=65BE436F&_nc_sid=e6ed6c&_nc_cat=108',
            ),
          ),
        ),
        title: const Text(
          'Mi amor ♥️',
          style: TextStyle(fontSize: 18), // Tamaño de fuente ajustado
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, size: 24), // Tamaño de icono ajustado
            onPressed: () {
              _showSnackBar(context, 'Llamando...');
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam, size: 24), // Tamaño de icono ajustado
            onPressed: () {
              _showSnackBar(context, 'Iniciando videollamada...');
            },
          ),
        ],
      ),
      body: _ChatView(),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false, // Cambiado a false para que vaya de arriba hacia abajo
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];

                return (message.fromWho == FromWho.hers)
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: HerMessageBubble(message: message),
                      )
                    : Align(
                        alignment: Alignment.topRight,
                        child: MyMessageBubble(message: message),
                      );
              },
            ),
          ),

          /// Caja de texto de mensajes
          MessageFieldBox(
            // onValue: (value) => chatProvider.sendMessage(value),
            onValue: chatProvider.sendMessage,
          ),
        ],
      ),
    );
  }
}
