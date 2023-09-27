import 'package:fchat/src/widgets/fchat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../fchat.dart';

class FChatMessages extends StatefulWidget {
  final List<MessageModel> messages;

  /// Represents the current user
  final UserModel user;

  const FChatMessages({
    super.key,
    required this.messages,
    required this.user,
  });

  @override
  State<FChatMessages> createState() => _FChatMessagesState();
}

class _FChatMessagesState extends State<FChatMessages>
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getKeyboardVisibility();
  }

  @override
  void didChangeMetrics() {
    // Scroll to bottom when the metrics
    // change (keyboard open/close)
    if (_isKeyboardVisible && _scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }
  }

  /// Get keyboard visibility using [KeyboardVisibilityController]
  /// and set [_isKeyboardVisible] to true or false
  void _getKeyboardVisibility() {
    KeyboardVisibilityController().onChange.listen((bool isVisible) {
      if (mounted) {
        setState(() {
          _isKeyboardVisible = isVisible;
        });
      }
    });
  }

  /// Scroll to bottom of the list
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Builder(
        builder: (context) {
          // Scroll to bottom after loading messages
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });

          if (widget.messages.isEmpty) {
            return const Center(
              child: Text('No messages'),
            );
          }

          return ListView.separated(
            controller: _scrollController,
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              MediaQuery.of(context).size.height * .15,
            ),
            itemCount: widget.messages.length,
            itemBuilder: (context, index) {
              final message = widget.messages[index];
              return FChatBubble(
                message: message,
                user: widget.user,
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
