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
            Expanded(
              child: Column(
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
            ),
            const _Profile()
          ],
        ),
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CircleAvatar(
        radius: 6.w,
        backgroundColor: context.color.primary,
        child: AutoSizeText(
          context.read<CustomerProfileCubit>().state.nama.characters.first,
          style: context.text.titleMedium?.copyWith(
              color: context.color.onPrimary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
