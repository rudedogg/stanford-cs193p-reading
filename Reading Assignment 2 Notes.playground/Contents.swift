//: Playground - noun: a place where people can play

import UIKit


/* The Basics */

/* Numeric Literals */
// Integer Literals
let decimalInteger = 22
let binaryInteger = 0b10 // 2 in binary
let octalInteger = 0o31
let hexadecimalInteger = 0x1A

// Floating Point Literals
// to define a floating point literal in hex/decimal they need a number on both sides of the decimal point
// they can have an exponent as well
var floatingPointHex = 0xC.3p0
var doubleWithExponent = 1.25e10

// formatting literals for readability
// using '_' and padding with leading zeros doesn't affect the value
var oneMillion = 1_000_000
var paddedDouble = 000123.456


/* Numeric Type Conversion */
// Only use Int16, UInt16, etc when required for performance, memory usage, or other required optimizations - and compatibility with an outside API/data sources

// Integer Conversion
// let cannotBeNegative: UInt8 = -1  // generate compile time error, cannot put a negative in an unsigned int
// let tooBig: Int8 = Int8.max + 1

// Type conversion for specific number types is handled in an "opt-in" way to prevent unexpected type conversions - you must be explicit
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
// let twoThousandAndOne = twoThousand + one // type error
let twoThousandAndOne = twoThousand + UInt16(one)

// behind the scenes the UInt16 type has an initializer that accepts a UInt8 type.  Due to that, not all types can be used in the UInt16() initializer call
// Allowing UInt16 to accept additional types (including custom types) is covered in the section titled "Extensions"


// Integer and Floating-Point Conversion
// conversions between Integers and Floating Point types must be explicit as well
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine

// Floating-Point to Int must be explicit too
// Initializing a new Int using a floating-point source will always truncate the value
let integerPi = Int(pi)

let allowed = 3 + 0.145 // allowed since the literals have no type, it is only infered at compile time when evaluated


/* Type Aliases */
// Type aliases define an alternative name for an existing type.
// An alias can be used to create descriptive types/names when working with an external data source
typealias AudioSample = UInt16
AudioSample.max


/* Tuples */
// tuples group multiple values into a single compound value. The values can be of any type
var notFound = (404, "Not Found")
// the notFound tuple can be described as "a tuple of type (Int, String)"
// you can have any number or combination of types (Int, Int, Int), (Bool, Int, UInt16), etc

// to get specific values from a tuple, you "decompose" them:
let (statusCode, statusMessage) = notFound
print(statusMessage)


// to skip values use _
let (_, newStatusMessage) = notFound
print(newStatusMessage)

// tuples can also be accessed using index values and dot notation:
notFound.0

// elements can also be named
let myName = (first: "Austin", last: "Rude")
myName.first
myName.0 // index values still work

// Tuples are useful as return values for functions.  It's a method to return multiple values from a function
// Tuples are good for temporary data in a single scope, if the data will be passed to other scopes or is complex then a struct or class is more appropriate



/* Basic Operators */
// Nil Coalescing Operator
// Provides an elegent way to do conditional checking and unwrap the optional

// unwraps an optional a if it contains a value, otherwise returns b
// b must be the same type of a
// (a ?? b)
// if a != nil, it short-circuits (b never is evaluated)

// shorthand of the following ternary conditional operator syntax:
// a!= nil a! : b

let defaultColorName = "Red"
var userDefinedColorName: String?

var colorName = (userDefinedColorName ?? defaultColorName)



/* Strings and Characters */
// Remeber strings are value types, you are always working with a copy when passing them to a function, etc.
// NSString in cocoa is different, when creating an NSString instance and passing it to a function, you are passing a reference! You only use a copy when specifically requesting it!

// Unicode
// Swift's String and Unicode types are fully unicode compliant

// Unicode Scalars
// Behind the scenes the String type is built from Unicode scalar values
// Unicode scalar is a 21 bit number for a character or modifier, such as U+0061 for "a" or U+1F425 for "FRONT-FACING BABY CHICK" - 🐥

