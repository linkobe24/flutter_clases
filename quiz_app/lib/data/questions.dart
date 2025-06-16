import 'package:quiz_app/models/quiz_question.dart';

const questions = [
  QuizQuestion(
    '¿Cuales son los principales bloques de construccion de UI de Flutter?',
    [
      'Widgets',
      'Componentes',
      'Bloques',
      'Funciones',
    ],
  ),
  QuizQuestion(
    '¿Cómo se construyen las interfaces de Flutter?',
    [
      'Combinando widgets en código',
      'Combinando widgets en un editor visual',
      'Definiendo widgets en archivos de configuración',
      'Usando XCode para iOS y Android Studio para Android',
    ],
  ),
  QuizQuestion(
    '¿Cuál es el propósito de un StatefulWidget?',
    [
      'Actualizar la interfaz de usuario a medida que cambian los datos',
      'Actualizar los datos a medida que cambia la interfaz de usuario',
      'Ignorar los cambios en los datos',
      'Mostrar una interfaz de usuario que no dependa de los datos',
    ],
  ),
  QuizQuestion(
    'Qué widget deberías usar más a menudo: StatelessWidget o StatefulWidget?',
    [
      'StatelessWidget',
      'StatefulWidget',
      'Ambos son igual de buenos',
      'Ninguno de los anteriores',
    ],
  ),
  QuizQuestion(
    'Qué pasa si cambias los datos en un StatelessWidget?',
    [
      'La UI no se actualiza',
      'La UI se actualiza',
      'El StatefulWidget más cercano se actualiza',
      'Cualquier StatefulWidgets anidado se actualiza',
    ],
  ),
  QuizQuestion(
    '¿Cómo deberías actualizar los datos dentro de StatefulWidgets?',
    [
      'Llamando a setState()',
      'Llamando a updateData()',
      'Llamando a updateUI()',
      'Llamando a updateState()',
    ],
  ),
];
