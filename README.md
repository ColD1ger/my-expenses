# myspendings

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

• Որտե՞ղ եք պահում ծախսերի ցուցակը և ինչու այնտեղ.
Ծախսերի ցուցակը (_expenses) պահվում է հիմնական ExpensesScreen-ի State-ում։ Այն գտնվում է այնտեղ, քանի որ միևնույն ցուցակը պետք է հասանելի լինի մի քանի widget-ների՝ վերևի AppBar-ին (ընդհանուր գումարը հաշվելու համար), ֆիլտրին, ծախսերի ցուցակին, ինչպես նաև ավելացման, ջնջման և խմբագրման ֆունկցիաներին («lifting state up» սկզբունքով)։
• Ինչպե՞ս եք հաշվում ընդհանուր գումարը, և ինչու այն չեք պահում առանձին փոփոխականում.
Ընդհանուր գումարը հաշվվում է դինամիկ կերպով՝ get հատկության (_totalAmount) միջոցով, որը fold մեթոդով գումարում է տվյալ պահին ցուցադրվող (_filteredExpenses) ծախսերի արժեքները։ Այն առանձին փոփոխականում չի պահվում, որպեսզի տվյալների կրկնություն չլինի. եթե պահվեր առանձին, ամեն անգամ ծախս ավելացնելիս, ջնջելիս, խմբագրելիս կամ ֆիլտրը փոխելիս ստիպված կլինեինք ձեռքով թարմացնել այն, ինչը կարող էր սխալների պատճառ դառնալ։
• Ինչո՞ւ է Dismissible-ի key-ը expense.id, ոչ թե index.
Ցուցակից տարր ջնջելիս, ավելացնելիս կամ ֆիլտրելիս մնացած տարրերի index-ները փոխվում են։ Եթե օգտագործենք index-ը որպես key, Flutter-ը կարող է շփոթել widget-ները և սխալ տարր հեռացնել կամ անիմացիան սխալ ցուցադրել։ Իսկ expense.id-ն ունիկալ է և երբեք չի փոխվում, ուստի Flutter-ը միշտ հստակ ճանաչում է, թե կոնկրետ որ ծախսն է ջնջվել։
Ցանկանու՞մ եք օգնություն Git commit-ների հաջորդականությունը կազմելու կամ կոդի որևէ հատված ավելի մանրամասն բացատրելու հարցում։
