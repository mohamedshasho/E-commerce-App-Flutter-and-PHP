import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  bool isEn = true;
  SharedPreferences _sp;
  Map<String, Object> textEn = {
    'Check': 'Check',
    'username': 'username',
    'contact': 'Are you any question and details,\nContact us.',
    'Message': 'Message',
    'Send': 'Send',
    'items': 'items ',
    'Please Login Or SinUp First!': 'Please Login Or SinUp First!',
    'Please Enter your message!.': 'Please Enter your message!.',
    'Add to cart': 'Add to cart',
    'Home': 'Home',
    'search': 'search...',
    'Favorite': 'Favorite',
    'Products': 'Products',
    'Setting': 'Setting',
    'Mode Night': 'Mode Night',
    'English': 'English',
    'Arabic': 'Arabic',
    'No Added favorite yet!.': 'No Added favorite yet!.',
    'MegaStore': 'MegaStore',
    'Enter Email': 'Enter Email',
    'Please enter password': 'Please enter password',
    'password': 'password',
    'Your password is required': 'Your password is required',
    'Skip': 'Skip',
    'Sign up': 'Sign up',
    'Failed Login': 'Failed Login',
    'Login': 'Login',
    'Notification': 'Notification',
    'Email': 'Email',
    'Confirm password': 'Confirm password',
    'Sign in': 'Sign in',
    'Password are not same!.': 'Password are not same!.',
    'Registration Failed': 'Registration Failed',
    'Register': 'Register',
    'no Items Found': 'no Items Found',
    'recent:': 'recent:',
    'My Profile': 'My Profile',
    'Log in': 'Log in',
    'Contact': 'Contact us',
    'Please Complete the form properly': 'Please Complete the form properly',
    'Invalid form': 'Invalid form',
    'Share App': 'Share App',
    'About app': 'About app',
    'Logout': 'Logout',
    'Modern': 'Modern',
    'Show more': 'Show more',
    'Price': 'Price',
    'Description': 'Description',
    'Specification': 'Specification',
    'Product type:': 'Product type:',
    'Main Material:': 'Main Material:',
    'Man': 'Man',
    'Password': 'Password',
    'Confirm Password': 'Confirm Password',
    'Capacity:': 'Capacity:',
    'Is Already added': 'Is Already added',
    'Categories': 'Categories',
    'ALL': ' ALL ',
    'Price:': 'Price:',
    'Apply': 'Apply',
    'Please enter username': 'Please enter username',
    'Username': 'Username',
    'Search for items': 'Search for items',
    'Your username is required': 'Your username is required',
  };
  Map<String, Object> textAr = {
    'Check': 'الحساب',
    'username': 'اسم المستخدم',
    'contact': 'هل لديك اي اسئلة او مقترحات\nتواصل معنا. ',
    'Message': 'الرسالة',
    'Send': 'ارسال',
    'items': 'عناصر ',
    'Password': 'باسورد ',
    'Please Login Or SinUp First!': 'الرجاء تسجيل الدخول اولاً!',
    'Please Enter your message!.': 'الرجاء ادخل الرسالة اولاً!',
    'Add to cart': 'إضافة الى العربة',
    'Home': 'الرئيسية',
    'Confirm Password': 'تأكيد الباسورد',
    'Favorite': 'المفضلة',
    'Products': 'المنتجات',
    'search': 'بحث...',
    'Setting': 'الاعدادات',
    'Mode Night': 'الوضع الليلي',
    'English': 'الانكليزي',
    'Arabic': 'العربية',
    'No Added favorite yet!.': 'ليس هناك عناصر حتى الان',
    'MegaStore': 'ميغا ستور',
    'Enter Email': 'ادخل الايميل',
    'Please enter password': 'ادخل الباسورد',
    'password': 'الباسورد',
    'Your password is required': 'الباسورد مطلوب',
    'Skip': 'تخطي',
    'Sign up': 'انشاء حساب',
    'Failed Login': ' فشل تسجيل الدخول',
    'Login': ' تسجيل الدخول',
    'Notification': 'التنبيهات',
    'Email': 'الايميل',
    'Confirm password': 'تأكيد الباسورد',
    'Sign in': 'تسجيل الدخول',
    'Password are not same!.': 'الباسورد غير مطابق!',
    'Registration Failed': 'فشل انشاء حساب',
    'Register': 'انشاء',
    'Please Complete the form properly': 'اكمل البيانات من فضلك',
    'Invalid form': 'خطأ',
    'no Items Found': 'لا يوجد عناصر',
    'recent:': 'الأحدث:',
    'My Profile': 'البروفايل',
    'Log in': 'تسجيل الدخول',
    'Contact': 'تواصل معنا',
    'Share App': ' مشاركة التطبيق',
    'About app': 'عن التطبيق',
    'Logout': 'تسجيل الخروج',
    'Modern': 'الاحدث',
    'Show more': 'عرض المزيد',
    'Price': 'السعر',
    'Description': 'الوصف',
    'Specification': 'مخصص',
    'Please enter username': 'ادخل اسم المستخدم',
    'Product type:': 'نوع المنتج:',
    'Main Material:': 'المادة الرئيسية:',
    'Man': 'رجل',
    'Capacity:': 'قياس:',
    'Is Already added': 'مضاف بالفعل',
    'Categories': 'الفئات',
    'ALL': ' الكل ',
    'Price:': 'السعر:',
    'Apply': 'تطبيق',
    'Username': 'اسم المستخدم',
    'Your username is required': 'اسم المستخدم مطلوب',
    'Search for items': 'ابحث عن عناصر',
  };
  changeLan(bool lan) async {
    isEn = lan;
    _sp = await SharedPreferences.getInstance();
    _sp.setBool('isEn', lan);
    notifyListeners();
  }

  getLan() async {
    _sp = await SharedPreferences.getInstance();
    isEn = _sp.getBool('isEn') ?? true;
    notifyListeners();
  }

  Object getText(String txt) {
    if (isEn == true)
      return textEn[txt];
    else
      return textAr[txt];
  }
}
