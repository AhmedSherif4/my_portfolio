part of '../../../un_link.dart';

class ChildAddNewParentScreen extends StatefulWidget {
  const ChildAddNewParentScreen({super.key});

  @override
  State<ChildAddNewParentScreen> createState() =>
      _ChildAddNewParentScreenState();
}

class _ChildAddNewParentScreenState extends State<ChildAddNewParentScreen> {
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
    return BlocListener<UnLinkBloc, UnLinkState>(
      listener: (context, state) {
        switch (state.childAddNewParentStates) {
          case RequestStates.loading:
            showLoadingDialog(context);
          case RequestStates.loaded:
            Navigator.pop(context);
            RouteManager.rPushNamedAndRemoveUntil(
                context: context,
                rName: AppRoutesNames.rChildInviteSentSuccessfully);
            showSnackBar(
              context: context,
              description: state.childAddNewParentMessage,
              state: ToastStates.congrats,
            );
          case RequestStates.error:
            Navigator.pop(context);
            showSnackBar(
              context: context,
              description: state.childAddNewParentMessage,
              state: ToastStates.error,
            );
          default:
        }
      },
      child: BaseAddNewPerson(
        title: AppStrings.addParent,
        iconPath:AppIconsAssets.sAddParent,
        isParentPath: false,
        emailOrPhoneController: emailOrPhoneController,
        onPressed: () {
          BlocProvider.of<UnLinkBloc>(context).add(
            ChildAddedNewParent(
              emailOrPhone: emailOrPhoneController.text.toString(),
            ),
          );
        },
      ),
    );
  }
}
