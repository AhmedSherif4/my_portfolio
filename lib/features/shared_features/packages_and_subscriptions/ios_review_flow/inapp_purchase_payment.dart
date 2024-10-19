import 'dart:async';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/features/shared_features/more/presentation/more_widgets/header_for_more.dart';
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/cart/domain/entity/cart_entity.dart';
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/ios_review_flow/sub_flow.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/presentation/view_model/pay_success_bloc.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/presentation/receipt_screen/required_data_after_payment.dart';
import '../../../../../core/services/services_locator.dart';

const bool _kAutoConsume = true;
const String _kConsumableId = 'classroom_id_in_app_purchase';
const List<String> _kProductIds = <String>[_kConsumableId];

class InAppPurchasePayment extends StatefulWidget {
  final ClassroomForCartEntity classroomForCart;
  const InAppPurchasePayment(this.classroomForCart, {super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InAppPurchasePaymentState();
  }
}

class InAppPurchasePaymentState extends State<InAppPurchasePayment> {
  var screenHeight = 0.0;
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final InAppPurchase _connection = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
   List<String> notFoundIds = [];
  List<ProductDetails> _products = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? queryProductError;
  bool paid = false;

  @override
  void initState() {
    super.initState();
   // print('start init state');
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _connection.purchaseStream;
    //print('start purchase stream ${purchaseUpdated.first}');
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
     // print('start listen $purchaseDetailsList');
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
     // print('start on Done $_subscription');
      _subscription?.cancel();
      //print('on done and canceled');
    }, onError: (error) {
     // print('start on Error $error');
      // handle error here.
    });

    initStoreInfo();

