import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:profacademy/models/home_request.dart';

import 'package:profacademy/pages/account_sreen.dart';
import 'package:profacademy/pages/corses_screen.dart';
import 'package:profacademy/pages/notification_screen.dart';
import 'package:profacademy/shared/shared_colors.dart';
import 'package:profacademy/shared/text_style.dart';
import 'package:profacademy/widgets/carousel_view.dart';
import 'package:profacademy/widgets/courses_widget.dart';
import 'package:profacademy/widgets/home_appbar.dart';
import 'package:profacademy/widgets/navigation_bar.dart';
import 'package:profacademy/widgets/searchbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

CarouselController controller = CarouselController(initialItem: 4);

class _HomeScreenState extends State<HomeScreen> {
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

  List fullSections = [];
  dynamic price;
  String title = "";
  int sectionOrder = 0;
  int fullSectionsOrder = 0;
  final HomeRequest homeRequest = HomeRequest();
  Map<String, dynamic> allData = {};
  bool isLoading = true;
  putHomeData() async {
    try {
      
      final data = await homeRequest.getHomeData(context, );
      if (!mounted) return;
      setState(() {
        allData = data;
        isLoading = false;
        fullSections = allData['fullSections'] as List;
        title = allData['fullSections'][index]['title'];
        price = allData['fullSections'][index]['sectionPrice'];
        sectionOrder = allData['sections'][index]['sectionOrder'];
        fullSectionsOrder = allData['fullSections'][index]['sectionOrder'];
      });
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }


  @override
  void initState() {
    super.initState();
    putHomeData();
    print(allData);
  }

  int index = 0;
  void onTap(int index) {
    setState(() {
      switch (index) {
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CorsesScreen()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationsScreen()),
          );
          break;
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountScreen()),
          );
          break;
      }
    });
  }
bool isBought = false;
  @override
  Widget build(BuildContext context) {
    if (sectionOrder == fullSectionsOrder && fullSections.isNotEmpty) {
  isBought = true;
}

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: buildHomeAppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/bg.png", fit: BoxFit.cover),
          ),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    " ماذا تريد أن تتعلم اليوم؟ ابحث الان",
                    textDirection: TextDirection.rtl,
                    style: textStyle.copyWith(
                      color: const Color.fromARGB(255, 134, 130, 130),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 15),
                    child: buildSearchBar(),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: SizedBox(
                      height: size.height * 0.3,
                      width: size.width * 1,
                      child: customCarouselView(context),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "--> عرض الكل ",
                              textAlign: TextAlign.end,
                              style: textStyle.copyWith(
                                color: Colors.amber,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            "الشهور",
                            textAlign: TextAlign.end,
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.7,
                    child: ListView.builder(
                      itemCount: fullSections.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 25, right: 15),
                          child: GestureDetector(
                            onTap: () {
                              if(isBought){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CorsesScreen()));
                              }else{
                                showDialog(context: context, builder: (context) => AlertDialog(
                                  title: Text("تأكد من الشراء"),
                                  content: Text("هل أنت متأكد من شراء هذا الكورس؟"),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.pop(context);
                                    }, child: Text("اغلاق")),
                                    TextButton(onPressed: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CorsesScreen()));
                                    }, child: Text("شراء")),
                                  ],
                                ));
                              }
                            },
                            child: buildCoursesWidget(
                              context,
                              title,
                              "${price.toString()} EGP",
                              fullSections[index]['image'],
                              fullSections[index]['description'],
                              isBought ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 200, 93, 93),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: customNavigationBar(index: index, onTap: onTap),
    );
  }
}
