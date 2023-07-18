import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/infrastructure/widgets/image/image_picker.dart';
import 'package:service_go/infrastructure/ext/sg_image_ext.dart';
import 'package:service_go/infrastructure/widgets/image/image_preview.dart';
import 'package:service_go/infrastructure/widgets/layouts/dialog/dialog_container.dart';

part 'child.dart';
part 'edit_dialog.dart';

class SGImagePickerField extends StatefulWidget {
  final double width;
  final double height;
  final SGImage? initialImage;
  final BoxShape shape;
  final String? Function(SGImage? value)? validator;
  final SGImagePickerController? controller;
  const SGImagePickerField(
      {super.key,
      this.width = 84,
      this.height = 84,
      this.shape = BoxShape.circle,
      this.initialImage,
      this.controller,
      this.validator});

  @override
  State<SGImagePickerField> createState() => _SGImagePickerFieldState();
}

class SGImagePickerController {
  _SGImagePickerFieldState? _state;

  _init(_SGImagePickerFieldState state) {
    _state = state;
  }

  SGImage? get value => _state?.image;

  void dispose() {
    _state = null;
  }
}

class _SGImagePickerFieldState extends State<SGImagePickerField> {
  SGImage? image;

  @override
  void initState() {
    super.initState();
    widget.controller?._init(this);
    image = widget.initialImage;
  }

  void _onClick() {
    final image = this.image;
    if (image == null) {
      _pickImage();
      return;
    }
    _seeImagePreview(image);
  }

  void _pickImage() async {
    final result = await SGImagePickerDialog.pickImage(context);
    if (result == null) return;
    setState(() {
      image = SGFileImage(result.path);
    });
  }

  void _deleteImage() async {
    image = null;
    setState(() {});
  }

  void _seeImagePreview(SGImage image) async {
    final result = await _EditImageDialog.show(context);
    if (result == null) return;
    switch (result) {
      case _EditDialogResult.changePhoto:
        _pickImage();
        break;
      case _EditDialogResult.deletePhoto:
        _deleteImage();
        break;
      case _EditDialogResult.seePreview:
        // ignore: use_build_context_synchronously
        SGImagePreview.asFullScreenDialog(context, image);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final decoration =
        BoxDecoration(shape: widget.shape, color: color.outlineVariant);
    return FormField<SGImage>(
      validator: (_) {
        return widget.validator?.call(image);
      },
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _onClick,
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: decoration.copyWith(
                  image: image != null
                      ? DecorationImage(
                          image: image!.provider, fit: BoxFit.cover)
                      : null),
              child: image == null
                  ? const _AddImage()
                  : _ImageAdded(
                      decoration: decoration.copyWith(
                          color: Colors.black.withOpacity(.3))),
            ),
          ),
          if (field.hasError)
            Text(
              field.errorText!,
              style:
                  context.text.bodySmall?.copyWith(color: context.color.error),
            )
        ],
      ),
    );
  }
}
