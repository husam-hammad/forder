import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar_AR': {
          'acceptterms': 'أوافق على الأحكام والشروط',
          'onbording1':
              'المطاعم صارت أقرب ألك', //Restaurants are getting closer to you
          'onbording1desc':
              'يمكنك الدخول لأي مطعم واستكشاف قائمة الطعام الخاصة به', //You can enter any restaurant and explore its menu
          'onbording2': 'بسرعة البرق', //lightning fast
          'onbording2desc':
              'سيصل إليك طلبك بأقصى سرعة ممكنة عبر شبكة التوصيل الخاصة بنا , ويمكنك تتبع طلبك مباشرة عبر الخارطة', //Your order will reach you as quickly as possible through our delivery network, and you can track your order directly on the map
          'onbording3': 'تتبع الطلب', //Order Tracking
          'onbording3desc':
              'يمكنك تتبع حالة الطلب بعد إرساله والإطلاع على موقع الكابتن بشكل مستمر', //You can track the status of your order after sending it and view the captain's Location continuously
          'onbording4': 'في خدمتكم', //at your service
          'onbording4desc':
              'على مدار الساعة , نقدم لكم خدمتنا الإحترافية التي ستنال إعجابكم', //All the Time, we offer you our professional service that you will like
          'ok': 'تم', //at your service
          'addyourphonenumber': 'قم بإدخال رقم هاتفك',
          'sendcode': 'إرسال الرمز',
          'sending': ' جار الارسال ...',
          'send': "إرسال",
          "sendcomp": "إرسال",
          "sendingcomp": "جار الارسال ...",
          'skip': 'تخطي',
          'enter5code':
              'قم بإدخال الرمز المكون من 5  أرقام', //قم بإدخال الرمز المكون من 5  أرقام

          'wehavesend':
              'قمنا بإرسال رمز إلى هاتفك لنتمكن من تأكيد حسابك ,قم بإدخاله في الخانات في الأسفل حال وصوله', //We have sent a code to your phone so that we can verify your account, enter it in the boxes below when it arrives
          'resendcode': 'إعادة إرسال الرمز',
          'resendcodeafter': 'إعادة إرسال الرمز بعد',
          'loginprogress': 'جاري تسجيل الدخول ....',
          'verifycode': 'تأكيد الرمز',
          'lateststories': 'آخر القصص',
          'morestories': 'المزيد من القصص',
          'showall': 'عرض الكل',
          'delete': 'حذف ',
          'deleteall': 'حذف الكل',
          'restaurentsnearby': 'مطاعم بالقرب مني',
          'restaurents': ' المطاعم',
          'featuredmeals': 'أبرز الوجبات',
          'offersmeals': 'عروض فلاش أوردر',

          'meals': 'الوجبات',
          'home': 'الرئيسية',
          'notifications': 'الإشعارات',
          'nonotifications': 'لا توجد إشعارات',
          'mycart': 'سلة الشراء',
          'orders': 'الطلبات',
          'ordersednt': 'تم إرسال الطلب بنجاح', // 'Order Send Successful ',//,
          'complementsent': 'تم إرسال الشكوى بنجاح',
          'editorder': 'تعديل الطلب',
          'editordernot': 'غير مسموح بتعديل  الطلب',
          'noorders': 'لا توجد طلبات',
          'captin': 'الكابتن',
          'orderid': 'الطلب رقم : ',
          'orderstate': 'الحالة : ',
          'orderdetails': 'تفاصيل الطلب',
          'ordercost': 'تكلفةالطلب : ',
          'createdat': 'تاريخ الإنشاء : ',
          'favorites': 'المفضلة',
          'profile': 'الملف الشخصي',
          'pinnedplaces': 'الاماكن المثبتة',
          'sendtocurrentplace': 'إرسال للموقع الحالي', //ارسال للموقع الحالي
          'restaurentslist': 'قائمة المطاعم',
          'mealslist': 'قائمة الوجبات',
          'favoriteslist': 'قائمة المفضلة',
          'privacypolicy': 'سياسة الاستخدام',
          'complaintsandsuggestions': 'الشكاوى والمقترحات',
          //'Complaints and suggestions'
          'complaintid': 'شكوى رقم : ',
          'nocomplaint': 'لا توجد شكاوى',

          'contactus': 'اتصل بنا',
          'contactusdesc': 'لأي استفسار أو شكوى مباشرة يمكنك الإتصال  على :',
          'quadnumber': 'رقم رباعي', //Quad number
          'logout': 'تسجيل الخروج',
          'login': 'تسجيل الدخول',
          'pleaselogin': 'يرجى تسجيل الدخول',
          'logintitle':
              'سجل دخولك لتستفيد من خدمات التطبيق بشكل كامل , لتصلك آخر العروض و تحصل على رصيد للنقاط',
          'name': 'الإسم الكامل',
          'phone': 'رقم الموبايل',
          'mobile': 'الموبايل',
          'adress': 'العنوان',
          'adressforcaptin': 'لمساعدة الكابتن في الوصول إليك بدقة',
          'birthday': 'تاريخ الميلاد',
          'numberofpoints': 'عدد النقاط لديك : ',
          'save': 'حفظ',
          'saveing': 'جاري الحفظ ..',
          'addcurrentlocation': 'إضافة الموقع الحالي للأماكن المثبتة',
          'palcename': 'اسم المكان',
          'add': 'إضافة',
          'opened': 'متاح الآن',
          'orderability': 'إمكانية الطلب',
          'loadmore': 'تحميل المزيد',

          'closed': 'مغلق',
          'deliverycost': 'أجرة التوصيل', //Delivery cost
          'finalvalue': 'القيمة الإجمالية',
          'categories': 'التصنيفات',
          'price': 'السعر',
          'compoments': 'المكونات',
          'sp': 'ل.س',
          'number': 'العدد المطلوب',
          'specialorder': 'طلب مخصص',
          'specialorderdesc': 'اكتب أي مكونات اضافية أو طلب مخصص للشيف',
          'addtocart': 'إضافة للسلة',
          'addtocartsuccessful': 'تمت الإضافة للسلة',
          'restaurentisclosed': 'المطعم مغلق الآن',
          'cannotbezeor': 'الكمية لا يجب أن تكون صفر',
          'earnedpoints': 'النقاط المكتسبة',

          'editqty': 'أدخل الكمية الجديدة',
          'edit': 'تعديل',
          'sendorder': 'إرسال الطلب',
          'sendordersuccessful': 'تم الإرسال بنجاح',
          'sendorderprogress': 'جاري الإرسال',

          'searchtitle': 'البحث في الوجبات والمطاعم',
          'noresults': 'لا توجد نتائج',
          'support': 'الدعم الفني',
          'noreply': 'الحالة : لم يتم الرد',
          'companyname': 'مؤسسة فلاش أوردر : ',
          'companyadress': 'شارع بغداد - قبل مشفى الهلال ',
          'appuser': 'مستخدم التطبيق',
          'noconnection': 'لا يوجد اتصال بالإنترنت',
          'pleaseadd10digitNumber': 'يرجى إدخال رقم من 10 مراتب',
          'wecouldntsend':
              'لم نتمكن من ارسال الرسالة', //لم نتمكن من ارسال الرسالة
          'pleasecheckcode':
              'يرجى التأكد من وصول الرمز', //Please make sure you have received the code
          'errorinsend': 'خطأ أثناء الإرسال',
          'helpusservice': 'ساعدنا على مراقبة جودة الخدمة',
          'captinrating': 'تقييمك للكابتن',
          'restaurentrating': 'تقييمك للمطعم',
          'amountpaid': 'المبلغ المدفوع للطلب',
          "youcanreplace": "يمكنك استعمال نقاطك في دفع الفاتورة أو جزء منها",
          "replaceamount": " استبدال مبلغ ",
          "with": " بـ ",
          'point': ' نقطة ',
          'replace': 'استبدال بالنقاط',
          'notnow': 'ليس الآن',
          'total': 'القيمة الكاملة',
          'appversion': 'الإصدار  الحالي التطبيق',
          'newwappversion': 'الإصدار  المتوفر',
          'updateto': 'تحديث التطبيق :  ',
          'pleaseupdate': 'يرجى تحديث التطبيق لآخر نسخة',
          'updatelink': 'رابط التحميل',
          'YouAreBanded': 'أنت محظور من استخدام التطبيق',
          'contactsupport': 'تواصل مع الدعم الفني',
          "applybox": "شراء البوكس",
          "boxcontent": "محتوى البوكس",
          "qty": "الكمية",
          "bprice": "السعر",
          "allprice": "الاجمالي",
          "discount": "الخصم",
          "net": "الصافي",
          "preferedmode": "الوضع المفضل",
          "lightmode": "الوضع العادي",
          "darkmode": "الوضع الليلي",
          "showrestaurents": "عرض كل المطاعم",
          "showoppenedrestaurents": "المطاعم المتاحة الآن",
        },
        'en_US': {
          'acceptterms': 'I Agree',
          'onbording1':
              'Restaurants Are Getting Closer To You', //Restaurants are getting closer to you
          'onbording1desc':
              'You Can Enter Any Restaurant & Explore Its Menu', //You can enter any restaurant and explore its menu
          'onbording2': 'Lightning Fast', //lightning fast
          'onbording2desc':
              'Your Order Will Reach You As Quickly As Possible Through Our Delivery Network, And You Can Track Your Order Directly On The Map', //Your order will reach you as quickly as possible through our delivery network, and you can track your order directly on the map
          'onbording3': 'Order Tracking', //Order Tracking
          'onbording3desc':
              'You Can Track The Status Of Your Order After Sending It And View The Captain\'s Location Continuously', //
          'onbording4': 'At Your Service', //at your service
          'onbording4desc':
              'All The Time, We Offer You Our Professional Service That You Will Like', //All the Time, we offer you our professional service that you will like
          'ok': 'Ok', //at your service
          'addyourphonenumber': 'Write Your Phone Number',
          'sendcode': 'Send Code',
          'sending': 'Sending ....',
          'send': "Send",
          "sendcomp": "Send",
          "sendingcomp": "Sending ...",
          'loginprogress': 'Signing in ...',
          'skip': 'skip',
          'wehavesend':
              'We have sent a code to your phone so that we can verify your account, enter it in the boxes below when it arrives', //We have sent a code to your phone so that we can verify your account, enter it in the boxes below when it arrives
          'resendcode': 'Resend Code',
          'enter5code':
              'Enter the 5-digit code', //قم بإدخال الرمز المكون من 5  أرقام
          'resendcodeafter': 'Resend Code After',
          'verifycode': 'Verify Code',
          'lateststories': 'Latest Stories',
          'morestories': 'More Stories',
          'showall': 'Show All',
          'deleteall': 'Delete All',
          'delete': 'Delete',
          'restaurentsnearby': 'Restaurents Nearby',
          'restaurents': 'Restaurents',
          'featuredmeals': 'Featured Meals',
          'offersmeals': 'Best Offers',
          'meals': 'Meals',
          'home': 'Home',
          'notifications': 'Notifications',
          'nonotifications': 'No Notifications',
          'mycart': 'My Cart',
          'orders': 'Orders',
          'ordersednt':
              'Order Send Successful  ', // 'Order Send Successful ',//,
          'complementsent': 'Complaint Send Successful ',
          'noorders': 'No Orders',
          'orderid': 'Order Id : ',
          'orderstate': 'Order State : ',
          'captin': 'Captin',
          'orderdetails': 'Order Details',
          'ordercost': 'Order Cost : ',
          'favorites': 'Favorites',
          'profile': 'Profile',
          'pinnedplaces': 'Pinned Places',
          'sendtocurrentplace':
              'Send To Current Location', //ارسال للموقع الحالي
          'restaurentslist': 'Restaurents List',
          'mealslist': 'Meals List',
          'favoriteslist': 'Favorites List',
          'privacypolicy': 'Privacy Policy',
          'complaintsandsuggestions': 'Complaints And Suggestions',
          'complaintid': 'Complaints Id : ',
          'nocomplaint': 'No Result',
          //'Complaints and suggestions'
          'contactus': 'Contact Us',
          'contactusdesc':
              'For any inquiries or complaints directly, you can contact:',
          'quadnumber': 'Quad Number', //
          'logout': 'Logout',
          'login': 'Login',
          'pleaselogin': 'Please Login To Show This Page',
          'logintitle':
              'Log In To Fully Benefit From The Application\'s Services, To Receive The Latest Offers And Get A Credit For Points',
          'name': 'name',
          'phone': 'phone',
          'mobile': 'Mobile Number',
          'adress': 'adress',
          'adressforcaptin': 'To help the captain reach you accurately',
          'birthday': 'birthday',
          'numberofpoints': 'My Points Count : ',
          'save': 'Save',
          'saveing': 'Saving ...',
          'addcurrentlocation': 'Add Current Location To Pinned Places',
          'palcename': 'Place Name',
          'add': 'Add',
          'opened': 'Opened',
          'orderability': 'Orderable',
          'loadmore': "Load More",
          'cloesd': 'Cloesd',
          'deliverycost': 'Delivery Cost', //Delivery cost
          'finalvalue': 'Total Value',
          'categories': 'Categories',
          'price': 'Price',
          'compoments': 'Compoments',
          'sp': 'S.P',
          'number': 'Count',
          'specialorder': 'Special Order',
          'editorder': 'Edit Order',
          'editordernot': 'Edit Order Not Allowd',
          'createdat': 'Created At : ',
          'specialorderdesc':
              'Write Down Any Additional Ingredients Or Custom Order For The Chef',
          'addtocart': 'Add To Cart',
          'addtocartsuccessful': 'Added To Cart',
          'restaurentisclosed': 'Sorry ...The Restaurent Is Closed Now!',
          'cannotbezeor': 'Quantity Cannot Be Zero',
          'earnedpoints': 'Earned Points : ',
          'editqty': 'Enter New Count',
          'edit': 'Edit',
          'sendorder': 'Send Order',
          'sendordersuccessful': 'Order Sent',
          'sendorderprogress': 'Sending',
          'searchtitle': 'Search By Meal Or Restaurent',
          'noresults': 'No Result',
          'support': 'Support Team',
          'noreply': 'No Reply',
          'companyname': 'The Flash Order ',
          'companyadress': 'Baghdad Street - before Al Hilal Hospital',
          'appuser': 'App User',
          'noconnection': 'No Internet Connection',
          'pleaseadd10digitNumber': 'Please Add 10 Digit Phone Number',
          'wecouldntsend':
              'We couldn\'t send the message', //لم نتمكن من ارسال الرسالة
          'pleasecheckcode':
              'Please make sure you have received the code', //Please make sure you have received the code
          'errorinsend': 'Error while sending',
          'helpusservice': 'Help us improve the quality of service',
          'captinrating': 'Captin Rating',
          'restaurentrating': 'Restaurent Rating',
          'amountpaid': 'Amount Paid',
          "youcanreplace": "You Can Replace Your Order Value With Your Points",
          "replaceamount": "Replace",
          "with": "With",
          'point': 'Point',
          'replace': 'Replace With Points',
          'notnow': 'Not Now',
          'total': 'Total Value',
          'appversion': 'Current App Version',
          'newwappversion': 'New Update Version',
          'updateto': 'Update Flash Order ',
          'pleaseupdate': 'Please Update Your App To a New Version',
          'updatelink': 'Update Link',
          'YouAreBanded': 'You Are Excluded From Using The App',
          'contactsupport': 'Contact Support',
          "applybox": "Buy Box",
          "boxcontent": "Box Content",
          "qty": "Qty",
          "bprice": "Price",
          "allprice": "Total",
          "discount": "Discount",
          "net": "Net Value",
          "preferedmode": "Prefered Mode",
          "lightmode": "Light Mode",
          "darkmode": "Dark Mode",
          "showrestaurents": "All Restaurents",
          "showoppenedrestaurents": "Opened Restaurents",
        },
      };
}
