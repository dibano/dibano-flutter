import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  bool hasInfo = false;
  Function()? onInfoPressed;

  CustomAppBar({
    super.key,
    required this.title,
    this.hasInfo = false,
    this.onInfoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(title, style: const TextStyle(color: Colors.white)),
          centerTitle: true,
          actions: <Widget>[
            if (hasInfo)
              IconButton(
                icon: const Icon(Icons.info),
                onPressed:
                    onInfoPressed ??
                    () {
                      // Do nothing
                    },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
