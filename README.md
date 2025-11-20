## Flutter MVC Architectural With GetX And API Integration

A Flutter mobile application using **GetX** for state management, 
designed with **MVC architecture**, and fully integrated with a RESTFUL **backend API**.


## 📦 Project Structure

```
lib/
├── core/                      # Global services, themes, constants
│   ├── api/                   # Your centralized API endpoints
│   ├── routes/                # Global route definitions using GetX
│   ├── services/              # Shared services (e.g., API, storage)
│   ├── themes/                # Theme & style configs
│   ├── utils/                 # Helper functions, extensions
│   ├── values/                # App config values & global variable
│   └── widgets/               # Reusable widgets across features
│
├── features/                  # Each feature/module is isolated here
│   ├── splash/
│   │   ├── controller/        # AuthController, LoginController
│   │   ├── model/             # LoginUserModel, etc.
│   │   ├── view/              # LoginPage, RegisterPage, etc.
│   │   └── bindings.dart      # GetX Bindings for auth module
│   │
│   ├── .................more
│
└── main.dart                  # Entry point
```


## 🚀 Key Features

- ✅ **State Management**: GetX provides simple yet powerful reactive state management.
- ✅ **Architecture Pattern**: Organized using the **MVC** pattern to separate concerns:
    - **Model**: Handles data structure.
    - **View**: UI components and widgets.
    - **Controller**: Handles business logic, communicates with models, and updates views.
- ✅ **Backend Integration**: Easily connects to REST APIs using `http` package or other API clients.

