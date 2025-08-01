// ignore_for_file: curly_braces_in_flow_control_structures, unused_import, unused_local_variable, unnecessary_import, use_build_context_synchronously, empty_catches

import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profacademy/models/api_request.dart';
import 'package:profacademy/models/login_func.dart';
import 'package:profacademy/pages/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:profacademy/shared/shared_colors.dart';
import 'package:profacademy/widgets/custom_form_button.dart';
import 'package:profacademy/widgets/custom_input_field.dart';
import 'package:profacademy/widgets/dont_have_an_account.dart';
import 'package:profacademy/widgets/page_header.dart';
import 'package:profacademy/widgets/page_heading.dart';
import 'package:profacademy/widgets/social.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInScreen signInScreen = SignInScreen();
  Map<String, dynamic> myData = {};
  // المتغير اللي هيخزن فيه البيانات
  final Dio dio = Dio();
  final codeController = TextEditingController();
  bool isCode = false;
  bool userLoadingState = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // الحصول على DeviceId عند تحميل الشاشة
    _testDeviceId();
  }

  Future<void> _testDeviceId() async {
    log('=== Testing Device ID ===');
    print('=== Testing Device ID ===');

    // عرض معلومات المنصة
    final platform =
        Platform.isAndroid
            ? 'Android'
            : Platform.isIOS
            ? 'iOS'
            : Platform.isWindows
            ? 'Windows'
            : Platform.isMacOS
            ? 'macOS'
            : Platform.isLinux
            ? 'Linux'
            : 'Web';

    log('Platform: $platform');
    print('Platform: $platform');

    final deviceId = await getDeviceId();
    log('Final Device ID: $deviceId');
    print('Final Device ID: $deviceId');

    log('=== End Device ID Test ===');
    print('=== End Device ID Test ===');
  }

  Future<String> getDeviceId() async {
    try {
      // محاولة الحصول على DeviceId الفعلي من الجهاز
      final deviceInfo = DeviceInfoPlugin();
      String deviceId = '';

      // تحديد المنصة أولاً
      final platform =
          Platform.isAndroid
              ? 'Android'
              : Platform.isIOS
              ? 'iOS'
              : Platform.isWindows
              ? 'Windows'
              : Platform.isMacOS
              ? 'macOS'
              : Platform.isLinux
              ? 'Linux'
              : 'Web';

      log('محاولة الحصول على Device ID الفعلي للمنصة: $platform');
      print('محاولة الحصول على Device ID الفعلي للمنصة: $platform');

      if (Platform.isAndroid) {
        try {
          final androidInfo = await deviceInfo.androidInfo;
          final deviceName =
              (androidInfo.model.isNotEmpty == true)
                  ? androidInfo.model
                  : 'Unknown';
          final brand =
              (androidInfo.brand.isNotEmpty == true)
                  ? androidInfo.brand
                  : 'Unknown';
          final version =
              (androidInfo.version.release.isNotEmpty == true)
                  ? androidInfo.version.release
                  : 'Unknown';
          final sdkInt = androidInfo.version.sdkInt.toString();

          // إنشاء deviceId مفصل
          deviceId =
              '${androidInfo.id}_${brand}_${deviceName}_SDK${sdkInt}_${version}';

          log('✅ تم الحصول على Android Device ID المفصل: $deviceId');
          print('✅ تم الحصول على Android Device ID المفصل: $deviceId');
          log(
            '📱 تفاصيل الجهاز: Brand=$brand, Model=$deviceName, SDK=$sdkInt, Version=$version',
          );
          print(
            '📱 تفاصيل الجهاز: Brand=$brand, Model=$deviceName, SDK=$sdkInt, Version=$version',
          );

          return deviceId;
        } catch (e) {
          log('❌ فشل في الحصول على Android Device ID: $e');
          print('❌ فشل في الحصول على Android Device ID: $e');
          throw e;
        }
      } else if (Platform.isIOS) {
        try {
          final iosInfo = await deviceInfo.iosInfo;
          final deviceName = iosInfo.name.isNotEmpty ? iosInfo.name : 'Unknown';
          final model = iosInfo.model.isNotEmpty ? iosInfo.model : 'Unknown';
          final systemVersion =
              iosInfo.systemVersion.isNotEmpty
                  ? iosInfo.systemVersion
                  : 'Unknown';
          final identifier = iosInfo.identifierForVendor ?? '';

          if (identifier.isNotEmpty) {
            deviceId =
                '${identifier}_${deviceName}_${model}_iOS${systemVersion}';
            log('✅ تم الحصول على iOS Device ID المفصل: $deviceId');
            print('✅ تم الحصول على iOS Device ID المفصل: $deviceId');
            log(
              '📱 تفاصيل الجهاز: Name=$deviceName, Model=$model, iOS=$systemVersion',
            );
            print(
              '📱 تفاصيل الجهاز: Name=$deviceName, Model=$model, iOS=$systemVersion',
            );
            return deviceId;
          } else {
            throw Exception('iOS Device ID فارغ');
          }
        } catch (e) {
          log('❌ فشل في الحصول على iOS Device ID: $e');
          print('❌ فشل في الحصول على iOS Device ID: $e');
          throw e;
        }
      } else if (Platform.isWindows) {
        try {
          final windowsInfo = await deviceInfo.windowsInfo;
          final computerName =
              windowsInfo.computerName.isNotEmpty
                  ? windowsInfo.computerName
                  : 'Unknown';
          final productName =
              windowsInfo.productName.isNotEmpty
                  ? windowsInfo.productName
                  : 'Unknown';
          final majorVersion = windowsInfo.majorVersion.toString();
          final minorVersion = windowsInfo.minorVersion.toString();

          deviceId =
              '${windowsInfo.deviceId}_${computerName}_${productName}_${majorVersion}.${minorVersion}';
          log('✅ تم الحصول على Windows Device ID المفصل: $deviceId');
          print('✅ تم الحصول على Windows Device ID المفصل: $deviceId');
          log(
            '📱 تفاصيل الجهاز: Computer=$computerName, Product=$productName, Version=$majorVersion.$minorVersion',
          );
          print(
            '📱 تفاصيل الجهاز: Computer=$computerName, Product=$productName, Version=$majorVersion.$minorVersion',
          );
          return deviceId;
        } catch (e) {
          log('❌ فشل في الحصول على Windows Device ID: $e');
          print('❌ فشل في الحصول على Windows Device ID: $e');
          throw e;
        }
      } else if (Platform.isMacOS) {
        try {
          final macOsInfo = await deviceInfo.macOsInfo;
          final computerName =
              macOsInfo.computerName.isNotEmpty
                  ? macOsInfo.computerName
                  : 'Unknown';
          final hostName =
              macOsInfo.hostName.isNotEmpty ? macOsInfo.hostName : 'Unknown';
          final osRelease =
              macOsInfo.osRelease.isNotEmpty ? macOsInfo.osRelease : 'Unknown';
          final systemGUID = macOsInfo.systemGUID ?? '';

          if (systemGUID.isNotEmpty) {
            deviceId =
                '${systemGUID}_${computerName}_${hostName}_macOS${osRelease}';
            log('✅ تم الحصول على macOS Device ID المفصل: $deviceId');
            print('✅ تم الحصول على macOS Device ID المفصل: $deviceId');
            log(
              '📱 تفاصيل الجهاز: Computer=$computerName, Host=$hostName, macOS=$osRelease',
            );
            print(
              '📱 تفاصيل الجهاز: Computer=$computerName, Host=$hostName, macOS=$osRelease',
            );
            return deviceId;
          } else {
            throw Exception('macOS Device ID فارغ');
          }
        } catch (e) {
          log('❌ فشل في الحصول على macOS Device ID: $e');
          print('❌ فشل في الحصول على macOS Device ID: $e');
          throw e;
        }
      } else if (Platform.isLinux) {
        try {
          final linuxInfo = await deviceInfo.linuxInfo;
          final name =
              (linuxInfo.name.isNotEmpty == true)
                  ? linuxInfo.name
                  : 'Unknown';
          final version =
              (linuxInfo.version?.isNotEmpty == true)
                  ? linuxInfo.version!
                  : 'Unknown';
          final machineId = linuxInfo.machineId ?? '';

          if (machineId.isNotEmpty) {
            deviceId = '${machineId}_${name}_${version}';
            log('✅ تم الحصول على Linux Device ID المفصل: $deviceId');
            print('✅ تم الحصول على Linux Device ID المفصل: $deviceId');
            log('📱 تفاصيل الجهاز: Name=$name, Version=$version');
            print('📱 تفاصيل الجهاز: Name=$name, Version=$version');
            return deviceId;
          } else {
            throw Exception('Linux Device ID فارغ');
          }
        } catch (e) {
          log('❌ فشل في الحصول على Linux Device ID: $e');
          print('❌ فشل في الحصول على Linux Device ID: $e');
          throw e;
        }
      } else {
        // للمنصات الأخرى، نستخدم timestamp مع معلومات إضافية
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final microsecond = DateTime.now().microsecond;
        final nanosecond = DateTime.now().microsecondsSinceEpoch % 1000;
        final date = DateTime.now().toIso8601String().split('T')[0];
        final time =
            DateTime.now().toIso8601String().split('T')[1].split('.')[0];
        final random = (timestamp % 10000).toString().padLeft(4, '0');

        deviceId =
            'Web_${date}_${time}_${timestamp}_${random}_${microsecond}_${nanosecond}';
        log('🌐 تم إنشاء Web Device ID المفصل: $deviceId');
        print('🌐 تم إنشاء Web Device ID المفصل: $deviceId');
        log(
          '📅 Web Details: Date=$date, Time=$time, Timestamp=$timestamp, Random=$random, Micro=$microsecond, Nano=$nanosecond',
        );
        print(
          '📅 Web Details: Date=$date, Time=$time, Timestamp=$timestamp, Random=$random, Micro=$microsecond, Nano=$nanosecond',
        );
        return deviceId;
      }
    } catch (e) {
      log('❌ فشل في الحصول على Device ID الفعلي: $e');
      print('❌ فشل في الحصول على Device ID الفعلي: $e');

      // محاولة استخدام SharedPreferences للحصول على DeviceId محفوظ سابقاً
      try {
        log('🔄 محاولة استخدام Device ID محفوظ...');
        print('🔄 محاولة استخدام Device ID محفوظ...');
        return await _getOrCreateStoredDeviceId();
      } catch (sharedPrefsError) {
        log('❌ فشل في استخدام Device ID محفوظ: $sharedPrefsError');
        print('❌ فشل في استخدام Device ID محفوظ: $sharedPrefsError');

        // Fallback نهائي: إنشاء DeviceId مؤقت
        log('⚠️ استخدام Device ID مؤقت...');
        print('⚠️ استخدام Device ID مؤقت...');
        return _generateFallbackDeviceId();
      }
    }
  }

  String _generateFallbackDeviceId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 10000).toString().padLeft(4, '0');
    final platform =
        Platform.isAndroid
            ? 'android'
            : Platform.isIOS
            ? 'ios'
            : Platform.isWindows
            ? 'windows'
            : Platform.isMacOS
            ? 'macos'
            : Platform.isLinux
            ? 'linux'
            : 'web';

    // إضافة معلومات إضافية لضمان التفرد
    final microsecond = DateTime.now().microsecond;
    final nanosecond = DateTime.now().microsecondsSinceEpoch % 1000;
    final date = DateTime.now().toIso8601String().split('T')[0];
    final time = DateTime.now().toIso8601String().split('T')[1].split('.')[0];

    final uniqueId =
        '${platform}_${date}_${time}_${timestamp}_${random}_${microsecond}_${nanosecond}';

    log('Generated detailed fallback Device ID: $uniqueId');
    print('Generated detailed fallback Device ID: $uniqueId');
    log(
      '📅 Date: $date, 🕐 Time: $time, ⏱️ Timestamp: $timestamp, 🎲 Random: $random, ⚡ Micro: $microsecond, ⚡ Nano: $nanosecond',
    );
    print(
      '📅 Date: $date, 🕐 Time: $time, ⏱️ Timestamp: $timestamp, 🎲 Random: $random, ⚡ Micro: $microsecond, ⚡ Nano: $nanosecond',
    );
    return uniqueId;
  }

  Future<String> _getOrCreateStoredDeviceId() async {
    try {
      log('Initializing SharedPreferences...');
      print('Initializing SharedPreferences...');

      // إضافة تأخير قصير لضمان تهيئة Flutter engine
      await Future.delayed(const Duration(milliseconds: 100));

      final prefs = await SharedPreferences.getInstance();
      log('SharedPreferences initialized successfully');
      print('SharedPreferences initialized successfully');

      String? storedDeviceId = prefs.getString('device_id');

      if (storedDeviceId != null && storedDeviceId.isNotEmpty) {
        log('Retrieved stored Device ID: $storedDeviceId');
        print('Retrieved stored Device ID: $storedDeviceId');
        return storedDeviceId;
      } else {
        // إنشاء DeviceId جديد وتخزينه
        final newDeviceId = _generateFallbackDeviceId();
        await prefs.setString('device_id', newDeviceId);
        log('Created and stored new Device ID: $newDeviceId');
        print('Created and stored new Device ID: $newDeviceId');
        return newDeviceId;
      }
    } catch (e) {
      log('Error with SharedPreferences: $e');
      print('Error with SharedPreferences: $e');
      log('Falling back to generated Device ID');
      print('Falling back to generated Device ID');
      return _generateFallbackDeviceId();
    }
  }


  LoginFunc loginFunc = LoginFunc();
  Future<void> fetchData() async {
    setState(() {
      userLoadingState = true;
    });
    final deviceId = await getDeviceId();
    try {
  final response = loginFunc.login(
    context,
    Host.teacherCode,
    codeController.text,
    deviceId,
  );
} on DioException catch (e) {
  
}
    setState(() {
      userLoadingState = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          const PageHeader(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const PageHeading(title: 'تسجيل الدخول'),
                      const Text(
                        "قم بإنشاء حساب لمتابعة كافة الدورات الخاصة بك",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      //passcode!
                      CustomInputField(
                        labelText: 'رمز الدخول',
                        hintText: 'أدخل رمز الدخول',
                        controller: codeController,
                      ),

                      const SizedBox(height: 20),
                      userLoadingState
                          ? const CircularProgressIndicator()
                          : CustomFormButton(
                            innerText: 'تسجيل الدخول',
                            onPressed: () {
                              fetchData();
                            },
                          ),
                      const SizedBox(height: 18),
                      //! Dont Have An Account ?
                      DontHaveAnAccountWidget(size: size),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.2),
                        child: Social(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
