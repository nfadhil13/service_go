import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/form/field_desc.dart';
import 'package:service_go/infrastructure/widgets/image/image_carousel.dart';
import 'package:service_go/infrastructure/widgets/image/image_picker_with_preview.dart';

class SGMultiImageField extends StatefulWidget {
  final List<SGImage> initialImages;
  final SGMultiImageFieldController? controller;
  final String? label;
  final double imageSize;
  final bool readOnly;
  final String? desc;
  final String? Function(List<SGImage> result)? validator;
  const SGMultiImageField(
      {super.key,
      this.imageSize = 64,
      this.desc,
      this.initialImages = const [],
      this.label,
      this.readOnly = false,
      this.controller,
      this.validator});

  @override
  State<SGMultiImageField> createState() => _SGMultiImageFieldState();
}

class SGMultiImageFieldController extends ValueNotifier<List<SGImage>> {
  SGMultiImageFieldController({List<SGImage> initialValue = const []})
      : super(initialValue);
}

class _SGMultiImageFieldState extends State<SGMultiImageField> {
  late final SGMultiImageFieldController _controller;
  List<SGImage> _images = [];

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? SGMultiImageFieldController();
    _controller.addListener(_imageChangeListener);
    _controller.value = widget.initialImages;
  }

  @override
  void dispose() {
    _controller.removeListener(_imageChangeListener);
    super.dispose();
  }

  void _imageChangeListener() {
    setState(() {
      _images = _controller.value;
    });
  }

  void _pickImage() async {
    final images = await SGImagePickerWithPreview.pickImages(context);
    if (images.isEmpty) return;
    _controller.value = [
      ...images.map((e) => SGFileImage(e.path)),
      ..._controller.value
    ];
  }

  void _showAllImage(BuildContext context, {int startingIndex = 0}) async {
    ImagesCarousel.showAsDialog(context,
        startingIndex: startingIndex,
        imageList: _images
            .map((e) => ImageCarouselData(provider: e.provider))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text;
    final desc = widget.desc;
    return FormField(
      validator: (_) {
        return widget.validator?.call(_images);
      },
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.label ?? "",
            style: text.titleSmall,
          ),
          6.verticalSpace,
          Container(
            width: double.infinity,
            height: widget.imageSize * 4 / 3,
            decoration: BoxDecoration(
              color: _images.isEmpty ? color.outline.withOpacity(.1) : null,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.outline),
            ),
            child: _images.isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SGElevatedButton(
                        fillParent: false,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        label: "Tambah Gambar",
                        onPressed: _pickImage,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _images
                                  .mapIndexed((i, e) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: GestureDetector(
                                          onTap: () => _showAllImage(context,
                                              startingIndex: i),
                                          child: Container(
                                            width: widget.imageSize,
                                            height: widget.imageSize,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: .1,
                                                    blurRadius: 6,
                                                    offset: const Offset(0,
                                                        0), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                image: DecorationImage(
                                                    image: e.provider,
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                      if (!widget.readOnly)
                        InkWell(
                          onTap: _pickImage,
                          child: Container(
                            decoration: BoxDecoration(
                                color: color.surface,
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(20),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(-1, 0),
                                  ),
                                ]),
                            padding: const EdgeInsets.symmetric(horizontal: 9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                                Text(
                                  "Tambah",
                                  style: text.bodySmall
                                      ?.copyWith(color: color.onSurface),
                                )
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
          ),
          if (field.hasError)
            Text(
              field.errorText!,
              style: text.bodySmall?.copyWith(color: color.error),
            ),
          if (desc != null) SGFieldDesc(desc: desc)
        ],
      ),
    );
  }
}
