import 'package:firesafe_vnex/components/widgets/clickable.dart';
import 'package:firesafe_vnex/components/widgets/zoom_dialog.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.banner, required this.avatar});

  final Widget banner;
  final Widget avatar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 53),
          child: AspectRatio(
            aspectRatio: 3 / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Clickable(
                onTap: () {
                  showZoomDialog(
                    context: context,
                    child: banner,
                  );
                },
                child: banner,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 3,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: Colors.white,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            height: 100,
            width: 100,
            child: Clickable(
              onTap: () {
                showZoomDialog(
                  context: context,
                  child: avatar,
                );
              },
              child: avatar,
            ),
          ),
        ),
      ],
    );
  }
}
