import UIKit

let name: String? = "Honey"

let optionalSome = Optional.some("Bob")
let optionalNone: String? = Optional.none


print(optionalSome == nil)
print(optionalNone == nil)

// unwrap the value to work with optionals
if let someName = name {
    print(someName)
} else {
    print("My dog doesn't have a name")
}

if let anotherName = optionalNone {
    print("my dog's other name is \(anotherName)")
} else {
    print("no dog alt name")
}

func formulateDogName() -> String? {
    guard let theName = name else {
        print("My dog doesn't have a name!")
        return nil
    }
    
    guard let lastName = optionalSome else { return nil }
    
    return "Dog name: \(lastName), \(theName)"
}

formulateDogName()

func foo(bar: String?) {
    let biz = bar?.hasPrefix("H")
    let baz = bar ?? "Bob"
    // what are the types for biz and baz and what's going on???
}

// optional chaining when calling methods on optional types
let hasPrefix = name?.hasPrefix("H")

func getOrElse<T>(_ value: T?, defaultValue: T) -> T {
    if let unwrappedValue = value {
        return unwrappedValue
    } else {
        return defaultValue
    }
}

let dogName = getOrElse(name, defaultValue: "Bob")
let dogName2 = name ?? "Bob"

let unwrappedName = name!

let unwrappedName2 = optionalNone!

