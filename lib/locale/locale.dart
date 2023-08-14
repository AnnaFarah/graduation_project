import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          //student home page
          '1': 'الصفحة الرئيسية',
          '2': 'مهام',
          '3': 'أعمالي',
          '4': 'مرضاي',
          '5': 'ارسال طلب',
          '6': 'استشاراتي',
          '7': 'اظهار الحساب الشخصي',
          '8': 'الخروج',
          '9': 'تغيير اللغة',
          '10': 'عربي',
          '11': 'انكليزية',

          //student tasks
          '12': 'اضافة مهمة',
          '13': 'اظهار المهام',

          //student new task
          '14': 'اسم المهمة',
          '15': 'وصف',
          '16': 'تاريخ البدء',
          '17': 'تاريخ الانتهاء',
          '18': 'حالة المهمة',
          '19': 'موافق',
          '20': 'الرجوع',

          //student show tasks
          '21': 'اسم المهمة',
          '22': 'وصف',
          '23': 'تاريخ البدء',
          '24': 'تاريخ الانتهاء',

          //my patients
          '25': 'الاسم',
          '26': 'العمر',
          '27': 'الجنس',
          '28': 'اضافة وصفة',
          '29': 'اضافة سجل',

          //student show record
          '30': 'لا يوجد',
          '31': 'سجل المريض',
          '32': 'الوضع السابف',
          '33': 'الوضع الحالي',
          '34': 'الوضع العام',

          //student add prescription
          '35': 'وصفة',
          '36': 'اسم المرض',

          //student request
          '37': 'ارسال',

          //student consult
          '38': 'النوع',
          '39': 'رقم الهاتف',
          '40': 'تحويل',

          //student calendar
          '41': 'التقويم',
          '42': 'اختر اليوم',
          '43': 'اختر التوقيت',
          '44': 'الوقت',

          //patient home page
          '45': 'اليوم',
          '46': 'التاريخ',
          '47': 'ارسال طلب استشارة',
          '48': 'السجل الطبي',

          //patient profile
          '49': 'المنطقة',
          '50': 'تحديث رقم الهاتف او المنطقة',

          //student basket
          '51': 'سلتك',

          '52': 'مرحبا',
          '53': 'تبحث عن مريض؟',
          '54': '',

          //student add personal work
          '55': 'إضافة أعمال شخصية',
          '56': 'اسم المادة',
          '57': 'إضافة صورة',

          //student show personal work
          '58': 'أعمالك الشخصية',

          //student edit task
          '59': 'الملف الطبي',
          '60': 'عدد المرات',
          '61': 'مهمات',

          '62': 'نقل المريض',

          //chose login type
          '63': 'طالب',
          '64': 'مريض',
          '65': 'استمر ك',
        },
        'en': {
          //student home page
          '1': 'home page',
          '2': 'tasks',
          '3': 'My work',
          '4': 'My patients',
          '5': 'Send request',
          '6': 'Consults',
          '7': 'Show profile',
          '8': 'Logout',
          '9': "Change language",
          '10': 'Arabic',
          '11': 'English',

          //student tasks
          '12': 'Add task',
          '13': 'Show tasks',

          //student new task
          '14': 'Task name',
          '15': 'Description',
          '16': 'Start date',
          '17': 'End date',
          '18': 'Task status',
          '19': 'Confirm',
          '20': 'Cancel',

          //student show tasks
          '21': 'Task name',
          '22': 'Description',
          '23': 'Start date',
          '24': 'End date',

          //my patients
          '25': 'Name',
          '26': 'Age',
          '27': 'Gender',
          '28': 'Add prescription',
          '29': 'Add record',

          //student show record
          '30': 'Empty',
          '31': 'Patient record',
          '32': 'Last disease',
          '33': 'Current disease',
          '34': 'General disease',

          //student add prescription
          '35': 'Prescription',
          '36': 'Disease name',

          //student request
          '37': 'Send request',

          //student consult
          '38': 'type',
          '39': 'phone number',
          '40': 'transfer',

          //student calendar
          '41': 'Calendar',
          '42': 'Chose the day',
          '43': 'Chose the timing',
          '44': 'Time',

          //patient home page
          '45': 'Day',
          '46': 'Date',
          '47': 'Make an appointment',
          '48': 'Medical profile',

          //patient profile
          '49': 'Region',
          '50': 'Update phone number or region',

          //student basket
          '51': 'your cart',

          '52': 'Hi',
          '53': 'Searching for patient?',
          '54': 'Also check your',

          //student add personal work
          '55': 'Add personal work',
          '56': 'Subject name',
          '57': 'Add photo',

          //student show personal work
          '58': 'Your personal work',

          //student edit task
          '59': 'Medical profile',
          '60': 'Number of times',

          //student my task
          '61': 'Tasks',

          //student transfer patient
          '62': 'Transfer patient',

          //chose login type
          '63': 'Student',
          '64': 'Patient',
          '65': 'Continue as',
        }
      };
}
