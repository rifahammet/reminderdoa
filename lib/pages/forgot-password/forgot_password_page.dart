
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';



class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container()
      // LayoutBuilder(
      //   builder: (BuildContext context, BoxConstraints viewportConstraints) {
      //     return SingleChildScrollView(
      //       child: ConstrainedBox(
      //         constraints: BoxConstraints(
      //           minHeight: viewportConstraints.maxHeight,
      //         ),
      //         child: IntrinsicHeight(
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 38),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 Expanded(
      //                   child: SizedBox(
      //                     height: 80,
      //                   ),
      //                 ),
      //                 Text(
      //                   'forgot_password'.tr(),
      //                   style: TextStyle(
      //                     fontSize: 28,
      //                     fontWeight: FontWeight.w700,
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 30,
      //                 ),
      //                 WidgetForgot(),
      //                 Center(
      //                   child: FlatButton(
      //                     onPressed: () {
      //                       Navigator.of(context).pop();
      //                     },
      //                     child: Text(
      //                       'login'.tr(),
      //                       style: Theme.of(context)
      //                           .textTheme
      //                           .button
      //                           .copyWith(fontSize: 12),
      //                     ),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   flex: 2,
      //                   child: SizedBox(
      //                     height: 20,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

class WidgetForgot extends StatefulWidget {
  @override
  _WidgetForgotState createState() => _WidgetForgotState();
}

class _WidgetForgotState extends State<WidgetForgot> {
  final _emailController = TextEditingController();

 void hideSweetAlert(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: <Widget>[
    //     Text(
    //       'email_dot'.tr(),
    //       style: kInputTextStyle,
    //     ),
    //     CustomTextFormField(
    //       controller: _emailController,
    //       hintText: 'yourEmail@email.com',
    //     ),
    //     SizedBox(
    //       height: 35,
    //     ),
    //     CustomButton(
    //       onPressed: () async {
    //         if (_emailController.text.toString().trim() =='') {
    //           SweetAlert.show(
    //             context,
    //             subtitle: 'email_must_fill'.tr(),
    //             style: SweetAlertStyle.loadingerror,
    //           );
    //           new Future.delayed(new Duration(seconds: 4), () {
    //             hideSweetAlert(context);
    //           });
    //           // YToast.show(
    //           //     context: context,
    //           //     msg:
    //           //         "You cannot withdraw at this time\n                 please try later");
    //           // hideSweetAlert(context);
    //           return;
    //         }
    //         Auth auth = new Auth();
    //         // pr = ProgressDialog(context,
    //         //     type: ProgressDialogType.Normal,
    //         //     isDismissible: false,
    //         //     showLogs: true);
    //         // pr.style(
    //         //     message: '  Please wait...',
    //         //     borderRadius: 10.0,
    //         //     backgroundColor: Colors.white,
    //         //     // progressWidget: CircularProgressIndicator(),
    //         //     elevation: 10.0,
    //         //     insetAnimCurve: Curves.easeInOut,
    //         //     progress: 0.0,
    //         //     // textDirection: TextDirection.LTR,
    //         //     maxProgress: 100.0,
    //         //     progressTextStyle: TextStyle(
    //         //         color: Colors.black,
    //         //         fontSize: 13.0,
    //         //         fontWeight: FontWeight.w400),
    //         //     messageTextStyle: TextStyle(
    //         //         color: Colors.black,
    //         //         fontSize: 19.0,
    //         //         fontWeight: FontWeight.w600));
    //         // await pr.show();
    //         SweetAlert.show(context,
    //             subtitle: "please_wait".tr(), style: SweetAlertStyle.loading);
            
           

    //         var forgotPassword = <dynamic, dynamic>{
    //           "user_email": _emailController.text.toString()
    //         };

    //         Map<String, dynamic> result =
    //             await auth.saveNewData(forgotPassword, 'forgot');
    //         // await pr.hide();
    //         if (result['kode'] == 200) {
    //           if (result['isSuccess']) {
    //             // YToast.show(
    //             //     context: context,
    //             //     msg:
    //             //         'your payment confirmation is in process\n Please wait in a few hours');
    //             SweetAlert.show(
    //               context,
    //               subtitle: "forgot_password_in_process".tr(),
    //               style: SweetAlertStyle.loadingSuccess,
    //             );
    //             new Future.delayed(new Duration(seconds: 10), () {
    //               hideSweetAlert(context);
    //               Navigator.pop(context);
    //             });
    //           } else {
    //             SweetAlert.show(
    //               context,
    //               subtitle: result['error_message'],
    //               style: SweetAlertStyle.loadingerror,
    //             );
    //             new Future.delayed(new Duration(seconds: 4), () {
    //               hideSweetAlert(context);
    //             });

    //             // hideSweetAlert(context);
    //             // YToast.show(
    //             //     context: context,
    //             //     msg: result['error_message'] + '\nData has not been saved');
    //           }
    //         } else {
    //           SweetAlert.show(
    //             context,
    //             subtitle: result['error_message'],
    //             style: SweetAlertStyle.loadingerror,
    //           );
    //           new Future.delayed(new Duration(seconds: 4), () {
    //             hideSweetAlert(context);
    //           });

    //           // hideSweetAlert(context);
    //           // YToast.show(context: context, msg: result['error_message']);
    //         }
    //       },
    //       text: 'reset_password'.tr(),
    //     )
    //   ],
    // );
  }
}
