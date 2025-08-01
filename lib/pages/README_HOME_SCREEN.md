# نظام حفظ واسترجاع البيانات في الصفحة الرئيسية

## نظرة عامة

تم تحديث النظام لاستخدام SharedPreferences لحفظ واسترجاع بيانات المستخدم بين جلسات التطبيق.

## كيفية العمل

### 1. في شاشة تسجيل الدخول (`sign_in_screen.dart`)

#### حفظ البيانات:
```dart
// عند تسجيل الدخول بنجاح
await saveData(data);

// دالة حفظ البيانات
Future<void> saveData(Map<String, dynamic> data) async {
  prefs = await SharedPreferences.getInstance();
  
  if (data["token"] != null) {
    await prefs.setString('token', data["token"]);
  }
  
  if (data["studentCode"] != null) {
    await prefs.setInt('studentCode', data["studentCode"]);
  }
}
```

#### البيانات المحفوظة:
- `token`: رمز المصادقة من الخادم
- `studentCode`: رمز الطالب

### 2. في الصفحة الرئيسية (`home_screen.dart`)

#### تحميل البيانات:
```dart
// عند بدء التطبيق
void loadData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  String? token = prefs.getString('token');
  int? studentCode = prefs.getInt('studentCode');
  
  if (token != null && studentCode != null) {
    homeRequest = HomeRequest(
      token: token,
      teacherCode: Host.teacherCode,
      studentCode: studentCode.toString(),
    );
    await HomeData();
  } else {
    // الانتقال لتسجيل الدخول
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }
}
```

#### معالجة الأخطاء:
- إذا لم تكن البيانات موجودة → الانتقال لتسجيل الدخول
- إذا كان هناك خطأ 401 (غير مصرح) → مسح البيانات والانتقال لتسجيل الدخول
- إذا كان هناك خطأ آخر → عرض رسالة خطأ مع خيارات

#### تسجيل الخروج:
```dart
Future<void> _logout() async {
  await _clearStoredData(); // مسح جميع البيانات
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
}
```

## الميزات المضافة

### 1. شريط التطبيق المحدث
- إضافة زر تسجيل الخروج
- عرض رسائل خطأ مناسبة

### 2. معالجة الأخطاء المحسنة
- التحقق من صحة البيانات المحفوظة
- إعادة المحاولة التلقائية
- رسائل خطأ واضحة للمستخدم

### 3. عرض البيانات للاختبار
- عرض Token و Student Code و Teacher Code
- مساعدة في تتبع البيانات المحفوظة

## تدفق العمل

1. **بدء التطبيق** → `home_screen.dart`
2. **تحميل البيانات المحفوظة** → `loadData()`
3. **التحقق من وجود البيانات**:
   - ✅ موجودة → تحميل بيانات الصفحة الرئيسية
   - ❌ غير موجودة → الانتقال لتسجيل الدخول
4. **تسجيل الدخول** → `sign_in_screen.dart`
5. **حفظ البيانات** → `saveData()`
6. **العودة للصفحة الرئيسية** → `home_screen.dart`

## الأمان

- البيانات محفوظة محلياً في SharedPreferences
- مسح البيانات عند تسجيل الخروج
- مسح البيانات عند حدوث خطأ في المصادقة
- التحقق من صحة البيانات قبل الاستخدام

## الاستخدام في ملفات أخرى

للاستخدام في ملفات أخرى، يمكن استخدام نفس النمط:

```dart
import 'package:shared_preferences/shared_preferences.dart';

// الحصول على البيانات
SharedPreferences prefs = await SharedPreferences.getInstance();
String? token = prefs.getString('token');
int? studentCode = prefs.getInt('studentCode');

// حفظ بيانات جديدة
await prefs.setString('newKey', 'newValue');

// مسح بيانات محددة
await prefs.remove('key');

// مسح جميع البيانات
await prefs.clear();
```

## ملاحظات مهمة

1. **تهيئة SharedPreferences**: يتم تهيئتها تلقائياً عند الحاجة
2. **معالجة الأخطاء**: جميع العمليات محمية بـ try-catch
3. **التنقل**: استخدام `pushReplacement` لتجنب تراكم الشاشات
4. **التحديث**: البيانات تُحدث في الواجهة باستخدام `setState()` 