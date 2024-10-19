part of '../../../un_link.dart';


class ParentAddExistChildScreen extends StatefulWidget {
  final String? username;
  const ParentAddExistChildScreen({super.key, this.username});

  @override
  State<ParentAddExistChildScreen> createState() =>
      _ParentAddExistChildScreenState();
}

class _ParentAddExistChildScreenState extends State<ParentAddExistChildScreen> {
  late TextEditingController userNameController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.username);
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UnLinkBloc, UnLinkState>(
      listener: (context, state) {
        switch (state.parentAddExistChildStates) {
          case RequestStates.loading:
            showLoadingDialog(context);
          case RequestStates.loaded:
            Navigator.pop(context);
            showSnackBar(
              context: context,
              description: state.parentAddExistChildMessage,
              state: ToastStates.congrats,
            );
            RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rParentInviteSentSuccessfully,
              arguments: state.parentAddExistChildMessage,
            );

          case RequestStates.error:
            Navigator.pop(context);
            showSnackBar(
              context: context,
              description: state.parentAddExistChildMessage,
              state: ToastStates.error,
            );

          default:
        }
      },
      child: BaseAddExistPerson(
        title: AppStrings.pleaseWriteChildEmail,
        textEditingController: userNameController,
        buttonOnPressed: () {
          userNameController.text.isNotEmpty
              ? context.read<UnLinkBloc>().add(
                    ParentAddedExistChild(
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
        imageWidth: AppReference.deviceWidth(context) * 0.4,
        imageHeight: AppReference.deviceHeight(context) * 0.2,
      ),
    );
  }
}
