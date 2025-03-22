import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../../../../utils/constants/colors.dart';

class ProfileMenuWidget extends StatelessWidget {
  ProfileMenuWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPress,
      required this.endIcon,
      this.textColor});

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  bool endIcon = true;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;
    return ListTile(
      onTap: onPress,
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: iconColor.withOpacity(0.1)),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(LineAwesomeIcons.angle_right_solid,
                  size: 18.0, color: Colors.grey),
            )
          : null,
    );
  }
}
