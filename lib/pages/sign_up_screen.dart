// ignore_for_file: must_be_immutable, unused_local_variable, unnecessary_import, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profacademy/models/api_request.dart';
import 'package:profacademy/models/login_func.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:profacademy/shared/shared_colors.dart';
import 'package:profacademy/widgets/already_have_an_account_widget.dart';
import 'package:profacademy/widgets/custom_form_button.dart';
import 'package:profacademy/widgets/custom_input_field.dart';
import 'package:profacademy/widgets/page_header.dart';
import 'package:profacademy/widgets/page_heading.dart';

class SignUpScreen extends StatefulWidget {
  String code = "";

  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

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
          final deviceName =
              (iosInfo.name.isNotEmpty == true) ? iosInfo.name : 'Unknown';
          final model =
              (iosInfo.model.isNotEmpty == true) ? iosInfo.model : 'Unknown';
          final systemVersion =
              (iosInfo.systemVersion.isNotEmpty == true)
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
              (windowsInfo.computerName.isNotEmpty == true)
                  ? windowsInfo.computerName
                  : 'Unknown';
          final productName =
              (windowsInfo.productName.isNotEmpty == true)
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
              (macOsInfo.computerName.isNotEmpty == true)
                  ? macOsInfo.computerName
                  : 'Unknown';
          final hostName =
              (macOsInfo.hostName.isNotEmpty == true)
                  ? macOsInfo.hostName
                  : 'Unknown';
          final osRelease =
              (macOsInfo.osRelease.isNotEmpty == true)
                  ? macOsInfo.osRelease
                  : 'Unknown';
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

  Future<void> _testDeviceId() async {
    log('=== Testing Device ID (Sign Up) ===');
    print('=== Testing Device ID (Sign Up) ===');

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

    log('=== End Device ID Test (Sign Up) ===');
    print('=== End Device ID Test (Sign Up) ===');
  }

  final Dio dio = Dio();
  final nameController = TextEditingController();
  final studentPhoneController = TextEditingController();
  final guardianPhoneController = TextEditingController();

  bool userLoadingState = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _testDeviceId();
    createData();
  }

  final ApiRequest getData = ApiRequest();
  Map<String, dynamic> allData = {};
  createData() async {
    try {
      final data = await getData.fecthData();
      setState(() {
        allData = data;
      });
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  LoginFunc registerFunc = LoginFunc();
  Future<void> fetchData() async {
    setState(() {
      userLoadingState = true;
    });
    final deviceId = await getDeviceId();
    try {
      final response = registerFunc.registration(
        context,
        nameController.text,
        studentPhoneController.text,
        guardianPhoneController.text,
        selectedGrade.toString(),
        deviceId,
      );
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
    setState(() {
      userLoadingState = false;
    });
  }
  String? selectedGrade;
  /// بناء DropdownButton للصف الدراسي
Widget _buildGradeDropdown() {
  final gradeList = allData['gradeList'] as List<dynamic>? ?? [];
   selectedGrade = gradeList.contains(allData['grade'].toString()) ? allData['grade'].toString() : null;

  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الصف الدراسي',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedGrade, // ✅ التحقق من وجود القيمة في القائمة
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: InputBorder.none,
              hintText: 'اختر الصف الدراسي',
            ),
            items: gradeList.map<DropdownMenuItem<String>>((item) {
              return DropdownMenuItem<String>(
                value: item.toString(),
                child: Text(
                  item.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                allData['grade'] = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يرجى اختيار الصف الدراسي';
              }
              return null;
            },
          ),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const PageHeader(),
                const PageHeading(title: 'انشاء حساب جديد'),
                const SizedBox(height: 16),

                //! Name
                CustomInputField(
                  labelText: 'الاسم',
                  hintText: 'اسمك الكامل',
                  isDense: true,
                  controller: nameController,
                ),
                const SizedBox(height: 16),

                //phone number!
                CustomInputField(
                  labelText: 'رقم الجوال',
                  hintText: 'رقم الجوال الخاص بك ex:01234567890',
                  isDense: true,
                  controller: studentPhoneController,
                ),
                const SizedBox(height: 16),

                //parent's Phone Number!
                CustomInputField(
                  labelText: 'رقم جوال ولي الأمر',
                  hintText: 'رقم جوال ولي الأمر ex:01234567890',
                  isDense: true,
                  controller: guardianPhoneController,
                ),
                const SizedBox(height: 16),

                //grade dropdown!
                _buildGradeDropdown(),
                const SizedBox(height: 16),

                //! Confirm Password
                const SizedBox(height: 22),
                userLoadingState
                    ? const CircularProgressIndicator()
                    : CustomFormButton(
                      innerText: 'انشاء حساب',
                      onPressed: fetchData,
                    ),
                const SizedBox(height: 18),

                //! Already have an account widget
                const AlreadyHaveAnAccountWidget(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
