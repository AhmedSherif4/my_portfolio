part of '../../../un_link.dart';

class ParentAddNewChildScreen extends StatefulWidget {
  const ParentAddNewChildScreen({super.key});

  @override
  State<ParentAddNewChildScreen> createState() =>
      _ParentAddNewChildScreenState();
}

class _ParentAddNewChildScreenState extends State<ParentAddNewChildScreen> {
  late TextEditingController emailOrPhoneController;

  @override
  void initState() {
    super.initState();
    emailOrPhoneController = TextEditingController();
  }

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnLinkBloc, UnLinkState>(
      listener: (context, state) {
        switch (state.parentAddNewChildStates) {
          case RequestStates.loading:
            showLoadingDialog(context);
          case RequestStates.loaded:
            Navigator.pop(context);
            showSnackBar(
              context: context,
              description: state.parentAddNewChildMessage,
              state: ToastStates.congrats,
            );
            RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rParentInviteSentSuccessfully,
              arguments: '',
            );

          case RequestStates.error:
            Navigator.pop(context);
            showSnackBar(
              context: context,
              description: state.parentAddNewChildMessage,
              state: ToastStates.error,
            );
          default:
        }
      },
      builder: (context, state) => BaseAddNewPerson(
        title: AppStrings.addChild,
        iconPath:AppIconsAssets.sAddChild ,
        isParentPath: true,
        emailOrPhoneController: emailOrPhoneController,
        onPressed: () {
          context.read<UnLinkBloc>().add(
                ParentAddedNewChild(
                  mailOrPhone: emailOrPhoneController.text.toString(),
                ),
              );
        },
      ),
    );
  }
}
