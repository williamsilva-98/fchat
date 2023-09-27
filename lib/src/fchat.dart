import 'package:fchat/fchat.dart';
import 'package:fchat/src/widgets/fchat_input.dart';
import 'package:fchat/src/widgets/fchat_messages.dart';
import 'package:flutter/material.dart';

class FChat extends StatefulWidget {
  final List<MessageModel> messages;
  final Function(String) onSend;

  /// Represents the current user
  final UserModel user;

  const FChat({
    Key? key,
    required this.messages,
    required this.onSend,
    required this.user,
  }) : super(key: key);

  @override
  State<FChat> createState() => _FChatState();
}

class _FChatState extends State<FChat> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: FChatMessages(
            messages: widget.messages,
            user: widget.user,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: FChatInput(
            onSend: widget.onSend,
          ),
        ),
      ],
    );
  }
}
