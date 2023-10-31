import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/design/app_button.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/design/app_input.dart';
import '../../../../core/logic/cashe_helper.dart';
import '../../../../core/logic/helper_methods.dart';
import '../../../../features/categories/cubit.dart';
import '../../../../features/categories/model.dart';
import '../../../../features/categories/states.dart';
import '../../../../features/products/cubit.dart';
import '../../../../features/products/model.dart';
import '../../../../features/products/states.dart';
import '../../../../features/sliders/cubit.dart';
import '../../../../features/sliders/states.dart';
import '../../../auth/login/view.dart';
import 'package:carousel_slider/carousel_slider.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: MainAppBar(),
          body: ListView(
            padding: EdgeInsets.all(16),
            children: [
              AppInput(
                icon: "assets/icons/svg/cart_icon.svg",
                hintText: "ابحث عن ماتريد؟",
              ),
              BlocBuilder<SliderCubit, SliderStates>(
                builder: (context, state) {
                  if (state is SliderLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SliderSuccessState) {
                    return Column(
                      children: [
                        CarouselSlider(
                          items: List.generate(
                              state.list.length,
                                  (index) =>
                                  AppImage(
                                    state.list[index].media,
                                    fit: BoxFit.fill,
                                    height: 164,
                                    width: double.infinity,
                                  )),
                          options: CarouselOptions(
                            height: 164,
                            autoPlay: true,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              currentIndex = index;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            state.list.length,
                                (index) =>
                                Padding(
                                    padding: EdgeInsetsDirectional.only(end: 3),
                                    child: CircleAvatar(
                                      radius: 4,
                                      backgroundColor: index == currentIndex
                                          ? Theme
                                          .of(context)
                                          .primaryColor
                                          : Color(0xff61880c),
                                    )),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text("Failed");
                  }
                },
              ),
              BlocBuilder<CategoriesCubit,CategoriesStates>(
                builder: (context, state) {
                  if (state is CategoriesLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CategoriesSuccessState) {
                    return SizedBox(
                      height: 139,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16,),
                          Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 16,
                            ),
                            child: Text(
                              "الاقسام",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                separatorBuilder: (context, index) =>
                                    SizedBox(
                                      width: 16,
                                    ),
                                itemBuilder: (context, index) =>
                                    _ItemCategory(
                                      model:state.list[index],
                                    ),
                                itemCount:state.list.length,
                                scrollDirection: Axis.horizontal,
                              )),
                        ],
                      ),
                    );
                  } else {
                    return Text("Failed");
                  }
              },),
              BlocBuilder<ProductCubit,ProductsStates>(
                  builder: (context, state) {
                    if (state is ProductsLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ProductsSuccessState) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16,),
                            Text("الاصناف"),
                            SizedBox(height: 6,),
                            GridView.builder(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 163/250,
                              ),
                              itemBuilder: (context, index) => _ItemProduct(
                                model: state.list[index],
                              ),
                              itemCount: state.list.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Text("Failed");
                    }
                  }),
            ],
          ),
        ),
    );
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          AppImage(
            "assets/images/logo.png",
            height: 21,
            width: 21,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            "سلة ثمار",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: "التوصيل إلى",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
                children: [
                  TextSpan(
                    text: "\n",
                  ),
                  TextSpan(
                    text: "شارع الملك فهد - جدة",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              CasheHelper.clear();
              navigateTo(LoginView());
            },
            child: Badge(
              alignment: AlignmentDirectional.topStart,
              label: Text(
                "3",
                style: TextStyle(
                  fontSize: 6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Container(
                height: 33,
                width: 33,
                padding: EdgeInsets.all(7),
                child: SvgPicture.asset("assets/icons/svg/cart_icon.svg"),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .primaryColor
                      .withOpacity(.13),
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _ItemCategory extends StatelessWidget {
  final CategoryModel model;

  const _ItemCategory({Key? key, required this.model,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 73,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 73,

              //padding: EdgeInsets.all(14),
              child: AppImage(
                model.media,
                fit: BoxFit.scaleDown,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(.1),
              ),
            ),
          ),
          SizedBox(height: 5,),
          Text(model.name),
        ],
      ),
    );
  }
}

class _ItemProduct extends StatelessWidget {
  final ProductModel model;
  const _ItemProduct({Key? key, required this.model,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Stack(
                  fit: StackFit.expand,
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    AppImage(
                      model.mainImage,
                      fit: BoxFit.cover,
                    ),
                   Align(
                     alignment: AlignmentDirectional.topEnd,
                     child:  Container(
                       padding: EdgeInsets.symmetric(
                         horizontal: 10,
                         vertical: 3,
                       ),
                       child: Text(
                         "${model.discount}%",
                         textDirection: TextDirection.ltr,
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 14,
                           color: Colors.white,
                         ),
                       ),
                       decoration: BoxDecoration(
                           color: Theme.of(context).primaryColor,
                           borderRadius: BorderRadiusDirectional.only(
                             bottomStart: Radius.circular(11),
                           )
                       ),
                     ),
                   )

                  ],
                ),
          ),
          ),
          SizedBox(height: 3,),
          Text(
            "${model.title}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 3,),
          Text(
            "السعر/ 1 ${model.unit.name}",
            style: TextStyle(color: Color(0xff808080),fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 3,),
          Text.rich(TextSpan(
            text: "ر.س${model.price}",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(text: "\t "),
              TextSpan(text: "ر.س${model.priceBeforeDiscount}",
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold)
              ),
            ],
          ),
          ),
          SizedBox(height: 16,),
          SizedBox(
            height: 35,
            child: AppButton(
              text: 'أضف الى السلة',
              onPress: (){},
            ),
          )
        ],
      ) ,
    );
  }
}