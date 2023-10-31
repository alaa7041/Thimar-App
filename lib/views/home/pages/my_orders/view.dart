import 'package:flutter/material.dart';

class MyOrdersPages extends StatelessWidget {
  const MyOrdersPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("طلباتي"),
        ),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) => _Item(),
          itemCount: 4,
          padding: EdgeInsets.all(16)),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            offset: Offset(0, 6),
            blurRadius: 17,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      height: 130,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "طلب #4587",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                "يونيو,2021,27",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff9C9C9C),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  ...List.generate(
                      3,
                      (index) => Container(
                        height: 35,
                        width: 35,
                        margin: EdgeInsetsDirectional.only(end: 3),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xffEDF5E6).withOpacity(.6),
                          ),
                        ),
                        child: Image.network(
                          "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/two-tomatoes-with-clipping-path-ursula-alter.jpg",
                          fit: BoxFit.fill,
                        ),
                      )),
                  Container(
                    height: 35,
                    width: 35,
                    margin: EdgeInsetsDirectional.only(end: 3),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xffEDF5E6),
                      border: Border.all(
                        color: Color(0xffEDF5E6).withOpacity(.6),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "2+",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(right: 15),
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                height: 23,
                width: 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Theme.of(context).primaryColor.withOpacity(.13),
                ),
                child: Center(
                  child: Text(
                    "بإنتظار الموافقة",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              Text(
                "180ر.س",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
