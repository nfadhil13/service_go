part of '../bengkel_profile_screen.dart';

class _ProfilePic extends StatelessWidget {
  final SGImage image;
  const _ProfilePic(this.image);

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    return InkWell(
      child: CircleAvatar(
        radius: 10.w,
        backgroundColor: color.outline,
        foregroundImage: image.provider,
      ),
    );
  }
}