// unicode scalar - u{1-8 digit hex number}
let heart = "\u{1F496}"


// Extended Grapheme Clusters
// A Character instance represents an extended grapheme cluster
// an extended grapheme cluster is a sequence of one or more unicode scalars that produce a single human-readable character
let eAcute = "\u{00e9}" // Character type
let eAcute2 = "\u{65}\u{301}" // Character type

let testString = "T\u{65}\u{301}his is just a test"
let testIndex = testString.startIndex.successor() // successor returns the next human-readable Character
testString[testIndex]
let testIndex2 = testString.endIndex.predecessor() // predecessor returns the previous human-readable Character
testString[testIndex2]

/* Unicode Representations of Strings */
let dogString = "Dog\u{203C}\u{1F436}"
// UTF-8 uses an 8-bit(using UInt8 values) representation for each character
for char in dogString.utf8 {print(char)}
// UTF-16 uses a 16-bit(using UInt16 values) representation for each character
for char in dogString.utf16 {print(char)}
// Unicode Scalar Representation uses a 21-bit(using UInt32 values) representation for each character
for char in dogString.unicodeScalars {print(char)}



/* Collection Types */
// Dictionaries
// unordered key/value store
// Swift's Dictionary type is bridged with Foundation's NSDictionary class
// A dictionary key MUST conform to the Hashable protocol
var dict = [Int: String]()
dict[0] = "Zero"
dict[1] = "One"
dict
dict.count
// empty a dictionary
// dict = [:] // keeps types

// create a dictionary with a dictionary literal
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// test if dict has data
airports.isEmpty

// update an existing value
airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"
airports.updateValue("London", forKey: "LHR")
airports

// remove a pair
airports["LHR"] = nil
airports.removeValueForKey("DUB")
airports

// Loop over a Dictionary
for (key, value) in airports {
    print(key)
    print(value)
}

// get the keys or values into an Array
var airportsArray = [String](airports.keys)



/* Control Flow */
// Tuples
// Tuples can be used to test multiple values in a switch statement
// If you want to accept any value in the tuple, use _
let somePoint = (1, 0)

switch somePoint {
case (0, 0):
    print("At the center")
case (0, _):
    print("On the x-axis")
case (_, 0):
    print("On the y-axis")
case (-2...2, -2...2):
    print("In a box between (-2, -2) and (2, 2)")
default:
    print("At \(somePoint.0), \(somePoint.1)")
}
// unlike C, swift allows multiple matching switch cases.  When multiples matches are possible, the first matching case is always used

// Value Bindings
// a switch case can bind values it matches to temporary variables/constants:
var someOtherPoint = (1, 5)

switch someOtherPoint {
case (0, let y):
    print("On the x-axis, at \(y)")
case (let x, 0):
    print("On the y-axis, at \(x)")
case let (x, y): // since this case matches all other possible values, a default case is not required!
    print("At \(x), \(y)")
}
// var and let work, if using var the variable is only for the scope/lifetime of the case


// Where
// a switch case can use a where clause to check for additional conditions
someOtherPoint = (5, 5)
switch someOtherPoint {
case (let x, let y) where x == y:
    print("\(x) == \(y) is on the line where x == y")
case (let x, let y) where x == -y:
    print("\(x) == \(y) is on the line where x == -y")
case let (x, y):
    print("At \(x), \(y)")
}
// the switch case only matches if the where condition evaluates to true



/* Functions */
// Functions with Multiple Return Values
// a tuple can be used to return multiple values from a function as part of one compound value
func minMax(array: [Int]) -> (min: Int, max: Int) {
    return (array.minElement()!, array.maxElement()!)
}
// minMax returns both the min and max item in the array as a tuple of type (Int, Int)
var results = minMax([1, 60,  5, 9])
results.min
results.max
// since the return tuple members were labeled, you can use dot notation to retrieve the values


