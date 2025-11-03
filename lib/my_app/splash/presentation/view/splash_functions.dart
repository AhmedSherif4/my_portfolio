part of '../../splash_screen.dart';

void _goToHomeScreen(
  BuildContext context,
  /*UserEntity? userData*/
) {
  Navigator.pushReplacementNamed(
    context,
    AppRoutesNames.rHomeScreen,
  );
}
