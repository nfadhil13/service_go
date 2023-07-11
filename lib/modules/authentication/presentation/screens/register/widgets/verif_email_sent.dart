part of '../register_screen.dart';

class _VerificationEmailSent extends StatelessWidget {
  final String email;
  const _VerificationEmailSent({required this.email});

  @override
  Widget build(BuildContext context) {
    final textStyle = context.text.bodyMedium
        ?.copyWith(color: context.color.onSurfaceVariant);
    return RichText(
      text: TextSpan(style: textStyle, children: [
        const TextSpan(text: "Email Verifikasi telah dikirim ke "),
        TextSpan(
            text: email,
            style: textStyle?.copyWith(fontWeight: FontWeight.bold)),
        const TextSpan(text: ". Silahkan periksa email untuk verifikasi")
      ]),
    );
  }
}
