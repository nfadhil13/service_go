part of '../list/servis_list_widget.dart';

class ServisListItem extends StatelessWidget {
  final Servis servis;
  const ServisListItem({super.key, required this.servis});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text;
    return Container(
      decoration: BoxDecoration(
          color: color.surface,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 0), //(x,y)
              blurRadius: .4,
            ),
          ],
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AutoSizeText(servis.namaMotor,
            style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: _Item(title: "Nomor Pesanan", item: servis.id.id ?? "")),
            14.horizontalSpace,
            Expanded(
                child: _Item(title: "Bengkel", item: servis.bengkel.bengkel)),
          ],
        ),
        24.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: _Item(
                    title: "Tanggal Servis",
                    item: servis.tanggalService.dateStringForm())),
            _StatusChip(status: servis.status)
          ],
        )
      ]),
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final String item;
  final CrossAxisAlignment? alignment;
  const _Item({required this.title, required this.item, this.alignment});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return Column(
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: [
        Text(title, style: text.bodySmall),
        Text(
          item,
          style: text.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final ServisStatus status;
  const _StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = ColorUtil.hexToColor(status.colorHex);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color.withOpacity(.08),
          border: Border.all(color: color)),
      child: Text(
        status.statusName,
        style: context.text.bodySmall?.copyWith(color: color),
      ),
    );
  }
}
