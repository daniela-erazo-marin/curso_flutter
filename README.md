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
