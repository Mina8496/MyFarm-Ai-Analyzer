import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      // Onboarding Titles
      'onboard_title1': 'Welcome to MyFarm',
      'onboard_title2': 'In the My Farm app',
      'onboard_title3': 'Grow Smart',

      // Onboarding Descriptions
      'onboard_desc1': 'Analyze plant diseases with AI.',
      'onboard_desc2': 'Discover the best way to manage your farm efficiently.',
      'onboard_desc3': 'Get insights and tips to maximize your yield.',

      // Buttons
      'Back': 'Back',
      'Next': 'Next',
      'Start': 'Start',
      'continue': 'continue',
      // Plant analysis page
      'plant_analysis': 'Plant Analysis',
      'pick_image': 'Pick Image',
      'analyzing': 'Analyzing plant...',
      'confidence': 'Confidence',
      'upload_image': 'Upload a plant image to analyze',

      // user teyer
      'Discover': 'Discover the best way to manage your farm efficiently.',
      'Please_select_user_type': 'Please select a user type first.',
      'Farmer': 'Farmer',
      'Supervisor': 'Supervisor',
      'Farm Owner': 'Farm Owner',
      'Doctor': 'Doctor',
      'Engineer': 'Engineer',

      // Login And Sign up
      'Create_Account': 'Create Account',
      'Let’s_Create_Account_Together': 'Let’s Create Account Together',
      'Your_Name': 'Your Name',
      'Full_Name': 'Full Name',
      'Email_Address': 'Email Address',
      'Phone_required': 'Phone Required',
      'Email required': 'Email Required',
      'Enter_valid_email': 'Enter valid email',
      'Password_must': 'Password must be 6+ chars',
      'Phone_Number': 'Phone Number',
      'Password': 'Password',
      'Location': 'Location',
      'Location_being_determined': 'Location is being determined...',
      'Location_service_not_enabled': 'Location service is not enabled',
      'permission_denied': 'Permission denied',
      'error_occurred_while_determining_location':
          'An error occurred while determining location',

      // Plant analysis page
      'Capture': 'Capture with Camera',
      'Pick': 'Pick from Gallery',
      'Plant_Name': 'Plant Name',
      'The_leaf_appears_healthy':
          'The leaf appears healthy with no visible signs of disease.',
      'Signs_of_disease':
          'Signs of disease or stress were detected on the leaf.',
      'Detected_Diseases': 'Detected Diseases',
      'Injured': 'Injured',
      'Healthy': 'Healthy',
      'Confidence': 'Confidence',
      'This_disease_is_severe':
          '⚠ This disease is severe. Immediate action is recommended.',
      'Chemical_Treatment': 'Chemical Treatment',
      'Biological_Treatment': 'Biological Treatment',
      'Prevention_Tips': 'Prevention Tips',
      'causes:': 'causes:',
      'symptoms:': 'symptoms:',
      'Diagnosis_detected_with_high_confidence':
          'Diagnosis detected with high confidence. Detailed treatment information may require expert review.',
      'Yes': 'Yes',
      'No': 'No',
      'The image is not of a plant': 'The image is not of a plant',
      'Unable to load disease details': 'Unable to load disease details',
      'Loading...': 'Loading...',
      'Recognizing leaf disease...': 'Recognizing leaf disease...',
      'Change': 'Change',
      'Classification Result': 'Classification Result',
    },
    'ar': {
      // Onboarding Titles
      'onboard_title1': 'مرحباً بك فى مزرعتى',
      'onboard_title2': 'فى تطبيق مزرعتى',
      'onboard_title3': 'ازرع بذكاء',

      // Onboarding Descriptions
      'onboard_desc1': 'حلل أمراض النباتات باستخدام الذكاء الاصطناعى.',
      'onboard_desc2': 'اكتشف أفضل طريقة لإدارة مزرعتك بكفاءة.',
      'onboard_desc3': 'احصل على رؤى ونصائح لزيادة محصولك.',

      // Buttons
      'Back': 'رجوع',
      'Next': 'التالى',
      'Start': 'ابدأ',
      'Continue': 'متابعة',

      'plant_analysis': 'تحليل النبات',
      'pick_image': 'اختار صورة',
      'analyzing': 'جاري تحليل النبات...',
      'confidence': 'نسبة الثقة',
      'upload_image': 'ارفع صورة النبات للتحليل',

      // user teyer
      'Discover': 'اكتشف أفضل طريقة لإدارة مزرعتك بكفاءة.',
      'Please_select_user_type': 'يرجى اختيار نوع المستخدم اولاً.',
      'Farmer': 'فلاح',
      'Supervisor': 'مشرف',
      'Farm Owner': 'مالك مزرعة',
      'Doctor': 'دكتور',
      'Engineer': 'مهندس',

      // Login And Sign up
      'Create_Account': 'انشاء حساب',
      'Let’s_Create_Account_Together': 'هيا ننشئ حساب معاً',
      'Your_Name': 'أسم المستخدم',
      'Full_Name': 'الأسم بالكامل',
      'Email_Address': 'البريد الإلكترونى',
      'Phone_required': 'يجب إدخال رقم الهاتف',
      'Email_required': 'يجب إدخال بريد الإلكترونى',
      'Enter_valid_email': 'إدخال بريد الإلكترونى',
      'Password_must': 'كلمة المرور يجب أن تكون 6 أحرف أو أكثر',
      'Phone_Number': 'رقم الهاتف',
      'Password': 'كلمة المرور',
      'Location': 'الموقع',
      'Location_being_determined': 'جارى تحديد الموقع...',
      'Location_service_not_enabled': 'خدمة الموقع غير مفعلة',
      'permission_denied': 'تم رفض الإذن',
      'error_occurred_while_determining_location': 'حدث خطأ أثناء تحديد الموقع',

      // Plant analysis page
      'Capture': 'التقاط بالكاميرا',
      'Pick': 'اختيار من المعرض',
      'Plant_Name': 'النبات',
      'The_leaf_appears_healthy':
          'تبدو الورقة سليمة ولا تظهر عليها أي علامات مرضية.',
      'Signs_of_disease': 'تم رصد علامات مرض أو إجهاد على الورقة.',
      'Detected_Diseases': 'الأمراض المكتشفة',
      'Injured': 'ضار',
      'Healthy': 'صحى',
      'Confidence': 'الثقة',
      'This_disease_is_severe': '⚠ هذا المرض خطير. يُنصح باتخاذ إجراء فوري.',
      'Chemical_Treatment': 'المعالجة الكيميائية',
      'Biological_Treatment': 'المعالجة البيولوجية',
      'Prevention_Tips': 'نصائح_الوقاية',
      'causes:': 'الأسباب:',
      'symptoms:': 'أعراض:',
      'Diagnosis_detected_with_high_confidence':
          'تم الكشف عن التشخيص بثقة عالية. قد تتطلب معلومات العلاج التفصيلية مراجعة من خبير.',
      'Yes': 'نعم',
      'No': 'لا',
      'The image is not of a plant': 'الصورة ليست نبات',
      'Unable to load disease details': 'تعذر تحميل تفاصيل المرض',
      'Loading...': 'جارٍ التحميل...',
      'Recognizing leaf disease...': 'جارٍ التعرف على مرض الأوراق...',
      'Change': 'تغيير',
      'Classification Result': 'نتيجة التصنيف',
    },
  };
}
