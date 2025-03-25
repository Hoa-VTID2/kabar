Name: kabar
Description:

# Architecture
+ Clean Architecture
# Technology
+ UI: Flutter
+ State Management: Provider
+ Navigation: auto_route
+ Network: dio, retrofit
+ Asynchronous Handling: Future, Stream
+ DI: get_it
+ Notification: Firebase
+ Localization: easy_localization
+ Resource: flutter_gen
+ Logger: Logger
+ Lint: Flutter lint
+ Code generator: freezed
+ Formatter: intl

# Folder structure
```
├── data                        # The data layer consists of a Repository implementation and data sources
├── di                          # Dependence injection
├── domain                      # Domain will contain only the core business logic (use cases) and business objects (entities)
├── presentation                # UI and logic UI
├── shared                      # commons
    ├── common
    ├── extensions
    ├── utils
├── app.dart                    # File init of App
├── main_prod.dart              # File init of prod flavor
└── main_dev.dart               # File init of dev flavor
```


# Notes:
+ To generate local keys, run below command:
flutter pub run easy_localization:generate -f keys -o locale_keys.dart -S assets/translations -O lib/presentation/resources