    //payWalletBloc.add(FetchDataEvent());
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      var iosPlatformAddition = _connection
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> initStoreInfo() async {
    final transactions = await SKPaymentQueueWrapper().transactions();
    for (var transaction in transactions) {
      await SKPaymentQueueWrapper().finishTransaction(transaction);
    }
    final bool isAvailable = await _connection.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        notFoundIds = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }
    if (Platform.isIOS) {
      var iosPlatformAddition = _connection
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(PaymentQueueDelegate());
    }
//هنا تحميل المنتجات بيتم
    ProductDetailsResponse productDetailResponse =
        await _connection.queryProductDetails(_kProductIds.toSet());
    // productDetailResponse.productDetails.log();
    if (productDetailResponse.error != null) {
      setState(() {
        queryProductError = productDetailResponse.error?.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        notFoundIds = productDetailResponse.notFoundIDs;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }
//هنا بيهندل لو مفيش منتجات أصلا
    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        notFoundIds = productDetailResponse.notFoundIDs;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    //هنا بيجيب اللي متسجلين كمدفوعين في الشيرد بريفرنس
    //List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      notFoundIds = productDetailResponse.notFoundIDs;
      _purchasePending = false;
      _loading = false;
    });
    //end loading
  }

  Future<void> _buyProduct(ProductDetails productDetails) async {
    setState(() {
      _purchasePending = true;
    });

    try {
      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: productDetails,
        applicationUserName: null,
      );
      // productDetails.id.log();

      if (productDetails.id == _kConsumableId) {
        // Purchase a consumable product
        await _connection.buyConsumable(
          purchaseParam: purchaseParam,
          autoConsume: _kAutoConsume || Platform.isIOS,
        );
      } else {
        // Purchase a non-consumable product
        await _connection.buyNonConsumable(purchaseParam: purchaseParam);
      }
    } on PlatformException catch (e) {
      setState(() {
        _purchasePending = false;
      });
      //print('PlatformException: ${e.message}');
      // Handle platform exception
    } catch (e) {
      setState(() {
        _purchasePending = false;
      });
     // print('Exception: $e');
      // Handle other exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => getIt<PaySuccessBloc>(),
      child: Scaffold(
          body: SafeArea(
        child: Center(
            child: Stack(children: [
          const Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
              )),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xeeffffff)),
              )),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 100,
            child: HeaderForMore(title: 'In-App Purchase'),
          ),
          Positioned(
              top: 150,
              bottom: 0,
              left: 0,
              right: 0,
              child: _loading
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(children: [
                        const SizedBox(
                            height: 100,
                            width: 100,
                            child: SpinKitChasingDots(
                              color: AppColors.primaryColor,
                              duration: Duration(milliseconds: 500),
                            )),
                        Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("جاري تحميل المنتجات"))),
                      ]),
                    )
                  : !_isAvailable
                      ? Center(
                          child: Container(
                              height: 70,
                              decoration: const BoxDecoration(
                                color: Color(0x00ffffff),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                //borderRadius: BorderRadius.all( Radius.circular(15)),
                              ),
                              child: Center(
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.only(top: 10, bottom: 10),
                                      child: Column(children: <Widget>[
                                        Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            child: const FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                    "الدفع غير متاح لهذا التطبيق تواصل مع الدعم"))),
                                      ])))))
                      : paid
                          ? const Column(
                            children: [
                              Text(
                                'Pay Loaded',
                              )
                            ],
                          )
                          : _purchasePending
                              ? Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(children: [
                                    const SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: SpinKitDoubleBounce(
                                          color: AppColors.primaryColor,
                                          duration: Duration(milliseconds: 500),
                                        )),
                                    Container(
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: const FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text("جاري الدفع"))),
                                  ]),
                                )
                              : _products.isNotEmpty
                                  ? Center(
                                      child: Container(
                                          height: 200.responsiveHeight,
                                          decoration: const BoxDecoration(
                                            color: Color(0x00ffffff),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15)),
                                            //borderRadius: BorderRadius.all( Radius.circular(15)),
                                          ),
                                          child: Center(
                                              child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 10, bottom: 10),
                                                  child:
                                                      Column(children: <Widget>[
                                                    Container(
                                                        height: 30,
                                                        alignment:
                                                            Alignment.center,
                                                        child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              _products[0]
                                                                  .title,
                                                              style: AppTextStyle
                                                                  .bodyMedium14,
                                                            ))),
                                                    Container(
                                                        height:
                                                            30.responsiveHeight,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          _products[0]
                                                              .description,
                                                          style: AppTextStyle
                                                              .bodyMedium14,
                                                        )),
                                                    Container(
                                                        height:
                                                            30.responsiveHeight,
                                                        alignment:
                                                            Alignment.center,
                                                        child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              "عليك دفع مبلغ  ${_products[0]
                                                                      .price} لفتح المحتوي",
                                                              style: AppTextStyle
                                                                  .bodyMedium14,
                                                            ))),
                                                    MaterialButton(
                                                        onPressed: () {
                                                          //if(mainLoggedUser.purchase==1) {
                                                          _buyProduct(
                                                              _products[0]);
                                                          //}
                                                        },
                                                        child: Container(
                                                          height: 30
                                                              .responsiveHeight,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: AppColors
                                                                .primaryColor,
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                    .circular(
                                                                        15)),
                                                            //borderRadius: BorderRadius.all( Radius.circular(15)),
                                                          ),
                                                          alignment:
                                                              Alignment
                                                                  .center,
                                                          width: double
                                                              .infinity,
                                                          child: FittedBox(
                                                            child: Text(
                                                              "شراء ",
                                                              style: const AppTextStyle()
                                                                  .bodyMedium14
                                                                  .copyWith(
                                                                      color:
                                                                          AppColors.white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ))
                                                  ])))))
                                  : Center(
                                      child: Container(
                                          height: 70,
                                          decoration: const BoxDecoration(
                                            color: Color(0x00ffffff),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15)),
                                            //borderRadius: BorderRadius.all( Radius.circular(15)),
                                          ),
                                          child: Center(
                                              child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 10, bottom: 10),
                                                  child:
                                                      Column(children: <Widget>[
                                                    Container(
                                                        height: 50,
                                                        alignment:
                                                            Alignment.center,
                                                        child: const FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                                "لا توجد منتجات"))),
                                                  ]))))))
        ]).paddingBody()),
      )),
    );
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
  //  print('Start Listening to purchase');
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
    //  print('--------------------------------');
      if (purchaseDetails.status == PurchaseStatus.pending) {
      //  print('in pending purchase ');
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          //print('in error purchase ');
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased &&
            purchaseDetails.pendingCompletePurchase) {
         // print('in purchased purchase ');
          await _completePurchase(purchaseDetails);
        } else {
          //print('purchase details error is ${purchaseDetails.error}');
          handleError(purchaseDetails.error!);
        }
      }
    });
  }

  Future<void> _completePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.productID == _kConsumableId) {
      await _connection.completePurchase(purchaseDetails).then((value) {
        setState(() {
          _purchasePending = false;
          _loading = false;
          paid = true;
        });
        SchedulerBinding.instance.addPostFrameCallback((_) {
          RouteManager.rPushNamedAndRemoveUntil(
            context: context,
            rName: AppRoutesNames.rPaymentSuccessScreen,
            arguments: RequiredDataAfterPayment(
              cartData: const CartEntity(totalPrice: 216, cart: []),
              totalPrice: 0,
              coupon: '',
              couponDiscount: '',
              payStatus: false,
              transactionId: '${purchaseDetails.purchaseID}',
            ),
          );
        });
      }).catchError((error) {
        // Reset purchase state variables to their initial values
        setState(() {
          _purchasePending = false;
          _loading = false;
          paid = false;
        });
        // Handle purchase completion error
        handleError(error);
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }
}

class PaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

// const String _svg_hrjn3u =
//     '<svg viewBox="0.0 0.0 30.3 14.7" ><path transform="translate(0.0, -132.0)" d="M 29.97564506530762 138.5054473876953 C 29.97528839111328 138.5050811767578 29.97499465942383 138.5046844482422 29.97457885742188 138.5042877197266 L 23.78535842895508 132.3450469970703 C 23.32168769836426 131.8835906982422 22.57172584533691 131.8852996826172 22.11018943786621 132.3490447998047 C 21.64870834350586 132.8126983642578 21.65048599243164 133.5626373291016 22.11415672302246 134.0241241455078 L 26.26959991455078 138.1593780517578 L 1.184494137763977 138.1593780517578 C 0.5302985310554504 138.1593780517578 -9.5367431640625e-07 138.6896514892578 -9.5367431640625e-07 139.3438262939453 C -9.5367431640625e-07 139.9980316162109 0.5302985310554504 140.5283355712891 1.184494137763977 140.5283355712891 L 26.26953887939453 140.5283355712891 L 22.11421585083008 144.6635894775391 C 21.65054512023926 145.1250762939453 21.64876556396484 145.8750152587891 22.11024856567383 146.3386383056641 C 22.5717887878418 146.8024444580078 23.32180786132813 146.8040313720703 23.7854175567627 146.3426666259766 L 29.97464179992676 140.1833953857422 C 29.97499465942383 140.1830291748047 29.97529029846191 140.1826324462891 29.9757080078125 140.1822662353516 C 30.43961524963379 139.7192535400391 30.43813323974609 138.9668731689453 29.97564506530762 138.5054473876953 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
