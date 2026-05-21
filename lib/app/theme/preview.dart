import 'package:flutter/widget_previews.dart';
import 'package:unitask/app/theme/app_theme.dart';

final class AppThemePreview extends Preview {
  const AppThemePreview({
    super.brightness,
    super.group,
    super.localizations,
    super.name,
    super.size,
    super.textScaleFactor,
    super.wrapper,
  }) : super(theme: AppThemePreview.themeBuilder);

  static PreviewThemeData themeBuilder() => PreviewThemeData(
    materialLight: AppTheme.light,
    materialDark: AppTheme.dark,
  );
}
