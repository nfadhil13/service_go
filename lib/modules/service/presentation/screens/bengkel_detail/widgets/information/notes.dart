part of '../../servis_bengkel_detail_screen.dart';

class _Notes extends StatefulWidget {
  final String note;
  const _Notes({super.key, required this.note});

  @override
  State<_Notes> createState() => _NotesState();
}

class _NotesState extends State<_Notes> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.color.primary.withOpacity(.08),
          border: Border.all(color: context.color.primary),
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() {
              _isOpen = !_isOpen;
            }),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Catatan",
                    style: context.text.labelLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(_isOpen ? Icons.arrow_drop_down : Icons.arrow_drop_up)
              ],
            ),
          ),
          if (_isOpen)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                widget.note.isEmpty ? "-" : widget.note,
                style: context.text.bodyMedium
                    ?.copyWith(color: context.color.onBackground),
              ),
            )
        ],
      ),
    );
  }
}
