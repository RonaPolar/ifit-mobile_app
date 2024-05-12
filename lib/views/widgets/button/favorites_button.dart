import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    required this.onPressed,
    required this.favorite,
    super.key,
  });

  final Function() onPressed;
  final bool favorite;

  @override
  Widget build(BuildContext context) {

    return TextButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Make sure the row takes the minimum required space
        children: [
          Icon(
            favorite
                ? FluentSystemIcons.ic_fluent_heart_filled // Filled heart when liked
                : FluentSystemIcons.ic_fluent_heart_regular, // Regular heart when not liked
            size: 20,
            color: favorite ? Colors.red : Colors.black, // Red when liked, black when not liked
          ),
          const SizedBox(width: 4), // Add some spacing between icon and text
          Text(
            favorite ? 'Remove from Favorites' : 'Add to Favorites',
            style: Styles.text15normal.copyWith(
              color: favorite ? Colors.red : Colors.black, // Match the color of the icon
              fontSize: 14, // You can adjust the font size as needed
            ),
          ),
        ],
      ),
    );
  }
}
