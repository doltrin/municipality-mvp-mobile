# Contributing to Municipality MVP Mobile

Thank you for your interest in contributing to the Municipality MVP Mobile app!

## Getting Started

### Prerequisites

- Flutter SDK 3.10+
- Dart SDK 3.10+
- Android Studio or VS Code with Flutter extensions
- Git

### Setup

```bash
# Clone the repository
git clone https://github.com/doltrin/municipality-mvp-mobile.git
cd municipality-mvp-mobile

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## Code Standards

### Architecture

We follow **Clean Architecture** with feature-based organization:

```
lib/
├── core/           # Shared infrastructure
├── features/       # Feature modules
├── routing/        # Navigation
└── shared/         # Shared components
```

### Code Style

- **Dart Analysis**: All code must pass `flutter analyze` with zero issues
- **Formatting**: Use `dart format` before committing
- **Naming**: Follow Dart naming conventions
  - Files: `snake_case.dart`
  - Classes: `PascalCase`
  - Variables/Functions: `camelCase`
  - Constants: `camelCase`
  - Private members: `_prefixed`

### Widget Guidelines

1. **Use `const` constructors** wherever possible
2. **Add `super.key`** to all widget constructors
3. **Decompose large widgets** into private `_WidgetName` classes
4. **Use semantic widgets** for accessibility

### Documentation

- Add dartdoc comments (`///`) to all public APIs
- Include usage examples in complex classes
- Document parameters with `@param` style descriptions

## Pull Request Process

1. **Fork** the repository
2. **Create a branch** from `master`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** following the code standards
4. **Run analysis**:
   ```bash
   flutter analyze
   flutter test
   ```
5. **Commit** with clear messages:
   ```bash
   git commit -m "feat: add new feature description"
   ```
6. **Push** and create a Pull Request

### Commit Message Format

We follow [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting)
- `refactor:` Code refactoring
- `test:` Adding tests
- `chore:` Maintenance tasks

## Testing

### Running Tests

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/
```

### Writing Tests

- Place tests in `test/` directory mirroring `lib/` structure
- Name test files with `_test.dart` suffix
- Use descriptive test names

## Accessibility

All contributions must maintain WCAG 2.1 Level AA compliance:

- Minimum touch targets: 44x44 pixels
- Proper semantic labels for screen readers
- Sufficient color contrast ratios
- Support for system accessibility settings

## Security

- Never commit sensitive data (API keys, tokens)
- Use `SecureStorage` for sensitive user data
- Validate all user inputs
- Follow OWASP mobile security guidelines

## Questions?

Open an issue or contact the maintainers.

---

Thank you for contributing! 🎉
