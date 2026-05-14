import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/router/app_page.dart';
import 'package:unitask/core/extensions/build_context_extension.dart';
import 'package:unitask/core/extensions/sized_box_extension.dart';
import 'package:unitask/core/models/result.dart';
import 'package:unitask/features/auth/auth_provider.dart';
import 'package:unitask/ui/pages/common/label_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = .new();
  final TextEditingController _pwController = .new();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final email = _emailController.text.trim();
    final password = _pwController.text.trim();

    //이메일/비밀번호 빈 값 검증
    if (email.isEmpty || password.isEmpty) {
      return context.showSnackbar('이메일 또는 비밀번호를 입력해주세요', isError: true);
    }
    final result = await ref
        .read(authProvider.notifier)
        .login(email: email, password: password);

    switch (result) {
      case Success():
        if (mounted) context.goNamed(AppPage.home.name);
      case Failure(:final exception):
        if (mounted) {
          context.showSnackbar(exception.toString(), isError: true);
        }
    }

    //Todo 로그인 성공 -> 메인화면 이동
    if (mounted) {
      context.goNamed(AppPage.home.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(authProvider).isLoading;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(LucideIcons.graduationCap, size: 50),
                const Text(
                  'Unitask',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text('과제 관리를 스마트하게'),
                50.heightBox,

                //email
                LabelTextField(
                  controller: _emailController,
                  label: '이메일',
                  hintText: 'example@university.edu',
                  icon: LucideIcons.mail,
                ),
                20.heightBox,

                //password
                LabelTextField(
                  controller: _pwController,
                  label: '비밀번호',
                  hintText: '000000',
                  icon: LucideIcons.lockKeyhole,
                  enableObscure: true,
                ),

                Align(
                  alignment: .centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.showSnackbar('곧 기능을 출시합니다!');
                    },
                    child: const Text('비밀번호를 잊으셨나요?'),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: loading ? null : _onLogin,
                    icon: loading
                        ? const SizedBox.square(
                            dimension: 14,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : null,
                    label: const Text(
                      '로그인',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                20.heightBox,

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('계정이 없으신가요? '),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(AppPage.signup.name);
                      },
                      child: const Text('회원가입'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
