part of '../customer_profile_screen.dart';

class _ProfilePic extends StatelessWidget {
  final String name;
  const _ProfilePic(this.name);

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text;
    return InkWell(
      child: CircleAvatar(
        radius: 10.w,
        backgroundColor: color.primary,
        child: AutoSizeText(
          name.characters.first,
          style: text.titleMedium?.copyWith(
              color: color.onPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 28.sp),
        ),
      ),
    );
  }
}