// Optional Tuple Return Types
// If the tuple type being returned can have "no value", you can use an optional tuple return type
// specified with a question mark after the type definition: (Int, String)?
func minMaxSafe(array: [Int]) -> (min: Int, max: Int)? {
    if !array.isEmpty {
        return (array.minElement()!, array.maxElement()!)
    } else {
        return nil
    }
}
// minMax returns both the min and max item in the array as a tuple of type (Int, Int)
var safeResults = minMaxSafe([])

// Optional binding can be used to extract a value
if let theResult = minMaxSafe([5, 2, 33]) {
    print("The min is \(theResult.min) and the max is \(theResult.max)")
}


// Function Parameter Names
// Functions parameters have both an external and a local parameter name
// the internal name is only used within the function

 // by default the first parameter omits its external name, and the other parameters use their loca names as their external name:
func doSomething(myParam1: Int, myParam2: Int) -> Int {
    return (myParam1 + myParam2)
}
doSomething(2, myParam2: 3)

// all parameters must have unique kicak nanesm but may share external names

// Specifying External Parameter Names
func doSomethingElse(ext local: String) {
    print(local)
}
doSomethingElse(ext: "Test")
// if you provide an external parameter name for a parameter, it must ALWAYS be used when calling the function

func sayHello(to person1: String, and person2: String) {
    print("Hi \(person1) and \(person2)")
}
sayHello(to: "Zoey", and: "Sasha")
// using expressive external parameter names as above is considered good style

// Omitting External Parameter Names
// You can omit the 2nd and beyond external parameter names by using _
// the first parameter's external name is _ by default
func someFunction(firstParameterName: Int, _ secondParameterName: Int) -> Int {
    return firstParameterName + secondParameterName
}
someFunction(1, 5)

// Default Parameter Values
// place default parameters at the end of the argument list. It ensures calls to the function use the same order for non-default parameters
func myNewFuncWithDefaultParam(highScore: Int = 0) -> Int {
    return highScore
}
myNewFuncWithDefaultParam(555)


// Variadic Parameters
// a variadic parameter accepts 0 or more values of a specified type
// Specify a variadic parameter by putting ... immediately after the parameter type

func sumMultipleInts(numbers: Int...) -> Int {
    var total = 0
    for number in numbers {
       total += number
    }
    return total
}
sumMultipleInts(5, 20, 11, 30, 55)

