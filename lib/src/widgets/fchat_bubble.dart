import 'package:fchat/src/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';

import '../../fchat.dart';

class FChatBubble extends StatelessWidget {
  final MessageModel message;

  /// Represents the current user
  final UserModel user;

  const FChatBubble({
    super.key,
    required this.message,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCurrentUser = message.author.id == user.id;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: _getMainAxisAlignment(),
          children: [
            _builUserPhoto(isCurrentUser: isCurrentUser),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .75,
                    ),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: _getBorderRadius(),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .shadow
                              .withOpacity(.05),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      message.message,
                      style: theme.textTheme.titleMedium,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            _builUserPhoto(isCurrentUser: !isCurrentUser),
          ],
        ),
        SizedBox(height: 8),
        _builMessageAuthorName(context: context),
      ],
    );
  }

  /// Returns the message hour based on the [isCurrentUser] property.
  /// If the user is the main user, it returns the author name on the right
  /// If the user is not the main user, it returns the message
  /// author name the left
  Widget _builMessageAuthorName({
    required BuildContext context,
  }) {
    final theme = Theme.of(context);

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * .75,
      ),
      child: Row(
        mainAxisAlignment: _getMainAxisAlignment(),
        children: [
          Text(
            message.author.name,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(.5),
            ),
          ),
          SizedBox(width: 4),
          Text(
            '•',
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(.5),
            ),
          ),
          SizedBox(width: 4),
          Text(
            message.date.hhmm(),
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the user photo based on the [isCurrentUser] property.
  /// If the user is the main user, it returns an empty container
  /// If the user is not the main user, it returns the user photo
  Widget _builUserPhoto({bool isCurrentUser = true}) {
    if (isCurrentUser) {
      return SizedBox.shrink();
    }

    return ClipOval(
      child: Image.network(
        message.author.photoUrl,
        width: 32,
        height: 32,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return CircleAvatar(
            child: Text(
              message.author.name[0].toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          );
        },
      ),
    );
  }

  /// Returns the main axis alignment of the bubble
  /// based on the [isCurrentUser] property
  MainAxisAlignment _getMainAxisAlignment() {
    if (message.author.id == user.id) {
      return MainAxisAlignment.end;
    } else {
      return MainAxisAlignment.start;
    }
  }

  /// Returns the border radius of the bubble
  /// based on the [isCurrentUser] property
  BorderRadius _getBorderRadius() {
    if (message.author.id == user.id) {
      return BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(2),
      );
    } else {
      return BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(2),
        bottomRight: Radius.circular(16),
      );
    }
  }
}
