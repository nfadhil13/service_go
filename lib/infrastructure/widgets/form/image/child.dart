part of 'image_picker.dart';

class _ImageAdded extends StatelessWidget {
  final BoxDecoration decoration;
  const _ImageAdded({super.key, required this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.change_circle,
            color: Colors.white,
          ),
          Text("Ubah",
              textAlign: TextAlign.center,
              style: context.text.labelSmall?.copyWith(color: Colors.white))
        ],
      ),
    );
  }
}

class _AddImage extends StatelessWidget {
  const _AddImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.add),
        Text("Tambah",
            textAlign: TextAlign.center,
            style: context.text.labelSmall?.copyWith())
      ],
    );
  }
}
