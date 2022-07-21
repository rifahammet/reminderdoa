import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailer2/mailer.dart';
import 'package:sweetalert/sweetalert.dart';

class EmailUtility {
/* mailer2 */

  void kirimEmail(
      {alamatEmail = '',
      isNoReply = false,
      bodyEmail,
      context,
      judulEmail,
      isEmailOnly = true,
      callBack}) async {
    FocusScope.of(context).requestFocus(FocusNode());

    // coba kirim email
    var resEmail = await send2(alamatEmail,
        isNoReply ? '[No Reply] -' + judulEmail : judulEmail, bodyEmail);
    // result email
    print(resEmail.toString());
    if (resEmail == "success") {
      if (isEmailOnly) {
        SweetAlert.show(
          context,
          title: "Email Information",
          subtitle: "email konfirmasi sudah terkirim",
          style: SweetAlertStyle.loadingSuccess,
        );
        await Future.delayed(new Duration(seconds: 3), () async {
          Navigator.of(context).pop();
        });
      } else {
        callBack(true);
      }
    } else {
      if (isEmailOnly) {
        SweetAlert.show(
          context,
          title: "Email Information",
          subtitle: "email konfirmasi tidak terkirim",
          style: SweetAlertStyle.loadingerror,
        );
        await Future.delayed(new Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
      } else {
        callBack(false);
      }
    }
  }

  // How you use and store passwords is up to you. Beware of storing passwords in plain.
  static Future<String> send2(penerima, subjek, isi) async {

    var options = SmtpOptions()
      ..hostName = 'mail.katalogdoa.com'
      
      ..port = 587
      ..username = 'admindoa@katalogdoa.com'
      ..password = 'K4t4l09d042022';
      

    // var options = new GmailSmtpOptions()
    //   ..username = 'dankeesaaonline@gmail.com'
    //   ..password = ''
    //   ..port =587; // Note: if you have Google's "app specific passwords" enabled,
    // you need to use one of those here.

    var emailTransport =  SmtpTransport(options);

    var envelope =  Envelope()
      ..from = options.username
      ..recipients.add(penerima)
      ..bccRecipients.add(options.username)
      ..subject = subjek
      //..attachments.add(new Attachment(file: new File('path/to/file')))
      ..text = isi
      ..html = isi;

    var ret = 'success';
    // Email it.
    await emailTransport.send(envelope).then((envelope) {
      print('email success');
      ret = 'success';
    }).catchError((e) {
      print('email err : $e');
      ret = e;
    });
    return ret;
  }
  // Create our email transport.

  List<String> attachments = [];
  // bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'example@example.com',
  );

  final _subjectController = TextEditingController(text: 'The subject');

  final _bodyController = TextEditingController(
    text: 'Mail body.',
  );

  static Future<String> send(
    bodi,
    subject,
    penerima,
    isHTML,
  ) async {
    final Email email = Email(
      body: bodi,
      subject: subject,
      recipients: [penerima],
      isHTML: isHTML,
    );

    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    //if (!mounted) return;

    return platformResponse;
  }
}
