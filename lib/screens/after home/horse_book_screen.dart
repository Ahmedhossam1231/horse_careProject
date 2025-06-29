import 'package:flutter/material.dart';

class HorseBookScreen extends StatefulWidget {
  const HorseBookScreen({super.key});

  @override
  State<HorseBookScreen> createState() => _HorseBookScreenState();
}

class _HorseBookScreenState extends State<HorseBookScreen> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> bookPages = [
    {
      "title": "فهرس",
      "content": """
1. مقدمة عن الحصان
2. تاريخ الخيول
3. أنواع الخيول
4. تغذية الخيول
5. أمراض الخيول
6. العناية اليومية
7. التدريب والركوب
8. تربية الخيول
9. مسابقات الخيول
10. الخيول العربية
11. الخيول في الثقافات المختلفة
12. أدوات الفروسية
13. معلومات عامة
"""
    },
    {
      "title": "مقدمة عن الحصان",
      "content": "الخيول حيوانات نبيلة تم استخدامها منذ آلاف السنين، وتتميز بجمالها وقوتها..."
    },
    {
      "title": "تاريخ الخيول",
      "content":
          "بدأ تدجين الخيول منذ حوالي 4000 سنة قبل الميلاد في السهوب الأوراسية... تم استخدامها في النقل والحروب والزراعة..."
    },
    {
      "title": "أنواع الخيول",
      "content":
          "تشمل الخيول العربية، الإنجليزية الأصيلة، والخيول الأندلسية وغيرها... كل نوع يتميز بخصائص معينة من حيث البنية والسرعة والتحمل..."
    },
    {
      "title": "تغذية الخيول",
      "content":
          "يجب تقديم نظام غذائي متوازن يحتوي على العلف الجاف، التبن، والماء النظيف... ويُفضل إضافة الفيتامينات والمعادن حسب الحاجة..."
    },
    {
      "title": "أمراض الخيول",
      "content":
          "من الأمراض الشائعة: المغص، الحمى، التهاب الحوافر... الوقاية تشمل النظافة الجيدة، التغذية السليمة، والفحوصات الدورية..."
    },
    {
      "title": "العناية اليومية",
      "content":
          "تتضمن التنظيف اليومي للجسم والحوافر، تفقد العلامات الصحية العامة، ومراقبة السلوك اليومي..."
    },
    {
      "title": "التدريب والركوب",
      "content":
          "التدريب يجب أن يكون تدريجيًا مع استخدام أوامر واضحة وصبر... يتم تدريب الخيول على الجري، القفز، الطاعة، وغيرها حسب الاستخدام..."
    },
    {
      "title": "تربية الخيول",
      "content":
          "تشمل اختيار الأنساب الجيدة، الرعاية بالتغذية والرعاية الصحية، وتجهيز مكان آمن وصحي للتكاثر..."
    },
    {
      "title": "مسابقات الخيول",
      "content":
          "هناك مسابقات كثيرة مثل سباقات السرعة، قفز الحواجز، والترويض... وتُعد جزءاً مهماً من ثقافة الفروسية حول العالم..."
    },
    {
      "title": "الخيول العربية",
      "content":
          "الخيول العربية من أقدم وأشهر السلالات، وتتميز بجمال الرأس، الذكاء، والقدرة على التحمل لمسافات طويلة..."
    },
    {
      "title": "الخيول في الثقافات المختلفة",
      "content":
          "تلعب الخيول دوراً رمزياً في كثير من الحضارات... تُقدّس في بعض الثقافات، وتُستخدم في الأساطير والرموز الوطنية..."
    },
    {
      "title": "أدوات الفروسية",
      "content":
          "تشمل السرج، اللجام، الغطاء، أدوات التنظيف، وغيرها... يجب اختيار الأدوات المناسبة للحصان والفارس لضمان الراحة والسلامة..."
    },
    {
      "title": "معلومات عامة",
      "content":
          "الخيل يمكن أن تعيش حتى 30 سنة أو أكثر، وتفهم الإشارات الجسدية والنغمة الصوتية... لها ذاكرة قوية وتحب الروتين..."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("موسوعة الحصان"),
        backgroundColor: Colors.brown.shade400,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: bookPages.length,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.brown.shade100, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookPages[index]['title']!,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          bookPages[index]['content']!,
                          style: const TextStyle(
                            fontSize: 18,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'صفحة ${index + 1}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                if (_pageController.page! > 0) {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                if (_pageController.page! < bookPages.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
