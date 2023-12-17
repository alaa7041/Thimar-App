import 'package:flutter/material.dart';
import 'package:thimar/core/design/app_button.dart';
import 'package:thimar/core/design/app_image.dart';
import 'package:thimar/core/logic/helper_methods.dart';
import 'package:thimar/features/home/pages/cart/update/bloc.dart';
import 'package:thimar/views/home/pages/end_order/view.dart';
import 'package:thimar/views/home/view.dart';
import '../../../../core/logic/cache_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/home/pages/cart/delet/bloc.dart';
import '../../../../features/home/pages/cart/get/bloc.dart';
import '../../../../features/home/pages/cart/get/states.dart';
import '../../../../features/home/pages/cart/update/events.dart';
import '../../../../features/home/pages/cart/update/states.dart';
import '../../../../features/products/bloc.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late CartBloc bloc;
  late ProductModel model;

  @override
  void initState() {
    bloc = BlocProvider.of(context);
    bloc.add(CartEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("السلة")),
        leading: Container(
          margin: const EdgeInsets.all(9),
          width: 30,
          height: 32,
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .primaryColor
                .withOpacity(0.13),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
            onPressed: () {
              navigateTo(HomeView());
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder(
                bloc: bloc,
                buildWhen: (previous, current) =>
                current is CartSuccessState ||
                    current is CartFieldState ||
                    current is CartLoadingState,
                builder: (context, state) {
                  if (state is CartSuccessState) {
                    return ListView.separated(
                      itemBuilder: (context, index) =>
                          _Item(
                            model: state.list[index],
                            bloc: bloc,
                            onRemoveSuccess: () {
                              state.list.removeWhere(
                                      (element) =>
                                  element.id == state.list[index].id);
                              setState(() {});
                            },
                          ),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 16.w),
                      itemCount: state.list.length,
                    );
                  } else if (state is CartFieldState) {
                    return Text(state.message);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: SizedBox(
                      width: 79.w,
                      height: 39.h,
                      child: AppButton(
                        onPress: () {},
                        text: "تطبيق",
                      ),
                    ),
                    hintText: 'عندك كوبون ؟ ادخل رقم الكوبون',
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "جميع الأسعار تشمل قيمة الضريبة المضافة 15 % ",
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    fontSize: 15.sp,
                  ),
                ),
                Container(
                  height: 111.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Theme
                        .of(context)
                        .primaryColor
                        .withOpacity(.13),
                  ),
                  margin: EdgeInsets.all(14.w),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "إجمالي المنتجات",
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 167.w,
                          ),
                          Text("${bloc.totalProduct} ر.س",
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize: 15.sp,
                              )),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "الخصم",
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 220.w,
                          ),
                          Text("-${bloc.discount} ر.س ",
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize: 15.sp,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Divider(
                        height: 10.h,
                        color: const Color(0xffE2E2E2),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "المجموع",
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 220.w,
                          ),
                          Text("${bloc.totalProduct - bloc.discount} ر.س ",
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize: 15.sp,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    text: "الانتقال لإتمام الطلب",
                    onPress: () {
                      navigateTo(const EndOrderView());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  final CartModel model;
  final CartBloc bloc;
  final UpdateCartBloc? updateBloc;
  final DeleteItemFromCartBloc? deleteBloc;
  final VoidCallback onRemoveSuccess;

   const _Item({
    required this.model,
    required this.bloc,
    required this.onRemoveSuccess,
     this.deleteBloc,
     this.updateBloc,
  });

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Theme
                  .of(context)
                  .primaryColor
                  .withOpacity(.15),
              spreadRadius: .2,
              blurRadius: 5,
              blurStyle: BlurStyle.normal,
            ),
          ]),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            width: 70.w,
            height: 78.h,
            child: AppImage(
              path: widget.model.image,
              width: 60.w,
              height: 60.h,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            children: [
              Text(
                widget.model.title,
                style: TextStyle(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.model.price}",
                style: TextStyle(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 75.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor
                          .withOpacity(.13),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  Align(
                    widthFactor: 1.1.w,
                    heightFactor: 1.35.h,
                    child: Row(
                      children: [
                        Container(
                          height: 23.h,
                          width: 23.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: BlocConsumer(
                            bloc: widget.bloc,
                            listener: (context, state) {
                              if (state is UpdateItemInCartSuccessState) {
                                widget.bloc.count++;
                              }
                            },
                            builder: (context, state) {
                              return IconButton(
                                onPressed: () {
                                  widget.updateBloc!.add(UpdateItemInCartEvent(
                                    id: widget.model.id,
                                    amount: widget.model.amount.toInt(),
                                  ));
                                  CacheHelper.setCount(count);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.add),
                                iconSize: 15.sp,
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                padding: const EdgeInsets.only(
                                  bottom: 2,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text("$count"),
                        SizedBox(
                          width: 3.w,
                        ),
                        Container(
                          height: 23.h,
                          width: 23.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: BlocConsumer(
                            listener: (context, state) {
                              if (state is UpdateItemInCartSuccessState) {
                                widget.bloc.count--;
                              }
                            },
                            bloc: widget.bloc,
                            builder: (context, state) {
                              return IconButton(
                                onPressed: () {
                                  widget.updateBloc!.add(UpdateItemInCartEvent(
                                    id: widget.model.id,
                                    amount: widget.model.amount.toInt(),
                                  ));
                                  CacheHelper.setCount(count);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.minimize_sharp),
                                iconSize: 15.sp,
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                padding: const EdgeInsets.only(
                                  bottom: 9,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 120.w,
          ),
          //delet
          Container(
            width: 27.w,
            height: 27.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.h),
              color: const Color(0xffFF0000).withOpacity(.13),
            ),
            child: BlocConsumer(
              bloc: widget.bloc,
              listener: (context, state) {
                if (state is DeleteItemFromCartSuccessState) {
                  widget.onRemoveSuccess();
                }
              },
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  iconSize: 15.sp,
                  onPressed: () {
                    widget.deleteBloc!.add(DeleteItemFromCartEvent(id: widget.model.id));
                  },
                  color: const Color(0xffFF0000),
                  padding: const EdgeInsets.only(bottom: 2),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
