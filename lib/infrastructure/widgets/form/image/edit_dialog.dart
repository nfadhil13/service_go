part of 'image_picker.dart';

enum _EditDialogResult {
  changePhoto,
  seePreview,
  deletePhoto;
}

class _EditImageDialog extends StatelessWidget {
  const _EditImageDialog({super.key});

  static Future<_EditDialogResult?> show(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return const SGDialogContainer(
            maxHeightPercentage: .85,
            child: SingleChildScrollView(child: _EditImageDialog()));
      },
    );
    if (result is _EditDialogResult) return result;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => context.router.pop(_EditDialogResult.changePhoto),
            child: Column(
              children: [
                14.verticalSpace,
                const _EditItem(
                    icon: Icons.camera_alt_outlined, text: "Change Photo"),
                14.verticalSpace,
              ],
            ),
          ),
          Divider(
            color: context.color.outline,
          ),
          InkWell(
            onTap: () => context.router.pop(_EditDialogResult.seePreview),
            child: Column(
              children: [
                14.verticalSpace,
                const _EditItem(
                    icon: Icons.image_outlined, text: "See Preview"),
                14.verticalSpace
              ],
            ),
          ),
          Divider(
            color: context.color.outline,
          ),
          InkWell(
            onTap: () => context.router.pop(_EditDialogResult.deletePhoto),
            child: Column(
              children: [
                14.verticalSpace,
                const _EditItem(icon: Icons.delete, text: "Delete Image"),
                14.verticalSpace
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _EditItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _EditItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        Text(
          text,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