func arithmeticMean(numbers: Double...) -> Double {
    var total = 0.0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

arithmeticMean(22, 21, 20)
// a function can have only one variadic parameter, and it must be the last parameter in the parameter list

// Constant and Variable Parameters
// function parameters are constants by default - attempting to change them in the function body is a compile error

// to get a modifiable copy of the variable, use the prefix var:
func alignRight(var string: String, totalLength: Int, pad: Character) -> String {
    let amountToPad = totalLength - string.characters.count
    if amountToPad < 1 {
        return string
    }
    let padString = String(pad)
    for _ in 1...amountToPad {
        // string can be modified due to the var keyword in the parameter list, otherwise this wouldn't compile
        // the variable parameter only exists in the function body
        string = padString + string
    }
    return string
}

let originalString = "hello"
let paddedString = alignRight(originalString, totalLength: 20, pad: " ")

// In-Out Parameters
// unlike variable parameters above, In-Out parameters can be used to make modifications in the function persist
// in-out parameters are specified with the `inout` keyword
// an inout parameter is passed into the function, modified, and passed back out of the function to replace the original value
// only a variable (var) can be an inout, a constant (let) is not allowed
// in the function call, you place an & before the parameter ot indicate you know it can be modified by the function
// inout's cannot have default values, and variadic parameters cannot be inout
// if you mark a parameter inout, it cannot also be marked var or let

func swapTwoInts(inout a: Int, inout _ b: Int) {
    let originalA = a
    a = b
    b = originalA
}
var a = 1
var b = 2
swapTwoInts(&a, &b)
a
b
// inout parameters are an alternative way to modify data outside of a function (versus returning a value)


/* Closures */
// capturing values
// a closure can capture values outside it's scope, and refer to/modify them within it's body, even though the original scope no longer exists
// a nested function is the simplest example of a closure
// -> Void -> Int means it returns a function which returns an Int
func makeIncrementer(amount: Int) -> Void -> Int {
    var runningTotal = 0
    
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
let incrementByTen = makeIncrementer(10) // makeIncrementer returns a function which increments by 10
incrementByTen()
incrementByTen() // notice how the value of runningTotal is persisted - it is a reference within incrementor()
// even though incrementByTen() returned, it still holds a reference to the existing runningTotal amount
// since amount isn't mutated, it is stored as a copy of the value
incrementByTen()
// Swift determines what hsould be by value and by reference, it also does all the memory management

let incrementBySeven = makeIncrementer(7)
// incrementBySeven and incrementByTen contain different references and are independent
incrementBySeven()
incrementByTen()
incrementBySeven()

// if you assign a closure to a property of a class instance, the closure captures the instance.  You create a strong reference cycle between the closure and the instance.  
// these reference cycles can be broken with "capture lists"


// Closures are Reference Types
// incrementBySeven() and incrementByTen() were able to increment their runningTotal because functions AND closures are reference types
// here we're assigning a REFERENCE to incrementByTen.  let specifies that the reference cannot be changed, not that the function can't return a different value
let anotherIncrementByTen = incrementByTen
anotherIncrementByTen()



/* Enumerations */
// an enumeration defines a common type for a group of related values, and allows you to work with those values in a type-safe way
// enumerations are first-class types, with many features traditionally supported only by classes: computed properties, instance methods, inititializers, extensions, and protocols.

// Enumeration Syntax
enum CompassPoint {
    case North
    
    case South
    
    case East
    
    case West
    
    case Unknown
}
// North, South, etc are member values (or members)

// multiple members can be on a single line:
/*
enum CompassPoint {
    case North, South, East, West
}
*/

// an enum definition defines a new type, so it should be Capitalized
// give enumeration types singular rather than plural names

var directionToHead = CompassPoint.West
// now that directionToHead is declared as a CompassPoint, we can use dot syntax
directionToHead = .South  // Swift knows this is a CompassPoint, so we must mean CompassPoint.East

switch directionToHead {
case .North:
    print("Say Hi to Santa!")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
case .South:
    print("Watch out for penguins")
default:
    print("Be careful!")
}


// Associated Values
// store values of different types in an enum
enum Barcode {
    
    case UPCA(Int, Int, Int, Int)
    
    case QRCode(String)
}
var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)


// when re-assigning to .QRCode, the UPCA is released.  Variables of the Barcode type can hold a UPCA or QRCode, not BOTH at once!
productBarcode = .QRCode("ABC")

switch productBarcode {
//case .UPCA(let numberSystem, let manufacturer, let product, let check): // for when all members aren't constants
case let .UPCA(numberSystem, manufacturer, product, check):
    print("\(manufacturer), \(product)")
case .QRCode(let code):
    print("\(code)")
}

// Raw Values
// alternative to associated values, these enum members are prepopulated with default values (called raw values)
enum ASCIIControlCharacter: Character {
    
    case Tab = "\t"
    
    case LineFeed = "\n"
    
    case CarriageReturn = "\r"
}
// raw values are prepopulated and predefined in the enum definition
// raw values can be strings, characters, or any of the integer or floating-point types
// the raw value for a particular enum is always the same
// they differer from associated values - which are set when you create a new constant or variable based on one of the enum's members,

// Auto-incrementation increments the raw value for each enum member
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
let earthsOrder = Planet.Earth.rawValue // access the raw value with .rawValue

// an enum with a type of rawValue (Int, Double, String, etc) automatically gets an initializer that accepts a rawValue type
let seventhPlanet = Planet(rawValue: 7) // returns Planet?, it is a failable initializer
seventhPlanet!

// optional binding to a switch statement
if let somePlanet = Planet(rawValue: 9) {
    switch somePlanet {
    case .Earth:
        print("Safe for humans")
    default:
        print("Not safe for humans")
    }
}
else {
    print("Planet not found")
}



/* Classes and Structures */
// Structures and Enumerations are value types