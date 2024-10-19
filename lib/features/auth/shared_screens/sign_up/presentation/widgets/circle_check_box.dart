part of '../.././sign_up.dart';

class CircleCheckBoxWidget extends StatelessWidget {
  final bool isSelected;
  final Function(bool?) onChange;
  const CircleCheckBoxWidget({
    super.key,
    required this.isSelected,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isSelected,
      checkColor: Colors.white,
      activeColor: Colors.green,
      visualDensity: VisualDensity.standard,
      shape: const CircleBorder(),
      onChanged: onChange,
    );
  }
}
