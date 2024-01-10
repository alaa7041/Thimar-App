import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/design/app_button.dart';
import 'package:thimar/core/logic/helper_methods.dart';
import 'package:thimar/views/home/pages/end_order/view.dart';
import 'package:thimar/views/home/view.dart';
import '../../../../core/design/app_bar.dart';
import '../../../../features/home/pages/cart/get/bloc.dart';
import '../../../../features/products/bloc.dart';
import 'components/cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late GetCartBloc bloc;

  late ProductModel model;

  @override
  void initState() {
    bloc = BlocProvider.of(context);
    bloc.add(CartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomAppBar(
              text: "السلة",
              onPress: () {
                navigateTo(HomeView());
              },
            ),
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
                      itemBuilder: (context, index) => Item(
                        model: state.list[index],
                        bloc: bloc,
                        onRemoveSuccess: () {
                          state.list.removeWhere(
                              (element) => element.id == state.list[index].id);
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
                SizedBox(height: 10.h),
                Text(
                  "جميع الأسعار تشمل قيمة الضريبة المضافة 15 % ",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15.sp,
                  ),
                ),
                Container(
                  height: 111.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Theme.of(context).primaryColor.withOpacity(.13),
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
                              color: Theme.of(context).primaryColor,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 167.w,
                          ),
                          Text("${bloc.totalProduct} ر.س",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 220.w,
                          ),
                          Text("-${bloc.discount} ر.س ",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15.sp,
                              )),
                        ],
                      ),
                      SizedBox(height: 15.h),
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
                              color: Theme.of(context).primaryColor,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(width: 220.w),
                          Text("${bloc.totalProduct - bloc.discount} ر.س ",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
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


