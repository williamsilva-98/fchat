import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FChatInput extends StatefulWidget {
  final Function(String) onSend;

  const FChatInput({
    super.key,
    required this.onSend,
  });

  @override
  State<FChatInput> createState() => _FChatInputState();
}

class _FChatInputState extends State<FChatInput> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _isReadyToSend = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                maxLines: 5,
                minLines: 1,
                textInputAction: TextInputAction.done,
                controller: _controller,
                onChanged: (value) {
                  if (value.isNotEmpty && value.trim().isNotEmpty) {
                    _isReadyToSend.value = true;
                  } else {
                    _isReadyToSend.value = false;
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  hintText: 'Digite aqui...',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      PhosphorIcons.regular.paperclip,
                      color: Color(0xFF333333),
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      // Check if the text field is not empty
                      if (_controller.text.trim().isNotEmpty) {
                        // Send the message to the callback
                        widget.onSend(_controller.text);

                        // Clear the text field
                        _controller.clear();

                        // Reset the button state
                        _isReadyToSend.value = false;
                      }
                    },
                    icon: AnimatedBuilder(
                        animation: _isReadyToSend,
                        builder: (context, snapshot) {
                          return Icon(
                            _isReadyToSend.value
                                ? PhosphorIcons.fill.paperPlaneTilt
                                : PhosphorIcons.regular.paperPlaneTilt,
                            color: Theme.of(context).colorScheme.primary,
                          );
                        }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
