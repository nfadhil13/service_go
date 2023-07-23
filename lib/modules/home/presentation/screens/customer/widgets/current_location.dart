part of '../customer_home_screen.dart';

class _CurrentLocation extends StatelessWidget {
  const _CurrentLocation({super.key});

  void _changeLocation(BuildContext context) async {
    final locationScope = LocationScope.of(context);
    final location = await SGMapPicker.pickLocation(context,
        initialValue: context.currentLocation);
    if (location == null) return;
    locationScope.changeLocation(location);
  }

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final color = context.color;
    return InkWell(
      onTap: () => _changeLocation(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
            border: Border.all(color: color.outline)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lokasi Anda",
                        style: text.labelLarge?.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 11.5.sp),
                      ),
                    ],
                  ),
                ),
                4.verticalSpace,
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                    ),
                    2.w.horizontalSpace,
                    Text(context.currentLocation.shortAddress)
                  ],
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
