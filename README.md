# DEAutoreleasePool
Learning project created to demonstrate how autorelease pools work internally

# Build Instructions
- clone the project locally
```
git clone https://github.com/domagojeklic/DEAutoreleasePool.git
```
- open in XCode
```
open DEAutoreleasePool/DEAutoreleasePool.xcodeproj/
```
- run and observe the console for demo/debug information

# Source code overview
In addition to main `DEAutoreleasePool` class, there are a couple of other helper files:
- `NSObject(DEAutorelease) ` defines NSObject category with custom `deautorelease` method
- `DEObject` extends `NSObject` with the identifier and logs when the object is created and deallocated
- `main.m` demonstrates the main loop and autorelease pool nesting
