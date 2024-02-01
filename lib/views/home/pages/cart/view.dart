import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/app_button.dart';
import 'package:thimar/core/logic/helper_methods.dart';
import 'package:thimar/views/home/pages/end_order/view.dart';
import 'package:thimar/views/home/view.dart';
import '../../../../core/design/app_bar.dart';
import '../../../../features/home/pages/cart/get/bloc.dart';
import 'components/cart_item.dart';
import 'components/prices_detiles.dart';


class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

   final bloc = KiwiContainer().resolve<GetCartBloc>()..add(GetCartEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomAppBar(
                text: "السلة",
                onPress: () {
                  navigateTo(HomeView());
                },
              ),
              BlocBuilder(
                bloc: bloc,
                buildWhen: (previous, current) =>
                current is CartSuccessState ||
                    current is CartFieldState ||
                    current is CartLoadingState,
                builder: (context, state) {
                  if (state is CartSuccessState) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          Item(
                            model: state.model.list[index],
                            onRemoveSuccess: () {
                              state.model.list.removeWhere(
                                      (element) =>
                                  element.id == state.model.list[index].id);
                              setState(() {});
                            },
                          ),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 16.w),
                      itemCount: state.model.list.length,
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
              PricesDetails(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    text: "الانتقال لإتمام الطلب",
                    onPress: () {
                      navigateTo(const EndOrderView());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


