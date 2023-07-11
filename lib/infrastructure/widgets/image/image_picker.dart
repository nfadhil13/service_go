import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/widgets/layouts/bottomsheet/bottom_sheet_container.dart';
import 'package:service_go/infrastructure/widgets/layouts/dialog/dialog_container.dart';

class SGImagePickerDialog {
  const SGImagePickerDialog._();

  static Future<XFile?> pickImage(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return const SGDialogContainer(
            maxHeightPercentage: .85,
            child: SingleChildScrollView(child: _ImagePickerContent()));
      },
    );
    if (result is XFile?) return result;
    return null;
  }

  static Future<List<XFile>> pickImages(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return const SGDialogContainer(
            maxHeightPercentage: .85,
            child: SingleChildScrollView(child: _ImageMultiplePickerContent()));
      },
    );
    if (result is List<XFile>) return result;
    return [];
  }

  static hanldeImage(BuildContext context,
      {required final VoidCallback onChange,
      required final VoidCallback onRemove,
      required final VoidCallback onImagePreview}) async {
    await SGBottomSheetContainer.showBottomSheet(
        context, _HandleImageContent(onChange, onRemove, onImagePreview));
  }
}

class _HandleImageContent extends StatelessWidget {
  final VoidCallback onChange;
  final VoidCallback onRemove;
  final VoidCallback onImagePreview;
  const _HandleImageContent(this.onChange, this.onRemove, this.onImagePreview);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: onImagePreview,
          child: const _ImagePickerType(icon: Icons.preview, text: "Preview"),
        ),
        InkWell(
            onTap: onChange,
            child: const _ImagePickerType(
                icon: Icons.change_circle_outlined, text: "Change")),
        InkWell(
            onTap: onRemove,
            child: const _ImagePickerType(
                icon: Icons.delete_outline, text: "Remove"))
      ],
    );
  }
}

class _ImagePickerContent extends StatelessWidget {
  const _ImagePickerContent();

  void _pickImage(ImageSource imageSource, BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final router = context.router;
    final XFile? result = await picker.pickImage(source: imageSource);
    router.pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          InkWell(
            child: const _ImagePickerType(
                icon: Icons.camera_alt_outlined, text: "Take Photo"),
            onTap: () {
              _pickImage(ImageSource.camera, context);
            },
          ),
          Divider(color: context.color.outlineVariant),
          InkWell(
              child: const _ImagePickerType(
                  icon: Icons.image_outlined, text: "From Gallery"),
              onTap: () {
                _pickImage(ImageSource.gallery, context);
              })
        ],
      ),
    );
  }
}

class _ImageMultiplePickerContent extends StatelessWidget {
  const _ImageMultiplePickerContent();

  void _takePhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final router = context.router;
    final XFile? result = await picker.pickImage(source: ImageSource.camera);
    if (result is XFile) {
      router.pop([result]);
      return;
    }
    router.pop([]);
  }

  void _pickImages(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final router = context.router;
    final List<XFile> result = await picker.pickMultiImage();
    router.pop(result);
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
            onTap: () => _takePhoto(context),
            child: Column(
              children: [
                14.verticalSpace,
                const _ImagePickerType(
                    icon: Icons.camera_alt_outlined, text: "Take Photo"),
                14.verticalSpace,
              ],
            ),
          ),
          Divider(
            color: context.color.outline,
          ),
          InkWell(
            onTap: () => _pickImages(context),
            child: Column(
              children: [
                14.verticalSpace,
                const _ImagePickerType(
                    icon: Icons.image_outlined, text: "From Gallery"),
                14.verticalSpace
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ImagePickerType extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ImagePickerType({required this.icon, required this.text});

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
