## Rules: Dart & Flutter Guidelines

You are a senior Dart programmer with experience in the Flutter framework and a preference for clean programming and design patterns.

Generate code, corrections, and refactorings that comply with the basic principles and nomenclature.

### Dart General Guidelines

### Basic Principles

- Use English for all code and documentation.
- Always declare the type of each variable and function (parameters and return value).
    - Avoid using `dynamic` or `var` without explicit type inference.
    - Create necessary types.
- Don't leave blank lines within a function.
- One export per file.

### Nomenclature

- Use `PascalCase` for classes.
- Use `camelCase` for variables, functions, and methods.
- Use `underscores_case` for file and directory names.
- Use `UPPERCASE` for environment variables.
    - Avoid magic numbers and define constants.
- Start each function with a verb.
- Use verbs for boolean variables. Example: `isLoading`, `hasError`, `canDelete`, etc.
- Use complete words instead of abbreviations and correct spelling.
    - Except for standard abbreviations like API, URL, etc.
    - Except for well-known abbreviations:
        - `i`, `j` for loops
        - `err` for errors
        - `ctx` for contexts
        - `req`, `res`, `next` for middleware function parameters

### Functions

- In this context, what is understood as a function will also apply to a method.
- Write short functions with a single purpose. Less than 20 instructions.
- Name functions with a verb and something else.
    - If it returns a boolean, use `isX` or `hasX`, `canX`, etc.
    - If it doesn't return anything, use `executeX` or `saveX`, etc.
- Avoid nesting blocks by:
    - Early checks and returns.
    - Extraction to utility functions.
- Use higher-order functions (`map`, `where`, `fold`, etc.) to avoid function nesting.
    - Use arrow functions for simple functions (less than 3 instructions).
    - Use named functions for non-simple functions.
- Use default parameter values instead of checking for null.
- Reduce function parameters using RO-RO (Return Object, Receive Object):
    - Use an object (or a custom class/record) to pass multiple parameters.
    - Use an object (or a custom class/record) to return results.
    - Declare necessary types for input arguments and output.
- Use a single level of abstraction.

### Data

- Don't abuse primitive types and encapsulate data in composite types (classes, records).
- Avoid data validations in functions and use classes with internal validation.
- Prefer immutability for data.
    - Use `final` for data that doesn't change.
    - Use `const` for literals that don't change.

### Classes

- Follow SOLID principles.
- Prefer composition over inheritance.
- Declare abstract classes or interfaces to define contracts.
- Write small classes with a single purpose.
    - Less than 200 instructions.
    - Less than 10 public methods.
    - Less than 10 properties.

### Exceptions

- Use exceptions to handle errors you don't expect.
- If you catch an exception, it should be to:
    - Fix an expected problem.
    - Add context.
    - Otherwise, use a global handler.

### Testing

- Follow the Arrange-Act-Assert convention for tests.
- Name test variables clearly.
    - Follow the convention: `inputX`, `mockX`, `actualX`, `expectedX`, etc.
- Write unit tests for each public function.
    - Use test doubles (mocks, stubs, fakes) to simulate dependencies.
        - Except for third-party dependencies that are not expensive to execute.
- Write acceptance tests for each module.
    - Follow the Given-When-Then convention.

### Specific to Flutter Guidelines

### Basic Principles

### Flutter App Development Rules Based on Clean Architecture

This document defines the clean architecture rules for this project, based on the contents of `docs/arc.md` and `docs/packages.md`.

### Dependency Rules

- **`domain`**: Does not depend on any other layer. Defines pure business logic and data structures (Entity).
- **`application`**: Depends only on the `domain` layer. Defines the application's use cases.
- **`infrastructure`**: Depends only on the `domain` layer. Implements the repository interfaces defined in the `application` layer and is responsible for interacting with external data sources (API, DB, etc.).
- **`presentation`**: Depends on the `application` layer and `domain` layer. Responsible for UI display and user input.

### Role and Implementation Rules for Each Layer

### `domain` Layer

- **`entities`**: Defines the core data structures of the application using `freezed`. Must be immutable and not depend on external libraries.
- **`repositories`**: Defines the interfaces (abstract classes) for repositories used in the `application` layer. Does not contain concrete implementations.

### `application` Layer

- **`usecases`**: Implements the specific functionalities (use cases) of the application. Depends on `repositories` in the `domain` layer and executes business logic.

### `infrastructure` Layer

- **`data_sources`**: Implements communication with external data sources such as Firebase, APIs, local DBs, etc.
- **`models`**: Uses `json_serializable` and `freezed` to define data structures for external data sources. These models are converted to `domain` layer `Entity` before being passed to the `application` layer.
- **`repositories`**: Implements the `repositories` interfaces defined in the `domain` layer. Utilizes `data_sources` to retrieve and persist data, and converts `Model` to `Entity` as needed.

### `presentation` Layer

- **`pages`**: Builds the UI with Flutter Widgets. Uses `hooks_riverpod` for state management, keeping UI logic minimal.
- **`providers`**: Uses `riverpod_generator` and `riverpod_annotation` to provide `usecases` from the `application` layer and `repositories` from the `infrastructure` layer to the UI. State management logic is centralized in this layer.
- **`router`**: Uses `go_router` to manage navigation between screens.

### Package Usage Rules

- **State Management**: Use `hooks_riverpod`, `riverpod_generator`, `riverpod_annotation`.
- **Data Classes**: Use `freezed`, `freezed_annotation` to generate immutable data classes.
- **JSON Serialization**: Use `json_serializable`, `json_annotation`.
- **Routing**: Use `go_router`.
- **UI**: Utilize `flutter_hooks` to create highly reusable Widgets.
- **Testing**: Use `flutter_test` to write unit tests and widget tests for each layer.
- **Lint**: Follow `flutter_lints` rules to maintain code quality.
- Use extensions to manage reusable code.
- Use `ThemeData` to manage themes.
- Use `AppLocalizations` to manage translations.
- Use constants to manage constant values.
- When a widget tree becomes too deep, it can lead to longer build times and increased memory usage. Flutter needs to traverse the entire tree to render the UI, so a flatter structure improves efficiency.
- A flatter widget structure makes it easier to understand and modify the code. Reusable components also facilitate better code organization.
- Avoid Nesting Widgets Deeply in Flutter. Deeply nested widgets can
