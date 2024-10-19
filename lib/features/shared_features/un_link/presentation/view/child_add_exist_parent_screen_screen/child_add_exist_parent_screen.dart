part of '../../../un_link.dart';


class ChildAddExistParentScreen extends StatefulWidget {
  const ChildAddExistParentScreen({super.key});

  @override
  State<ChildAddExistParentScreen> createState() =>
      _ChildAddExistParentScreenState();
}

class _ChildAddExistParentScreenState extends State<ChildAddExistParentScreen> {
  late TextEditingController userNameController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UnLinkBloc,
        UnLinkState>(
      listener: (context, state) {
        switch (state.childAddExitParentStates) {
          case RequestStates.loading:
            showLoadingDialog(context);
          case RequestStates.loaded:
            Navigator.pop(context);
            showSnackBar(
              context: context,
              description: state.childAddExitParentMessage,
              state: ToastStates.congrats,
            );
            RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rChildInviteSentSuccessfully,
            );

          case RequestStates.error:
            showSnackBar(
              context: context,
              description: state.childAddExitParentMessage,
              state: ToastStates.error,
            );
            Navigator.pop(context);

          default:
        }
      },
      child: BaseAddExistPerson(
        textEditingController: userNameController,
        title: AppStrings.pleaseWriteParentUsername,
        buttonOnPressed: () {
          userNameController.text.isNotEmpty
              ? context.read<UnLinkBloc>().add(
                    ChildAddedExistParent(
                      username: userNameController.text.toString(),
                    ),
                  )
              : showSnackBar(
                  context: context,
                  description: AppStrings.writeUserName,
                  state: ToastStates.error,
                );
        },
        image: AppImagesAssets.sFeatherPen,
        imageWidth: AppReference.deviceWidth(context) * 0.8,
        imageHeight:
            AppReference.deviceHeight(context) * 0.17.responsiveHeightRatio,
      ),
    );
  }
}
