part of '../../servis_bengkel_detail_screen.dart';

class _ActionDitolak extends StatefulWidget {
  final String alasanPenolakan;
  const _ActionDitolak({super.key, required this.alasanPenolakan});

  @override
  State<_ActionDitolak> createState() => _ActionDitolakState();
}

class _ActionDitolakState extends State<_ActionDitolak> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text;
    return Container(
      decoration: BoxDecoration(
          color: color.error.withOpacity(.08),
          border: Border.all(color: color.error),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: InkWell(
          onTap: () => setState(() {
            _isOpen = !_isOpen;
          }),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Alasan Penolakan",
                      style: text.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Icon(_isOpen ? Icons.arrow_drop_down : Icons.arrow_drop_up)
                ],
              ),
              if (_isOpen) 8.verticalSpace,
              if (_isOpen)
                Text(
                  widget.alasanPenolakan,
                  style:
                      text.bodySmall?.copyWith(color: context.color.onSurface),
                )
            ],
          ),
        ),
      ),
    );
  }
}
