// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter your mobile number`
  String get hint_input_phone {
    return Intl.message(
      'Enter your mobile number',
      name: 'hint_input_phone',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get select_language {
    return Intl.message(
      'Select Language',
      name: 'select_language',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Hello, what language do you want to use?`
  String get message_change_lang {
    return Intl.message(
      'Hello, what language do you want to use?',
      name: 'message_change_lang',
      desc: '',
      args: [],
    );
  }

  /// `Attendance`
  String get attendance {
    return Intl.message(
      'Attendance',
      name: 'attendance',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Present`
  String get present {
    return Intl.message(
      'Present',
      name: 'present',
      desc: '',
      args: [],
    );
  }

  /// `Half Day`
  String get half_day {
    return Intl.message(
      'Half Day',
      name: 'half_day',
      desc: '',
      args: [],
    );
  }

  /// `Late`
  String get late {
    return Intl.message(
      'Late',
      name: 'late',
      desc: '',
      args: [],
    );
  }

  /// `Absent`
  String get absent {
    return Intl.message(
      'Absent',
      name: 'absent',
      desc: '',
      args: [],
    );
  }

  /// `Holiday`
  String get holiday {
    return Intl.message(
      'Holiday',
      name: 'holiday',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Clock In`
  String get clock_in {
    return Intl.message(
      'Clock In',
      name: 'clock_in',
      desc: '',
      args: [],
    );
  }

  /// `Clock Out`
  String get clock_out {
    return Intl.message(
      'Clock Out',
      name: 'clock_out',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get action {
    return Intl.message(
      'Action',
      name: 'action',
      desc: '',
      args: [],
    );
  }

  /// `View Detail`
  String get view_detail {
    return Intl.message(
      'View Detail',
      name: 'view_detail',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get task {
    return Intl.message(
      'Task',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `Apps`
  String get apps {
    return Intl.message(
      'Apps',
      name: 'apps',
      desc: '',
      args: [],
    );
  }

  /// `Notice`
  String get notice {
    return Intl.message(
      'Notice',
      name: 'notice',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get view_all {
    return Intl.message(
      'View All',
      name: 'view_all',
      desc: '',
      args: [],
    );
  }

  /// `Notice Board`
  String get notice_board {
    return Intl.message(
      'Notice Board',
      name: 'notice_board',
      desc: '',
      args: [],
    );
  }

  /// `Attendance Overview`
  String get attendance_overview {
    return Intl.message(
      'Attendance Overview',
      name: 'attendance_overview',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Please log in to use this application`
  String get message_to_login {
    return Intl.message(
      'Please log in to use this application',
      name: 'message_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Choose the method for sending the OTP code`
  String get choose_method_send_otp {
    return Intl.message(
      'Choose the method for sending the OTP code',
      name: 'choose_method_send_otp',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP via {via}`
  String send_otp_via(Object via) {
    return Intl.message(
      'Send OTP via $via',
      name: 'send_otp_via',
      desc: '',
      args: [via],
    );
  }

  /// `Login With {via}`
  String login_with(Object via) {
    return Intl.message(
      'Login With $via',
      name: 'login_with',
      desc: '',
      args: [via],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get question_forget_pass {
    return Intl.message(
      'Forgot your password?',
      name: 'question_forget_pass',
      desc: '',
      args: [],
    );
  }

  /// `Click Here`
  String get click_here {
    return Intl.message(
      'Click Here',
      name: 'click_here',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get verify {
    return Intl.message(
      'Verification',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP code sent via`
  String get input_otp_via {
    return Intl.message(
      'Enter the OTP code sent via',
      name: 'input_otp_via',
      desc: '',
      args: [],
    );
  }

  /// `to the cellphone number`
  String get to_phone_number {
    return Intl.message(
      'to the cellphone number',
      name: 'to_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive the OTP code?`
  String get did_not_receive_code {
    return Intl.message(
      'Didn\'t receive the OTP code?',
      name: 'did_not_receive_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend the OTP code`
  String get resend_otp {
    return Intl.message(
      'Resend the OTP code',
      name: 'resend_otp',
      desc: '',
      args: [],
    );
  }

  /// `Please wait`
  String get please_wait {
    return Intl.message(
      'Please wait',
      name: 'please_wait',
      desc: '',
      args: [],
    );
  }

  /// `to resend the OTP code`
  String get to_resend_otp {
    return Intl.message(
      'to resend the OTP code',
      name: 'to_resend_otp',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Enter your E-Mail address`
  String get hint_input_email {
    return Intl.message(
      'Enter your E-Mail address',
      name: 'hint_input_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get hint_input_password {
    return Intl.message(
      'Enter your password',
      name: 'hint_input_password',
      desc: '',
      args: [],
    );
  }

  /// `Account Setting`
  String get account_setting {
    return Intl.message(
      'Account Setting',
      name: 'account_setting',
      desc: '',
      args: [],
    );
  }

  /// `My Files`
  String get my_files {
    return Intl.message(
      'My Files',
      name: 'my_files',
      desc: '',
      args: [],
    );
  }

  /// `Application Settings`
  String get app_setting {
    return Intl.message(
      'Application Settings',
      name: 'app_setting',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Term Of Use`
  String get term_of_use {
    return Intl.message(
      'Term Of Use',
      name: 'term_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get about_us {
    return Intl.message(
      'About Us',
      name: 'about_us',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get log_out {
    return Intl.message(
      'Log Out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get update_profile {
    return Intl.message(
      'Update Profile',
      name: 'update_profile',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Designation`
  String get designation {
    return Intl.message(
      'Designation',
      name: 'designation',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get department {
    return Intl.message(
      'Department',
      name: 'department',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get phone_number {
    return Intl.message(
      'Mobile Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Bank Name`
  String get bank_name {
    return Intl.message(
      'Bank Name',
      name: 'bank_name',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account Number`
  String get bank_number {
    return Intl.message(
      'Bank Account Number',
      name: 'bank_number',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account Name`
  String get bank_account_name {
    return Intl.message(
      'Bank Account Name',
      name: 'bank_account_name',
      desc: '',
      args: [],
    );
  }

  /// `Profile Picture`
  String get profile_picture {
    return Intl.message(
      'Profile Picture',
      name: 'profile_picture',
      desc: '',
      args: [],
    );
  }

  /// `Select Image`
  String get select_image {
    return Intl.message(
      'Select Image',
      name: 'select_image',
      desc: '',
      args: [],
    );
  }

  /// `Need My Approval`
  String get need_my_approval {
    return Intl.message(
      'Need My Approval',
      name: 'need_my_approval',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete`
  String get question_delete {
    return Intl.message(
      'Are you sure you want to delete',
      name: 'question_delete',
      desc: '',
      args: [],
    );
  }

  /// `Your file was successfully deleted`
  String get message_success_delete {
    return Intl.message(
      'Your file was successfully deleted',
      name: 'message_success_delete',
      desc: '',
      args: [],
    );
  }

  /// `Start downloading your file`
  String get message_start_download {
    return Intl.message(
      'Start downloading your file',
      name: 'message_start_download',
      desc: '',
      args: [],
    );
  }

  /// `Add New File`
  String get add_new_file {
    return Intl.message(
      'Add New File',
      name: 'add_new_file',
      desc: '',
      args: [],
    );
  }

  /// `Total hours worked today`
  String get total_hour_work_day {
    return Intl.message(
      'Total hours worked today',
      name: 'total_hour_work_day',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Doing`
  String get doing {
    return Intl.message(
      'Doing',
      name: 'doing',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Overdue`
  String get overdue {
    return Intl.message(
      'Overdue',
      name: 'overdue',
      desc: '',
      args: [],
    );
  }

  /// `Task Overview`
  String get task_overview {
    return Intl.message(
      'Task Overview',
      name: 'task_overview',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Contacts`
  String get emergency_contact {
    return Intl.message(
      'Emergency Contacts',
      name: 'emergency_contact',
      desc: '',
      args: [],
    );
  }

  /// `Select your favorite apps`
  String get select_favorite_app {
    return Intl.message(
      'Select your favorite apps',
      name: 'select_favorite_app',
      desc: '',
      args: [],
    );
  }

  /// `Your {type} Favorites`
  String your_favorites(Object type) {
    return Intl.message(
      'Your $type Favorites',
      name: 'your_favorites',
      desc: '',
      args: [type],
    );
  }

  /// `My Profile`
  String get my_profile {
    return Intl.message(
      'My Profile',
      name: 'my_profile',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Recover Password`
  String get recover_password {
    return Intl.message(
      'Recover Password',
      name: 'recover_password',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email and instructions will be sent to you`
  String get message_recover_password {
    return Intl.message(
      'Enter your email and instructions will be sent to you',
      name: 'message_recover_password',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get send_reset_link {
    return Intl.message(
      'Send Reset Link',
      name: 'send_reset_link',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get back_to_login {
    return Intl.message(
      'Back to Login',
      name: 'back_to_login',
      desc: '',
      args: [],
    );
  }

  /// `A recovery instructions has been sent`
  String get success_recover_password {
    return Intl.message(
      'A recovery instructions has been sent',
      name: 'success_recover_password',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email and follow the instructions`
  String get message_success_recover_password {
    return Intl.message(
      'Please check your email and follow the instructions',
      name: 'message_success_recover_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your WhatsApp number`
  String get hint_input_whatsapp_number {
    return Intl.message(
      'Enter your WhatsApp number',
      name: 'hint_input_whatsapp_number',
      desc: '',
      args: [],
    );
  }

  /// `Invalid format {type} is wrong`
  String invalid_format_input(Object type) {
    return Intl.message(
      'Invalid format $type is wrong',
      name: 'invalid_format_input',
      desc: '',
      args: [type],
    );
  }

  /// `This filed is required`
  String get required_input {
    return Intl.message(
      'This filed is required',
      name: 'required_input',
      desc: '',
      args: [],
    );
  }

  /// `{type} length must be more than {length} character`
  String minimum_input(Object type, Object length) {
    return Intl.message(
      '$type length must be more than $length character',
      name: 'minimum_input',
      desc: '',
      args: [type, length],
    );
  }

  /// `Looks like our server is busy, please try a while later`
  String get message_server_busy {
    return Intl.message(
      'Looks like our server is busy, please try a while later',
      name: 'message_server_busy',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection, Please try again later`
  String get message_time_out {
    return Intl.message(
      'No internet connection, Please try again later',
      name: 'message_time_out',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get reload {
    return Intl.message(
      'Reload',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Are you want to Log out?`
  String get message_confirm_logout {
    return Intl.message(
      'Are you want to Log out?',
      name: 'message_confirm_logout',
      desc: '',
      args: [],
    );
  }

  /// `Attendance Log`
  String get attendance_log {
    return Intl.message(
      'Attendance Log',
      name: 'attendance_log',
      desc: '',
      args: [],
    );
  }

  /// `Work Hours`
  String get work_hours {
    return Intl.message(
      'Work Hours',
      name: 'work_hours',
      desc: '',
      args: [],
    );
  }

  /// `Time Location`
  String get time_location {
    return Intl.message(
      'Time Location',
      name: 'time_location',
      desc: '',
      args: [],
    );
  }

  /// `Your Position`
  String get your_position {
    return Intl.message(
      'Your Position',
      name: 'your_position',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Your current location`
  String get your_current_location {
    return Intl.message(
      'Your current location',
      name: 'your_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Your office location`
  String get your_office_location {
    return Intl.message(
      'Your office location',
      name: 'your_office_location',
      desc: '',
      args: [],
    );
  }

  /// `Your location within a radius`
  String get location_in_radius {
    return Intl.message(
      'Your location within a radius',
      name: 'location_in_radius',
      desc: '',
      args: [],
    );
  }

  /// `Your location is outside the radius`
  String get location_out_radius {
    return Intl.message(
      'Your location is outside the radius',
      name: 'location_out_radius',
      desc: '',
      args: [],
    );
  }

  /// `Total hours worked`
  String get total_hours_worked {
    return Intl.message(
      'Total hours worked',
      name: 'total_hours_worked',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `View Photo`
  String get view_photo {
    return Intl.message(
      'View Photo',
      name: 'view_photo',
      desc: '',
      args: [],
    );
  }

  /// `View Location`
  String get view_location {
    return Intl.message(
      'View Location',
      name: 'view_location',
      desc: '',
      args: [],
    );
  }

  /// `You are a late`
  String get message_alert_late {
    return Intl.message(
      'You are a late',
      name: 'message_alert_late',
      desc: '',
      args: [],
    );
  }

  /// `You are arrived time`
  String get message_alert_on_time {
    return Intl.message(
      'You are arrived time',
      name: 'message_alert_on_time',
      desc: '',
      args: [],
    );
  }

  /// `Not yet your work hours`
  String get message_alert_no_work_hours {
    return Intl.message(
      'Not yet your work hours',
      name: 'message_alert_no_work_hours',
      desc: '',
      args: [],
    );
  }

  /// `Your face is not recognized`
  String get message_alert_no_face {
    return Intl.message(
      'Your face is not recognized',
      name: 'message_alert_no_face',
      desc: '',
      args: [],
    );
  }

  /// `Your face has been recognized`
  String get message_alert_with_face {
    return Intl.message(
      'Your face has been recognized',
      name: 'message_alert_with_face',
      desc: '',
      args: [],
    );
  }

  /// `Write Notes for Your Supervisor`
  String get write_note_to_supervisor {
    return Intl.message(
      'Write Notes for Your Supervisor',
      name: 'write_note_to_supervisor',
      desc: '',
      args: [],
    );
  }

  /// `Your attendance will be reviewed by your supervisor because you arrive late or your location is outside the radius or your face is not recognized`
  String get message_describe_reason_clock {
    return Intl.message(
      'Your attendance will be reviewed by your supervisor because you arrive late or your location is outside the radius or your face is not recognized',
      name: 'message_describe_reason_clock',
      desc: '',
      args: [],
    );
  }

  /// `You leave work on time`
  String get message_leave_on_time {
    return Intl.message(
      'You leave work on time',
      name: 'message_leave_on_time',
      desc: '',
      args: [],
    );
  }

  /// `Your time out is too early`
  String get message_home_early {
    return Intl.message(
      'Your time out is too early',
      name: 'message_home_early',
      desc: '',
      args: [],
    );
  }

  /// `Payroll`
  String get payroll {
    return Intl.message(
      'Payroll',
      name: 'payroll',
      desc: '',
      args: [],
    );
  }

  /// `Clock out early`
  String get clock_ot_early {
    return Intl.message(
      'Clock out early',
      name: 'clock_ot_early',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Leave Application`
  String get leave_application {
    return Intl.message(
      'Leave Application',
      name: 'leave_application',
      desc: '',
      args: [],
    );
  }

  /// `Inprocess`
  String get in_process {
    return Intl.message(
      'Inprocess',
      name: 'in_process',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Remaining leave this year`
  String get remaining_leave_year_label {
    return Intl.message(
      'Remaining leave this year',
      name: 'remaining_leave_year_label',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Add Leave Application`
  String get add_leave_application {
    return Intl.message(
      'Add Leave Application',
      name: 'add_leave_application',
      desc: '',
      args: [],
    );
  }

  /// `Leave Type`
  String get leave_type {
    return Intl.message(
      'Leave Type',
      name: 'leave_type',
      desc: '',
      args: [],
    );
  }

  /// `Leave Date From`
  String get leave_date_from {
    return Intl.message(
      'Leave Date From',
      name: 'leave_date_from',
      desc: '',
      args: [],
    );
  }

  /// `Leave Date Until`
  String get leave_date_until {
    return Intl.message(
      'Leave Date Until',
      name: 'leave_date_until',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reason {
    return Intl.message(
      'Reason',
      name: 'reason',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Select Leave Type`
  String get select_leave_type {
    return Intl.message(
      'Select Leave Type',
      name: 'select_leave_type',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this leave application?`
  String get question_confirm_cancel_leave {
    return Intl.message(
      'Are you sure you want to cancel this leave application?',
      name: 'question_confirm_cancel_leave',
      desc: '',
      args: [],
    );
  }

  /// `Resign Application`
  String get resign_application {
    return Intl.message(
      'Resign Application',
      name: 'resign_application',
      desc: '',
      args: [],
    );
  }

  /// `Create Resign Application`
  String get create_resign_application {
    return Intl.message(
      'Create Resign Application',
      name: 'create_resign_application',
      desc: '',
      args: [],
    );
  }

  /// `Seems like no resign application at this moment`
  String get message_empty_resign_application {
    return Intl.message(
      'Seems like no resign application at this moment',
      name: 'message_empty_resign_application',
      desc: '',
      args: [],
    );
  }

  /// `Submission Date of Resignation`
  String get resign_date {
    return Intl.message(
      'Submission Date of Resignation',
      name: 'resign_date',
      desc: '',
      args: [],
    );
  }

  /// `Upload Your File`
  String get upload_your_file {
    return Intl.message(
      'Upload Your File',
      name: 'upload_your_file',
      desc: '',
      args: [],
    );
  }

  /// `It takes 3 working days to process your resign application`
  String get message_create_resign_application {
    return Intl.message(
      'It takes 3 working days to process your resign application',
      name: 'message_create_resign_application',
      desc: '',
      args: [],
    );
  }

  /// `My resignation is`
  String get my_resignation_is {
    return Intl.message(
      'My resignation is',
      name: 'my_resignation_is',
      desc: '',
      args: [],
    );
  }

  /// `Browse File`
  String get browse_file {
    return Intl.message(
      'Browse File',
      name: 'browse_file',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this resign application?`
  String get question_confirm_cancel_resign {
    return Intl.message(
      'Are you sure you want to cancel this resign application?',
      name: 'question_confirm_cancel_resign',
      desc: '',
      args: [],
    );
  }

  /// `Contract End Date`
  String get end_contract {
    return Intl.message(
      'Contract End Date',
      name: 'end_contract',
      desc: '',
      args: [],
    );
  }

  /// `In accordance with the procedure, with a resignation letter 30 days before.`
  String get according_procedure_1 {
    return Intl.message(
      'In accordance with the procedure, with a resignation letter 30 days before.',
      name: 'according_procedure_1',
      desc: '',
      args: [],
    );
  }

  /// `Suddenly a resignation letter less than 30 days before or without a resignation letter, so I am willing to accept administrative sanctions in the form of a 50% wage.`
  String get according_procedure_2 {
    return Intl.message(
      'Suddenly a resignation letter less than 30 days before or without a resignation letter, so I am willing to accept administrative sanctions in the form of a 50% wage.',
      name: 'according_procedure_2',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `This application cannot be run because your device has root access.`
  String get message_app_use_root {
    return Intl.message(
      'This application cannot be run because your device has root access.',
      name: 'message_app_use_root',
      desc: '',
      args: [],
    );
  }

  /// `This application cannot be started because you used a tool to manipulate the location`
  String get message_app_use_mock_location {
    return Intl.message(
      'This application cannot be started because you used a tool to manipulate the location',
      name: 'message_app_use_mock_location',
      desc: '',
      args: [],
    );
  }

  /// `You don't have a leave quota this year`
  String get message_leave_quota_is_empty {
    return Intl.message(
      'You don\'t have a leave quota this year',
      name: 'message_leave_quota_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `Force Clock Out`
  String get force_clock_out {
    return Intl.message(
      'Force Clock Out',
      name: 'force_clock_out',
      desc: '',
      args: [],
    );
  }

  /// `Logs`
  String get logs {
    return Intl.message(
      'Logs',
      name: 'logs',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get schedule {
    return Intl.message(
      'Schedule',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activity {
    return Intl.message(
      'Activity',
      name: 'activity',
      desc: '',
      args: [],
    );
  }

  /// `Work Report`
  String get work_report {
    return Intl.message(
      'Work Report',
      name: 'work_report',
      desc: '',
      args: [],
    );
  }

  /// `Data is not yet available, because you have not checked in on this date tanggal`
  String get message_work_report_empty {
    return Intl.message(
      'Data is not yet available, because you have not checked in on this date tanggal',
      name: 'message_work_report_empty',
      desc: '',
      args: [],
    );
  }

  /// `Work Report Details`
  String get work_report_details {
    return Intl.message(
      'Work Report Details',
      name: 'work_report_details',
      desc: '',
      args: [],
    );
  }

  /// `Create Work Report`
  String get create_work_report {
    return Intl.message(
      'Create Work Report',
      name: 'create_work_report',
      desc: '',
      args: [],
    );
  }

  /// `Your Location`
  String get your_location {
    return Intl.message(
      'Your Location',
      name: 'your_location',
      desc: '',
      args: [],
    );
  }

  /// `Report Title`
  String get report_title {
    return Intl.message(
      'Report Title',
      name: 'report_title',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Report Photos`
  String get report_photos {
    return Intl.message(
      'Report Photos',
      name: 'report_photos',
      desc: '',
      args: [],
    );
  }

  /// `Photos`
  String get photos {
    return Intl.message(
      'Photos',
      name: 'photos',
      desc: '',
      args: [],
    );
  }

  /// `Can only be edited during active work on that day`
  String get cannot_edit_work_report_message {
    return Intl.message(
      'Can only be edited during active work on that day',
      name: 'cannot_edit_work_report_message',
      desc: '',
      args: [],
    );
  }

  /// `Normal`
  String get normal {
    return Intl.message(
      'Normal',
      name: 'normal',
      desc: '',
      args: [],
    );
  }

  /// `Upload Report Files`
  String get upload_report_files {
    return Intl.message(
      'Upload Report Files',
      name: 'upload_report_files',
      desc: '',
      args: [],
    );
  }

  /// `Report Files`
  String get report_files {
    return Intl.message(
      'Report Files',
      name: 'report_files',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get leave {
    return Intl.message(
      'Leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `Start Downloading File...`
  String get start_downloading_file {
    return Intl.message(
      'Start Downloading File...',
      name: 'start_downloading_file',
      desc: '',
      args: [],
    );
  }

  /// `{count} remaining`
  String remaining(Object count) {
    return Intl.message(
      '$count remaining',
      name: 'remaining',
      desc: '',
      args: [count],
    );
  }

  /// `Auto Start Permission`
  String get auto_start_permission {
    return Intl.message(
      'Auto Start Permission',
      name: 'auto_start_permission',
      desc: '',
      args: [],
    );
  }

  /// `Recording Work Locations`
  String get tracking_location_notification_title {
    return Intl.message(
      'Recording Work Locations',
      name: 'tracking_location_notification_title',
      desc: '',
      args: [],
    );
  }

  /// `Don't turn off your cellphone and make sure it's still connected to the internet.`
  String get tracking_location_notification_message {
    return Intl.message(
      'Don\'t turn off your cellphone and make sure it\'s still connected to the internet.',
      name: 'tracking_location_notification_message',
      desc: '',
      args: [],
    );
  }

  /// `Schedule and Attendance`
  String get schedule_and_attendance {
    return Intl.message(
      'Schedule and Attendance',
      name: 'schedule_and_attendance',
      desc: '',
      args: [],
    );
  }

  /// `Upload Support File`
  String get upload_support_file {
    return Intl.message(
      'Upload Support File',
      name: 'upload_support_file',
      desc: '',
      args: [],
    );
  }

  /// `Can only upload photos. Please contact admin to change profile data`
  String get cannot_update_profile_information {
    return Intl.message(
      'Can only upload photos. Please contact admin to change profile data',
      name: 'cannot_update_profile_information',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, during work you can't log out. Please leave first`
  String get cannot_logout_intrack_message {
    return Intl.message(
      'Sorry, during work you can\'t log out. Please leave first',
      name: 'cannot_logout_intrack_message',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Allow Device Location Access`
  String get track_location_permission_title {
    return Intl.message(
      'Allow Device Location Access',
      name: 'track_location_permission_title',
      desc: '',
      args: [],
    );
  }

  /// `{appName} will collect location data to allow location tracking when the application is closed and started when work has started IF YOUR OFFICE IS ON. {appName} starts collecting locations on entry to work and ends on completion of work. So that we can find out where your work position is when you work.\n\nThis data will be uploaded to the admin dashboard where you work and can view and/or delete location history.`
  String track_location_permission_message(Object appName) {
    return Intl.message(
      '$appName will collect location data to allow location tracking when the application is closed and started when work has started IF YOUR OFFICE IS ON. $appName starts collecting locations on entry to work and ends on completion of work. So that we can find out where your work position is when you work.\n\nThis data will be uploaded to the admin dashboard where you work and can view and/or delete location history.',
      name: 'track_location_permission_message',
      desc: '',
      args: [appName],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Optional Files`
  String get optional_files {
    return Intl.message(
      'Optional Files',
      name: 'optional_files',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect {
    return Intl.message(
      'Connect',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Change Url`
  String get change_url {
    return Intl.message(
      'Change Url',
      name: 'change_url',
      desc: '',
      args: [],
    );
  }

  /// `Allow`
  String get allow {
    return Intl.message(
      'Allow',
      name: 'allow',
      desc: '',
      args: [],
    );
  }

  /// `Unable to retrieve the current location, try to recheck the location is active and also the permissions.`
  String get cannot_retrive_location_message {
    return Intl.message(
      'Unable to retrieve the current location, try to recheck the location is active and also the permissions.',
      name: 'cannot_retrive_location_message',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure the {todo} task is complete?`
  String confirmation_set_complete_todo(Object todo) {
    return Intl.message(
      'Are you sure the $todo task is complete?',
      name: 'confirmation_set_complete_todo',
      desc: '',
      args: [todo],
    );
  }

  /// `Work From Office`
  String get work_from_office {
    return Intl.message(
      'Work From Office',
      name: 'work_from_office',
      desc: '',
      args: [],
    );
  }

  /// `Work From Anywhere`
  String get work_from_anywhere {
    return Intl.message(
      'Work From Anywhere',
      name: 'work_from_anywhere',
      desc: '',
      args: [],
    );
  }

  /// `Move Offline`
  String get move_offline {
    return Intl.message(
      'Move Offline',
      name: 'move_offline',
      desc: '',
      args: [],
    );
  }

  /// `Move Online`
  String get move_online {
    return Intl.message(
      'Move Online',
      name: 'move_online',
      desc: '',
      args: [],
    );
  }

  /// `Connected to the Network`
  String get connected_to_network {
    return Intl.message(
      'Connected to the Network',
      name: 'connected_to_network',
      desc: '',
      args: [],
    );
  }

  /// `Disconnected from the Network`
  String get disconnected_from_network {
    return Intl.message(
      'Disconnected from the Network',
      name: 'disconnected_from_network',
      desc: '',
      args: [],
    );
  }

  /// `Pending Attendance`
  String get pending_attendance {
    return Intl.message(
      'Pending Attendance',
      name: 'pending_attendance',
      desc: '',
      args: [],
    );
  }

  /// `Your offline attendance has not been synced wait until you have an internet connection.`
  String get pending_data_attendance_message {
    return Intl.message(
      'Your offline attendance has not been synced wait until you have an internet connection.',
      name: 'pending_data_attendance_message',
      desc: '',
      args: [],
    );
  }

  /// `Resolved Attendance`
  String get resolved_attendance {
    return Intl.message(
      'Resolved Attendance',
      name: 'resolved_attendance',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Choose File From`
  String get pick_file_from_title {
    return Intl.message(
      'Choose File From',
      name: 'pick_file_from_title',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Waiting`
  String get waiting {
    return Intl.message(
      'Waiting',
      name: 'waiting',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get approved {
    return Intl.message(
      'Approved',
      name: 'approved',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get rejected {
    return Intl.message(
      'Rejected',
      name: 'rejected',
      desc: '',
      args: [],
    );
  }

  /// `Attendance Without Schedule`
  String get warning_home_attendance_without_schedule_title {
    return Intl.message(
      'Attendance Without Schedule',
      name: 'warning_home_attendance_without_schedule_title',
      desc: '',
      args: [],
    );
  }

  /// `You don't have a schedule today, every attendance will require Admin confirmation!`
  String get warning_home_attendance_clock_in_without_schedule_subtitle {
    return Intl.message(
      'You don\'t have a schedule today, every attendance will require Admin confirmation!',
      name: 'warning_home_attendance_clock_in_without_schedule_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `After clock out, your attendance will be recorded in the system but need confirmation from Admin to approve your attendance!`
  String get warning_home_attendance_clock_out_without_schedule_subtitle {
    return Intl.message(
      'After clock out, your attendance will be recorded in the system but need confirmation from Admin to approve your attendance!',
      name: 'warning_home_attendance_clock_out_without_schedule_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `You have done your attendance today, but your attendance needs confirmation from Admin!`
  String
      get warning_home_attendance_alread_attendance_without_schedule_subtitle {
    return Intl.message(
      'You have done your attendance today, but your attendance needs confirmation from Admin!',
      name:
          'warning_home_attendance_alread_attendance_without_schedule_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Attendance`
  String get cancel_attendance {
    return Intl.message(
      'Cancel Attendance',
      name: 'cancel_attendance',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this attendance?\nYou can re-do the attendance after canceling it.`
  String get cancel_attendance_confirmation_message {
    return Intl.message(
      'Are you sure you want to cancel this attendance?\nYou can re-do the attendance after canceling it.',
      name: 'cancel_attendance_confirmation_message',
      desc: '',
      args: [],
    );
  }

  /// `Slide to start break`
  String get start_break {
    return Intl.message(
      'Slide to start break',
      name: 'start_break',
      desc: '',
      args: [],
    );
  }

  /// `Break Time`
  String get break_time {
    return Intl.message(
      'Break Time',
      name: 'break_time',
      desc: '',
      args: [],
    );
  }

  /// `Slide to continue work`
  String get back_to_work {
    return Intl.message(
      'Slide to continue work',
      name: 'back_to_work',
      desc: '',
      args: [],
    );
  }

  /// `You are connected to the domain :`
  String get connected_to_domain {
    return Intl.message(
      'You are connected to the domain :',
      name: 'connected_to_domain',
      desc: '',
      args: [],
    );
  }

  /// `Input URL`
  String get input_url {
    return Intl.message(
      'Input URL',
      name: 'input_url',
      desc: '',
      args: [],
    );
  }

  /// `Make sure the domain you entered is correct and your connection is connected`
  String get make_sure_the_domain_and_connection {
    return Intl.message(
      'Make sure the domain you entered is correct and your connection is connected',
      name: 'make_sure_the_domain_and_connection',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the URL to continue`
  String get enter_the_url {
    return Intl.message(
      'Please enter the URL to continue',
      name: 'enter_the_url',
      desc: '',
      args: [],
    );
  }

  /// `Request Details`
  String get approval_request_details {
    return Intl.message(
      'Request Details',
      name: 'approval_request_details',
      desc: '',
      args: [],
    );
  }

  /// `Request Information`
  String get approval_request_information {
    return Intl.message(
      'Request Information',
      name: 'approval_request_information',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Additional File`
  String get additional_file {
    return Intl.message(
      'Additional File',
      name: 'additional_file',
      desc: '',
      args: [],
    );
  }

  /// `Request Successfully Approved`
  String get approval_request_approved_message {
    return Intl.message(
      'Request Successfully Approved',
      name: 'approval_request_approved_message',
      desc: '',
      args: [],
    );
  }

  /// `Request Successfully Rejected`
  String get approval_request_rejected_message {
    return Intl.message(
      'Request Successfully Rejected',
      name: 'approval_request_rejected_message',
      desc: '',
      args: [],
    );
  }

  /// `Approve`
  String get approve {
    return Intl.message(
      'Approve',
      name: 'approve',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get reject {
    return Intl.message(
      'Reject',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to approve this request?`
  String get approve_status_request {
    return Intl.message(
      'Are you sure to approve this request?',
      name: 'approve_status_request',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to reject this request?`
  String get reject_status_request {
    return Intl.message(
      'Are you sure to reject this request?',
      name: 'reject_status_request',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Employee`
  String get employee {
    return Intl.message(
      'Employee',
      name: 'employee',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Time Range`
  String get time_range {
    return Intl.message(
      'Time Range',
      name: 'time_range',
      desc: '',
      args: [],
    );
  }

  /// `Attandence`
  String get attandence {
    return Intl.message(
      'Attandence',
      name: 'attandence',
      desc: '',
      args: [],
    );
  }

  /// `Date Change`
  String get date_change {
    return Intl.message(
      'Date Change',
      name: 'date_change',
      desc: '',
      args: [],
    );
  }

  /// `Reset All`
  String get reset_all {
    return Intl.message(
      'Reset All',
      name: 'reset_all',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sort_by {
    return Intl.message(
      'Sort By',
      name: 'sort_by',
      desc: '',
      args: [],
    );
  }

  /// `Time Off`
  String get time_off {
    return Intl.message(
      'Time Off',
      name: 'time_off',
      desc: '',
      args: [],
    );
  }

  /// `Request Type`
  String get request_type {
    return Intl.message(
      'Request Type',
      name: 'request_type',
      desc: '',
      args: [],
    );
  }

  /// `New First`
  String get new_first {
    return Intl.message(
      'New First',
      name: 'new_first',
      desc: '',
      args: [],
    );
  }

  /// `Old First`
  String get old_first {
    return Intl.message(
      'Old First',
      name: 'old_first',
      desc: '',
      args: [],
    );
  }

  /// `Search Employee`
  String get search_employee {
    return Intl.message(
      'Search Employee',
      name: 'search_employee',
      desc: '',
      args: [],
    );
  }

  /// `Seems like no request at this moment`
  String get no_data_approval_request {
    return Intl.message(
      'Seems like no request at this moment',
      name: 'no_data_approval_request',
      desc: '',
      args: [],
    );
  }

  /// `No Users Found`
  String get no_users_found {
    return Intl.message(
      'No Users Found',
      name: 'no_users_found',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Recomended resolution 400 x 400 px`
  String get recomended_resolution {
    return Intl.message(
      'Recomended resolution 400 x 400 px',
      name: 'recomended_resolution',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get offline {
    return Intl.message(
      'Offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `There doesn't seem to be any leave applications at this time`
  String get leave_list_empty {
    return Intl.message(
      'There doesn\'t seem to be any leave applications at this time',
      name: 'leave_list_empty',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detail {
    return Intl.message(
      'Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `There seems to be no payroll for you to view`
  String get payroll_list_empty {
    return Intl.message(
      'There seems to be no payroll for you to view',
      name: 'payroll_list_empty',
      desc: '',
      args: [],
    );
  }

  /// `Select Month`
  String get select_month {
    return Intl.message(
      'Select Month',
      name: 'select_month',
      desc: '',
      args: [],
    );
  }

  /// `Pilih Year`
  String get select_year {
    return Intl.message(
      'Pilih Year',
      name: 'select_year',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'id'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
