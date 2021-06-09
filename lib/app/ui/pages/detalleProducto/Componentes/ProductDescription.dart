// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopend/app/common/utils/size_config.dart';
import 'package:shopend/app/domain/model/_models.dart';

class ProductDescription extends StatefulWidget {
  Producto product;
  GestureTapCallback pressOnSeeMore;

  ProductDescription({
    Key key,
    this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}


class _ProductDescriptionState extends State<ProductDescription> {

  Producto product;
  GestureTapCallback pressOnSeeMore;
  bool isMore = false;


  @override
  void initState() {
    super.initState();
    product = widget.product;
    pressOnSeeMore = widget.pressOnSeeMore;
  }

  void setBoolean(){
    setState(() {
      isMore = !isMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20, context: context)),
          child: Text(
            product.nombre,
            style: Theme
                .of(context)
                .textTheme
                .headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(
                getProportionateScreenWidth(15, context: context)),
            width: getProportionateScreenWidth(64, context: context),
            decoration: BoxDecoration(
              color: Color(0xFFFFE6E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              "assets/logos/Heart_Icon.svg",
              color: Color(0xFFFF4848),
              height: getProportionateScreenWidth(16, context: context),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20, context: context),
            right: getProportionateScreenWidth(64, context: context),
          ),
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 100),
            crossFadeState: isMore ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: Text(product.descripcion,
            ),
            secondChild: Text(
              product.descripcion,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20, context: context),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {setBoolean();},
            child: Row(
              children: [
                Text(
                  "+",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(240, 165, 165, 4.0),),
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
        )
      ],
    );
  }
}