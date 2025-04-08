import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasInfo;
  final Function()? onInfoPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.hasInfo = false,
    this.onInfoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading:
              Navigator.canPop(context)
                  ? IconButton(
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(32, 0, 77, 0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF004d00),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                  : null,
          iconTheme: const IconThemeData(color: Color(0xFF004d00)),
          title: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF004d00),
              fontSize: 26,
              fontFamily: 'Poppins',
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            if (hasInfo)
              IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(32, 0, 77, 0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(Icons.info, color: Color(0xFF004d00)),
                ),
                onPressed: onInfoPressed ?? () {},
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
