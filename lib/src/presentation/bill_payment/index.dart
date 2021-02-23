import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/src/presentation/bill_payment/bill_type/screen.dart';

class BillInitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _BuildFloatActionButton(() {
          Get.to(SelectBillTypeScreen());
        }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            AppTitleText1(title: "Transaction History",),

            /*AppText.largeTitle(
              "Transaction History",
            ),*/
            Expanded(
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return _BuildTransactionListItem(index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BuildTransactionListItem extends StatelessWidget {
  final int index;

  _BuildTransactionListItem(this.index);

  @override
  Widget build(BuildContext context) {


    Color color = Colors.blue;
    int status = 3;

    if (index % 3 == 0) {
      color = Colors.green;
      status = 1;
    } else if (index % 4 == 0) {
      color = Colors.red;
      status = 2;
    } else if (index % 5 == 0) {
      color = Colors.blue;
      status = 3;
    } else {
      color = Colors.blueGrey;
      status = 4;
    }

    return Container(
      padding: EdgeInsets.only(bottom: (index == 49) ? 100 :0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Provider",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "12/12/2021",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "₹ ",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: color),
                        ),
                        Text(
                          "50000.00",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: color),
                        ),
                      ],
                    ),

                    (status == 4)
                        ? Text("Refunded")
                        : (status == 3) ? Text("InProcessing") : Nothing()
                  ],
                )
              ],
            ),
          ),
          BuildHorizontalLine()
        ],
      ),
    );
  }
}

class _BuildFloatActionButton extends StatelessWidget {
  final VoidCallback onPress;

  _BuildFloatActionButton(this.onPress);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPress,
      icon: Icon(Icons.payment),
      label: Text("New Bill Payment"),
    );
  }
}
