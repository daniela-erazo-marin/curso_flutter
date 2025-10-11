# curso_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Taller 1 - Flutter

## 🎯 Objetivo
Construir una pantalla básica en Flutter con `StatefulWidget` y evidenciar el uso de `setState()`.

## 👩‍🎓 Estudiante
- Nombre: Daniela Erazo Marín
- Código: 230221027

## 🚀 Pasos para ejecutar
1. Clonar el repositorio:
   ```bash
   git clone https://github.com/daniela-erazo-marin/curso_flutter.git

2. Ingrese al directorio del proyecto:

   cd curso-flutter


3. Instalar las dependencias:

   flutter pub get


4. Ejecuta el proyecto en un emulador o dispositivo físico:

   flutter run

## Versión de flutter: Flutter 3.35.2


## Proyecto en uso:

<img width="654" height="1371" alt="Captura de pantalla 2025-09-07 192032" src="https://github.com/user-attachments/assets/a3c8c259-a244-4a99-a07a-4211fa249400" />


# Taller 2 - Flutter Navegación y Widgets

## 📌 Rutas
- `/` → HomeScreen
- `/paso_parametros` → Paso de parámetros con go/push/replace
- `/detalle/:parametro/:metodo` → Muestra parámetros recibidos
- `/ciclo_vida` → Demostración del ciclo de vida de un StatefulWidget
- `/widgets_demo` → Demostración de GridView, TabBar y ExpansionTile
- `/home/:parametro/:metodo` Muestra parámetros recibidos desde home page


## 📌 Widgets usados
- **GridView** → Mostrar lista de elementos en cuadrícula.
- **TabBar** → Manejo de secciones/pestañas en una misma pantalla.
- **ExpansionTile** → Mostrar información expandible (tercer widget).
- **Drawer personalizado** → Navegación lateral común.
- **Scaffold + AppBar** → Estructura base de todas las vistas.

## 📌 Ciclo de vida evidenciado
Se registran en consola:
- `initState()` → Inicialización del widget.
- `didChangeDependencies()` → Cuando cambian dependencias (ej. tema).
- `build()` → Cada vez que se reconstruye la UI.
- `setState()` → Cuando se actualiza el estado.
- `dispose()` → Antes de destruir el widget.


# Taller 3 - Asincronía, Timer e Isolates en Flutter

## 🧠 1. Uso de Future / async / await
- **Cuándo usarlo:**  
  Cuando queremos realizar operaciones asincrónicas sin bloquear la interfaz de usuario (UI).  
  Ejemplo: cargar datos desde una API o base de datos.

- **Implementación:**  
  Se usó `Future.delayed` para simular una carga de datos (2–5 s) y `async/await` para esperar el resultado.
  Se muestran estados en pantalla:
  - “Cargando...” → `CircularProgressIndicator`
  - “Éxito” → muestra la lista de nombres
  - “Error” → mensaje de error en caso de excepción

---

## ⏱️ 2. Uso de Timer
- **Cuándo usarlo:**  
  Para tareas repetitivas o temporizadas, como un cronómetro, cuenta regresiva o refresco de datos periódicos.

- **Implementación:**  
  Se usó `Timer.periodic` que se ejecuta cada segundo.  
  Botones disponibles:
  - Iniciar
  - Pausar
  - Reanudar
  - Reiniciar  
  Además, se limpia el recurso con `_timer.cancel()` en `dispose()`.

---

## ⚙️ 3. Uso de Isolate
- **Cuándo usarlo:**  
  Para tareas pesadas de CPU (procesamiento intensivo, cálculos grandes, generación de datos)  
  que no deben bloquear la UI principal.

- **Implementación:**  
  Se usa `Isolate.spawn()` y `ReceivePort` para comunicarse entre hilos.  
  El isolate ejecuta una suma grande y devuelve el resultado a la interfaz.

---

## 🗂️ 4. Diagrama de flujo de pantallas


[Menu Principal]
│
├──► [FutureView] → Simula carga de datos
│
├──► [TimerView] → Cronómetro con botones
│
└──► [IsolateView] → Tarea pesada en hilo secundario

El flujo de la app se encuentra en el word entregado.


# Taller HTTP con Flutter – Recetas con TheMealDB

## 📖 Descripción de la API usada

Este proyecto consume la API pública **TheMealDB**, que permite buscar recetas y obtener detalles de las mismas.

- **Variable de entorno usada**:  
  `MEAL_API_URL = https://www.themealdb.com/api/json/v1/1`

- **Endpoint de búsqueda**  
  `GET https://www.themealdb.com/api/json/v1/1/search.php?s={nombre}`  
  Si por ejemplo buscas *Arrabiata*:


  **Ejemplo de respuesta JSON**:
```json
{
  "meals": [
    {
      "idMeal": "52771",
      "strMeal": "Spicy Arrabiata Penne",
      "strCategory": "Vegetarian",
      "strArea": "Italian",
      "strInstructions": "Bring a large pot …",
      "strMealThumb": "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg",
      "strTags": "Pasta,Curry",
      "strIngredient1": "penne rigate",
      "strMeasure1": "1 pound",
      "strIngredient2": "olive oil",
      "strMeasure2": "1/4 cup",
      // … hasta strIngredient20 / strMeasure20 …
    }
  ]
}

Endpoint de detalle por ID
GET https://www.themealdb.com/api/json/v1/1/lookup.php?i={id}
Devuelve un objeto meals con una sola receta con todos sus datos.


Estructura de carpetas principal usada:

![Estructura](assets/estru.png)


lib/
  models/
    meal.dart
  services/
    meal_service.dart
  views/
    home/
    ciclo_vida/
    paso_parametros/
    widgets_demo/
    meal/
      meal_list_view.dart
      meal_detail_view.dart
  routes/
    app_router.dart
  themes/
    app_theme.dart
  widgets/
    base_view.dart
    custom_drawer.dart
main.dart
.env

Especificaciones:

models/meal.dart — modelo Dart que mapea JSON a objeto Meal.

services/meal_service.dart — lógica HTTP para consumir los endpoints y lanzar errores si algo falla.

views/meal/ — pantallas de listado (meal_list_view.dart) y detalle (meal_detail_view.dart).

routes/app_router.dart — configuración de rutas con go_router.

themes/, widgets/ y otras vistas pertenecientes a otros módulos de la app.




Estas son las rutas principales del módulo de recetas junto con los parámetros:

/meal	– MealListView (listado de recetas)
/meal/:id - meal_detail_view	id vía pathParameter (Detalle de recetas)


Aquí irían tus capturas de pantalla o GIFs:

📸 Listado de recetas con imágenes y nombres
![Listado de recetas](assets/list.png)

📸 Detalle de receta mostrando instrucciones, ingredientes y tags
![Detalle de receta](assets/detail.png)

📸 Pantalla de carga (CircularProgressIndicator)
![Cargando](assets/carga.png)

📸 Mensaje de error si falla la petición
![Error de red](assets/error.png)

📸 Mensaje de éxito
![Éxito de red](assets/a/la/exito.png)