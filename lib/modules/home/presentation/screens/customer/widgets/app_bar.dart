part of '../customer_home_screen.dart';

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
        decoration: BoxDecoration(
            color: color.background,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, .1), //(x,y)
                blurRadius: .5,
              ),
            ],
            borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(12.w))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Halo, ${context.read<CustomerProfileCubit>().state.nama}",
                  style: text.bodySmall?.copyWith(fontSize: 11.5.sp),
                ),
                .7.h.verticalSpace,
                const SGIconText()
              ],
            ),
            InkWell(
                onTap: () => context.logout(),
                child: const Icon(Icons.notifications))
          ],
        ),
      ),
    );
  }
}
