import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/core/extensions/build_context_extension.dart';
import 'package:unitask/core/models/result.dart';
import 'package:unitask/features/auth/auth_provider.dart';
import 'package:unitask/ui/pages/common/label_text_field.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final TextEditingController _nameController = .new();
  final TextEditingController _emailController = .new();
  final TextEditingController _passwordController = .new();
  final TextEditingController _passwordConfirmController = .new();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();

    super.dispose();
  }

  Future<void> _onSignup() async {
    debugPrint('계정 만들기');

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final passwordConfirm = _passwordConfirmController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      context.showSnackbar('정보가 올바르지 않습니다.', isError: true);
      return;
    }

    if (password != passwordConfirm) {
      context.showSnackbar('비밀전호가 일치하지 않습니다.', isError: true);
      return;
    }

    final result = await ref
        .read(authProvider.notifier)
        .singup(email: email, password: password, name: name);

    switch (result) {
      case Success():
        if (mounted) context.pop();
      case Failure(:final exception):
        if (mounted) {
          context.showSnackbar(exception.toString(), isError: true);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ToDo: AsyncLoading() 데이터 추출
    final loading = ref.watch(authProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('회원가입', style: TextStyle(fontWeight: .bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            spacing: 25,
            children: [
              LabelTextField(
                controller: _nameController,
                label: '이름',
                icon: LucideIcons.userRoundPen,
                hintText: '',
              ),
              LabelTextField(
                controller: _emailController,
                label: '이메일',
                icon: LucideIcons.mail,
                hintText: '',
              ),
              LabelTextField(
                controller: _passwordController,
                label: '비밀번호',
                enableObscure: true,
                icon: LucideIcons.lockKeyhole,
                hintText: '',
              ),
              LabelTextField(
                controller: _passwordConfirmController,
                label: '비밀번호 확인',
                enableObscure: true,
                icon: LucideIcons.lockKeyholeOpen,
                hintText: '',
              ),
              SizedBox(
                width: .infinity,
                child: ElevatedButton(
                  onPressed: _onSignup,
                  child: loading
                      ? const SizedBox.square(
                          dimension: 30,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : const Text('계정 만들기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
