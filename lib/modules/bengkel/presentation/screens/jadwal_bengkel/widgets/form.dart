part of '../jadwal_bengkel_screen.dart';

class _Form extends StatefulWidget {
  final JadwalBengkel jadwal;
  const _Form({super.key, required this.jadwal});

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final GlobalKey<FormState> _formState = GlobalKey();
  late final List<(bool, SGTimeRangePickerFieldController)> _itemList;

  @override
  void initState() {
    super.initState();
    _itemList = widget.jadwal.asList.entries
        .map((e) => (
              e.value != null,
              SGTimeRangePickerFieldController(
                  initialValue: SGTimePickerData(
                      startTime: e.value?.$1, endTime: e.value?.$2))
            ))
        .toList();
  }

  void _onToggle(int index) {
    setState(() {
      final selectedItem = _itemList[index];
      final (isActive, controller) = selectedItem;
      _itemList[index] = (!isActive, controller);
    });
  }

  @override
  void dispose() {
    for (var element in _itemList) {
      element.$2.dispose();
    }
    super.dispose();
  }

  JadwalBengkelItem? _getByDay(int day) {
    final item = _itemList[day - 1];
    final (isActive, controller) = item;
    if (!isActive) return null;
    return controller.value.let((value) => (value.startTime!, value.endTime!));
  }

  void _onSubmit() {
    if (_formState.currentState?.validate() != true) return;
    context.read<JadwalBengkelCubit>().updateJadwalBengkel(JadwalBengkel(
        monday: _getByDay(DateTime.monday),
        teusday: _getByDay(DateTime.tuesday),
        friday: _getByDay(DateTime.friday),
        saturday: _getByDay(DateTime.saturday),
        sunday: _getByDay(DateTime.sunday),
        thursday: _getByDay(DateTime.thursday),
        wednesday: _getByDay(DateTime.wednesday)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formState,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jadwal Bengkel",
                      style: context.text.labelLarge?.copyWith(
                          color: context.color.onSurface,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    ..._itemList.mapIndexed((i, e) {
                      final (isActive, controller) = e;
                      return Column(
                        children: [
                          14.verticalSpace,
                          _JadwalItem(
                              daysOfWeek: i + 1,
                              controller: controller,
                              isActive: isActive,
                              onToggle: () => _onToggle(i)),
                          14.verticalSpace,
                          Divider(
                            color: context.color.outline,
                            height: 0,
                          )
                        ],
                      );
                    }),
                    const SizedBox(height: 16),
                    SGHideWidget(child: _ButtonSimpan(onSubmit: () {}))
                  ]),
            ),
          ),
        ),
        SizedBox.expand(child: _ButtonSimpan(onSubmit: _onSubmit))
      ],
    );
  }
}

class _JadwalItem extends StatelessWidget {
  final int daysOfWeek;
  final SGTimeRangePickerFieldController controller;

  final bool isActive;
  final void Function() onToggle;

  const _JadwalItem(
      {super.key,
      required this.daysOfWeek,
      required this.controller,
      required this.isActive,
      required this.onToggle});

  String getWeekdayName(int weekday) {
    final DateTime now = DateTime.now().toLocal();
    final int diff = now.weekday - weekday; // weekday is our 1-7 ISO value
    DateTime udpatedDt;
    if (diff > 0) {
      udpatedDt = now.subtract(Duration(days: diff));
    } else if (diff == 0) {
      udpatedDt = now;
    } else {
      udpatedDt = now.add(Duration(days: diff * -1));
    }
    final String weekdayName = DateFormat('EEEE', 'id_ID').format(udpatedDt);
    return weekdayName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getWeekdayName(daysOfWeek),
                style: context.text.titleMedium?.copyWith(
                    color: context.color.onSurface,
                    fontWeight: FontWeight.w600),
              ),
              Switch(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: isActive,
                onChanged: (shouldPublish) => onToggle(),
                activeColor: context.color.primary,
              ),
            ],
          ),
        ),
        Stack(
          children: [
            SGTimeRangePickerField(
              startLabel: "Buka",
              endLabel: "Tutup",
              controller: controller,
              validator: (data) {
                if (!isActive) return null;
                if (data.startTime == null) return "Waktu buka harus diisi";
                if (data.endTime == null) return "Waktu tutup harus diisi";
                return null;
              },
            ),
            if (!isActive)
              Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.withOpacity(.8)),
                  child: Text(
                    "Tutup",
                    style: context.text.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
              )
          ],
        )
      ],
    );
  }
}

class _ButtonSimpan extends StatelessWidget {
  final VoidCallback onSubmit;
  const _ButtonSimpan({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
            child: SGElevatedButton(
              label: "Pesan",
              onPressed: onSubmit,
            )),
      ],
    );
  }
}
