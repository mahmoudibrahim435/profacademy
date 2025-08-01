# دليل استخدام المتغيرات العامة (Global Variables)

## نظرة عامة
تم إنشاء نظام متغيرات عامة لتخزين البيانات التي تأتي من API في ملف `global_data.dart`. هذا النظام يسمح بالوصول للبيانات من أي مكان في التطبيق.

## كيفية الاستخدام

### 1. استيراد الملف
```dart
import 'package:profacademy/shared/global_data.dart';
```

### 2. حفظ البيانات من API
```dart
// في PendingScreen1.dart أو أي مكان آخر
final data = await apiRequest.fecthData();
GlobalApiData.saveRegistrationData(data);
```

### 3. الوصول للبيانات من أي مكان
```dart
// بيانات الطالب
String studentName = GlobalApiData.studentName;
String studentCode = GlobalApiData.studentCode;
List<String> grades = GlobalApiData.grade;

// بيانات الاشتراك
int cash = GlobalApiData.cash;
String expireDate = GlobalApiData.expireDate;

// بيانات الجلسة
String token = GlobalApiData.accessToken;
bool isSuccess = GlobalApiData.isApiSuccess;
```

## المتغيرات المتاحة

### بيانات الطالب
- `studentCode`: كود الطالب
- `studentName`: اسم الطالب
- `studentPhone`: رقم هاتف الطالب
- `guardianPhone`: رقم هاتف ولي الأمر
- `grade`: قائمة الصفوف
- `deviceId`: معرف الجهاز
- `assignedTeacher`: المعلم المخصص

### بيانات الاشتراك
- `cash`: الرصيد المالي
- `activateDate`: تاريخ التفعيل
- `expireDate`: تاريخ انتهاء الصلاحية
- `countDown`: العد التنازلي

### بيانات الجلسة
- `accessToken`: رمز الوصول
- `apiMessage`: رسالة API
- `apiStatusCode`: رمز حالة API
- `isApiSuccess`: نجاح العملية

### البيانات الكاملة
- `fullResponse`: الاستجابة الكاملة من API
- `homeData`: بيانات الصفحة الرئيسية

## الدوال المساعدة

### `saveRegistrationData(Map<String, dynamic> data)`
حفظ البيانات من استجابة التسجيل

### `saveHomeData(Map<String, dynamic> data)`
حفظ بيانات الصفحة الرئيسية

### `clearAllData()`
مسح جميع البيانات

### `hasValidData()`
التحقق من وجود بيانات صالحة

### `getStudentInfo()`
الحصول على معلومات الطالب كـ Map

### `getSubscriptionInfo()`
الحصول على معلومات الاشتراك كـ Map

### `getHomeData()`
الحصول على بيانات الصفحة الرئيسية

### `hasHomeData()`
التحقق من وجود بيانات الصفحة الرئيسية

## مثال عملي

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    if (GlobalApiData.hasValidData()) {
      // استخدام البيانات المتاحة
      String name = GlobalApiData.studentName;
      int balance = GlobalApiData.cash;
      
      print('مرحباً $name، رصيدك: $balance');
    } else {
      // لا توجد بيانات صالحة
      print('يرجى تسجيل الدخول أولاً');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('مرحباً ${GlobalApiData.studentName}'),
    );
  }
}
```

## ملاحظات مهمة

1. **البيانات مؤقتة**: البيانات تُحفظ في الذاكرة فقط وتُمسح عند إغلاق التطبيق
2. **التحقق من الصحة**: استخدم `hasValidData()` قبل الوصول للبيانات
3. **مسح البيانات**: استخدم `clearAllData()` عند تسجيل الخروج
4. **التحديث**: استخدم `setState()` بعد تحديث البيانات لتحديث الواجهة

## الأمان

- البيانات تُحفظ في الذاكرة فقط
- لا تُحفظ البيانات الحساسة بشكل دائم
- استخدم `clearAllData()` عند تسجيل الخروج 