part of '../../parent_preview_for_child.dart';

class ParentPreviewForChildScreen extends StatelessWidget {
  const ParentPreviewForChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<UnLinkBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ParentPreviewForChildBloc>()
            ..add(GetAllParentsForChildEvent()),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const HeaderForMore(title: AppStrings.parents),
              AppSize.s20.sizedBoxHeight,
              AddParentOrChildButton(
                onTap: () {
                  RouteManager.rPushNamed(
                    context: context,
                    rName: AppRoutesNames.rChildAddParentWays,
                    arguments: true,
                  );
                },
                buttonLabel: AppStrings.addParents,
                backgroundColor: HexColor.fromHex('#eaf1fa'),
                svgPath: AppImagesAssets.sAddUser,
              ),
              AppSize.s20.sizedBoxHeight,
              Text(
                AppStrings.data,
                style: const AppTextStyle().w600.bodyLarge16,
              ),
              AppSize.s40.sizedBoxHeight,
              const Expanded(child: ChildParentsBuilder()),
            ],
          ),
        ).paddingBody(),
      ),
    );
  }
}

class ChildParentsBuilder extends StatelessWidget {
  const ChildParentsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentPreviewForChildBloc, ParentPreviewForChildState>(
      builder: (context, state) {
        switch (state.getParentState) {
          case RequestStates.loading:
            return LoadingShimmerList(
              height: 80.responsiveHeight,
            );
          case RequestStates.loaded:
            if (state.allParent.isEmpty) {
              return const EmptyListWidgets(
                  message: AppStrings.noParentsNow);
            } else {
              return (AppReference.deviceIsTablet && !AppReference.isPortrait(context)) ?
              GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 4/1.9,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 30,),
                itemCount: state.allParent.length,
                itemBuilder: (context, index) {
                  return ParentItem(
                    email: state.allParent[index].email.isEmpty
                        ? state.allParent[index].phone
                        : state.allParent[index].email,
                    name: state.allParent[index].name,
                    parentId: state.allParent[index].parentId,
                    userName: state.allParent[index].username,
                  );
                },
              )
                  :ListView.separated(
                itemBuilder: (context, index) => ParentItem(
                  email: state.allParent[index].email.isEmpty
                      ? state.allParent[index].phone
                      : state.allParent[index].email,
                  name: state.allParent[index].name,
                  parentId: state.allParent[index].parentId,
                  userName: state.allParent[index].username,
                ),
                separatorBuilder: (context, index) =>
                    Divider(
                      height: AppSize.s30.responsiveSize,
                      color: AppColors.textColor6,
                      endIndent: AppSize.s50.responsiveWidth,
                      indent: AppSize.s50.responsiveWidth,
                    ),
                itemCount: state.allParent.length,
                physics: const BouncingScrollPhysics(),
              );
            }
          case RequestStates.error:
            return CustomErrorWidget(errorMessage: state.getParentMessage);
          default:
            return const SizedBox();
        }
      },
    );
  }
}

class ParentItem extends StatelessWidget {
  final String email;
  final String name;
  final String userName;
  final int parentId;

  const ParentItem(
      {super.key,
        required this.email,
        required this.name,
        required this.userName,
        required this.parentId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p12.responsiveSize,
          vertical: AppPadding.p12.responsiveSize
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSize.s20.responsiveSize),
      ),
      child: Column(
        children: [
          BaseParentItem(type: AppStrings.name, typeValue: name),
          AppSize.s10.sizedBoxHeight,
          BaseParentItem(type: AppStrings.mail, typeValue: email),
          AppSize.s10.sizedBoxHeight,
          BaseParentItem(type: AppStrings.username, typeValue: userName),
          UnLinkButton(
              userId: parentId,
              message: AppStrings.wantToDeleteLinkWithParent),
        ],
      ),
    );
  }
}

class BaseParentItem extends StatelessWidget {
  final String type;
  final String typeValue;

  const BaseParentItem(
      {super.key, required this.type, required this.typeValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            type,
            style: const AppTextStyle().balooBhaijaan2.w500.black.bodySmall12,
          ),
        ),
        AppSize.s20.sizedBoxWidth,
        Expanded(
          flex: 5,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              typeValue,
              style:
              const AppTextStyle().balooBhaijaan2.w400.black.bodyMedium14,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
