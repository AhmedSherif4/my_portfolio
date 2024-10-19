part of '../../quran.dart';

class SurahScreen extends StatefulWidget {
  final TypeOfSelection typeOfSelection;
  const SurahScreen({super.key, required this.typeOfSelection});

  @override
  State<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  List<Map<String, dynamic>> _filteredSurahs = StaticDataForQuran.quranSurahs;
  late TextEditingController _searchController;

  void _filterSurahs(String query) {
    final filteredSurahs = StaticDataForQuran.quranSurahs.where((surah) {
      final surahName = surah['name'].toString().toLowerCase();
      final searchLower = query.toLowerCase();
      return surahName.contains(searchLower);
    }).toList();

    setState(() {
      _filteredSurahs = filteredSurahs;
    });
  }
  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
    _searchController.addListener(() {
      _filterSurahs(_searchController.text);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child:
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: AppReference.deviceHeight(context),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppReference.deviceIsTablet&&!AppReference.isPortrait(context)
                        ? AppImagesAssets.pQuranForTabletBg
                        : AppImagesAssets.pQuranForMobileBg),
                    fit: BoxFit.fill
                )
            ),
            child: Column(
              children: [
                const HeaderForMore(
                  title: 'القرآن الكريم',
                  textColor: AppColors.primaryColor,
                ),
                AppSize.s30.sizedBoxHeight,
                TextFormFieldWidget(
                    controller: _searchController,
                    keyboardType: TextInputType.name,
                    inputAction: TextInputAction.done,
                    hintText: "ابحث بأسم السورة",
                    suffixIcon: Icons.search,

                    suffixIconOnPress: () {
                    },
                    onFieldSubmitted: (value) {

                    }),
                AppSize.s30.sizedBoxHeight,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (AppReference.deviceIsTablet&&!AppReference.isPortrait(context))...[
                          GridView.builder(
                              itemCount: _filteredSurahs.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder:(context, index) => _SuruhWithSearchWidget(filteredSurahs: _filteredSurahs,index: index,),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 8/1.3,
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,)
                          ),

                        ],
                        if (!AppReference.deviceIsTablet||AppReference.deviceIsTablet&&AppReference.isPortrait(context))...[
                          // _filteredSurahs.isEmpty?SliverToBoxAdapter(child: EmptyListWidgets(message: "message")):
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => _SuruhWithSearchWidget(filteredSurahs: _filteredSurahs,index: index,),
                            separatorBuilder: (context, index) =>
                            AppSize.s20.sizedBoxHeight,
                            itemCount: _filteredSurahs.length,
                          ),
                        ]
                      ]
                    ),
                  ),
                ),
              ],
            ).paddingBody(),
          ),
        )
      ),
    );
  }
}

class _SuruhWithSearchWidget extends StatelessWidget {
  const _SuruhWithSearchWidget({
    required List<Map<String, dynamic>> filteredSurahs,
    required int index,
  }) : _filteredSurahs = filteredSurahs,_index = index;

  final List<Map<String, dynamic>> _filteredSurahs;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rQuranViewScreen,
          arguments: QuranParameter(
            typeOfSelection: TypeOfSelection.surah,
            selectionId: _filteredSurahs[_index]['id'],
            selectionText: _filteredSurahs[_index]['name'],
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p20.responsiveHeight,
          horizontal: AppPadding.p30.responsiveWidth,
        ),
        margin: EdgeInsets.symmetric(horizontal: AppPadding.p10.responsiveSize),
        width: AppReference.deviceWidth(context) * 0.7,
        decoration: BoxDecoration(
          color: AppColors.quranColor.withOpacity(.4),
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR25.responsiveSize),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _filteredSurahs[_index]['name'],
                  style: const AppTextStyle().quranFont.orange.bodyLarge16.copyWith(
                      color: AppColors.secondaryColor4
                  ),
                ),
                Text(
                  "عدد الآيات : ${_filteredSurahs[_index]['ayaNum']}",
                  style: const AppTextStyle().balooBhaijaan2.w600.bodySmall12.copyWith(
                      fontSize: AppFontSize.sp10.responsiveFontSize,
                      color: AppColors.secondaryColor4
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.responsiveSize,
              color: AppColors.secondaryColor4,
            ),
          ],
        ),
      ),
    );
  }
}

class _SurahWidget extends StatelessWidget {
  final int index;
  final TypeOfSelection typeOfSelection;

  const _SurahWidget(
    this.index, this.typeOfSelection,
  );

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        if(typeOfSelection == TypeOfSelection.surah) {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rQuranViewScreen,
            arguments: QuranParameter(
              typeOfSelection: TypeOfSelection.surah,
              selectionId: StaticDataForQuran.quranSurahs[index]['id'],
              selectionText: StaticDataForQuran.quranSurahs[index]['name'],
            ),
          );
        }else{
          RouteManager.rPushNamed(context: context, rName: AppRoutesNames.rQuranPageScreen,
              arguments: StaticDataForQuran.quranSurahs[index]['page']);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p20.responsiveHeight,
          horizontal: AppPadding.p30.responsiveWidth,
        ),
        margin: EdgeInsets.symmetric(horizontal: AppPadding.p10.responsiveSize),
        width: AppReference.deviceWidth(context) * 0.7,
        decoration: BoxDecoration(
          color: AppColors.quranColor.withOpacity(.4),
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR25.responsiveSize),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StaticDataForQuran.quranSurahs[index]['name'],
                  style: const AppTextStyle().quranFont.orange.bodyLarge16.copyWith(
                    color: AppColors.secondaryColor4
                  ),
                ),
                Text(
                  "عدد الآيات : ${StaticDataForQuran.quranSurahs[index]['ayaNum']}",
                  style: const AppTextStyle().balooBhaijaan2.w600.bodySmall12.copyWith(
                    fontSize: AppFontSize.sp10.responsiveFontSize,
                    color: AppColors.secondaryColor4
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.responsiveSize,
              color: AppColors.secondaryColor4,
            ),
          ],
        ),
      ),
    );
  }
}
