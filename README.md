<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

## Flutter Project (Android/IOS)


## Package organization

Flutter version 3.29.2


## Nasa pictures 



| Feature                       | implementation
|-------------------------------|------------------------------
| Infinite Scroll or pagination | ✘                            
| List Refresh                  | ✘                            
| Detail Screen                 | ✓                            
| Transition Animation          | ✓                            
| Image Internal Cache          | ✓                            
| Inject Dependency             | ✓ GetIt                         
| Good Coverage                 | ✓                            
| Unit Tests                    | ✓                            
| UI Tests                      | ✓                            
| Video adaptation              | ✘ (Some videos come from Vimeo platform and the App don't consider it yet)
| Best image size               | ✘ (the best way is calculate the screen size and consider the image proportion (width x height) and find the better size)


## Package organization

| Packages                            | description
|-------------------------------------|------------------------------
| Common                              | Common files for any module/package                            
| Data                                | Define contract interface and repository layer                           
| Domain                              | Repository implementation and application use cases                  
| Presentation                        | UI Layer and Bloc (business logic)                            
| route                               | Fluro implementation, help navigate inside App widgets                         
| theme                               | Define colors, styles and more                            


## Architecture organization

Presentation <-> Bloc <-> UseCase <-> Repository

## Business Rules

* the project request information from Api
* the project should show local information if api requests fail
* the project should keep last state while running without network
* the project was projected to run into Android and IOS devices
* the project should have Unit Tests and UI Tests

<h1> Run the project </h1>

just run 'flutter pub get' and then 'flutter build'

<h1> Run the tests </h1>

flutter test --coverage

</body>
</html>
