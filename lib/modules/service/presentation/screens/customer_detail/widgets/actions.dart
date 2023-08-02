part of '../servis_customer_detail_screen.dart';

class _Actions extends StatelessWidget {
  final ServisStatusData servisStatusData;
  const _Actions({required this.servisStatusData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.color.surface,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: .5,
                offset: Offset(0.0, 0), //(x,y)
                blurRadius: .2,
              ),
            ],
          ),
          child: _ActionButton(servisStatusData: servisStatusData),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final ServisStatusData servisStatusData;
  const _ActionButton({super.key, required this.servisStatusData});

  @override
  Widget build(BuildContext context) {
    final servisStatusData = this.servisStatusData;
    switch (servisStatusData) {
      case ServisStatusUnitKonfirmasiServis():
        return _ActionKonfirmasi(data: servisStatusData);
      default:
        return const SizedBox();
    }
  }
}
