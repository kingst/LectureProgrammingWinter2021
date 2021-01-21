import UIKit

let names = ["Annie", "Milo", "Bob", "Honey"]
let sortedNames = names.sorted { $0 > $1 }

print(sortedNames)


func reverse(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

let sorted1 = names.sorted(by: reverse)
print(sorted1)

// anonymous functions are called Closure Expressions in Swift
let sorted2 = names.sorted(by: { (_ s1: String, _ s2: String) -> Bool in
    return s1 > s2
})
print(sorted2)

// infer types from context
let sorted3 = names.sorted(by: { s1, s2 in return s1 > s2 })
print(sorted3)

// implicity returns from signle-expression closures
let sorted4 = names.sorted(by: { s1, s2 in s1 > s2 })
print(sorted4)

// shorthand argument names
let sorted5 = names.sorted(by: { $0 > $1 })
print(sorted5)

// trailing closures, the compiler can infer the last argument in a argument list if it's a closure
let sorted6 = names.sorted { $0 > $1 }
print(sorted6)

let noNames: [String] = []
let sortedNoNames = noNames.sorted { $0 > $1 }
print(sortedNoNames)

let _ = names.sorted { (_ s1: String, _ s2: String) -> Bool in
    print(s1)
    print(s2)
    return s1 > s2
}

// closures are often executed at some point in time later
DispatchQueue.main.async {
    print("first line")
}


print("second line")
print("third line")

