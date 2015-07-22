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
// all of the basic types in Swift (Integer, Double, Dictionary, String, Boolean, and Array) are actually Structs behind the scene, which are value types
// All structures and enums are value tyupes in Swift
// Any structure or enumeration instances you create are always copied when passed around in code

struct Resolution {
    var width = 0
    var height = 0
}

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd // a copy of hd is made, and assigned to cinema. Even though they share the same width, height, cinema and hd are two seperate instances
cinema.width = 2048
cinema.width
hd.width


// enums are also by value
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
rememberedDirection // still .West, since a copy was made

// Classes are Reference Types
// When assigned to a variable/constant or passed to a function, a reference to the existing instance is passed
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

// tenEighty is a constant instance of the VideoMode class
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

tenEighty.frameRate
// because classes are reference types, tenEighty and alsoTenEighty are just references to the same class instance

// Identity Operators
// to test whether two variables/constants point to the exact same instance of a class
// === - test equal
// !== - test not equal
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty are the exact same class instance")
}


// Choosing between Classes and Structures
// Consider using a structure when one or more of the following apply
//  - The structures primary purpose is to encapsulate a few relatively simply data values
//  - It is reasonable to expect the enacapsulated values will be copied when assigning or passing around an instance of the structure
//  - Any properties stored by the structure are themselves value types, which would be expected to be copied rather than referenced
//  - the structure does not need to inherit properties or behavior from another existing type

// Examples of good candidates for a struct
//  - the size of a geometric shape, with width/height properties of type Double
//  - a way to refer to ranges within a series, with a start and length property, both of type Int
//  - a point in a 3D coordinate system, with properties x, y, and z of type Double

// In all other cases, define a class, create an instance of the class to be managed and passed by reference.
// Classes should be the most common data structure in practice - NOT structures


// Assignment and Copy Behavior for Strings, Arrays, and Dictionaries
// Swift's String, Array, and Dictionary types are implemented as structures
// This is different then Foundation, where NSString, NSArray, and NSDictionary are implemented as classes.i

// Swift optimized the memory management of copying, and only does it when necessary.  Don't avoid assignment/copying - let Swift handle the optimization


/* Properties */
// Lazy Stored Properties
// a Lazy Stored Property is a property whose value isn't calculated until it is first used.
// it is indicated with the "lazy" modifier before the declaration
// a lazy property must always be declared as a variable - it cannot be a constant since it's value is assigned after initialization (constants must have a value before initialization)
// lazy properties are useful when the initial property is dependent on outside factors whose values aren't known until after initialization is complete
// also useful if the setup of the property is expensive/complex, and shouldn't be done unless/until it is needed.
// a use case might be reading a file into memory - we don't want to do that on initialization because it can be time consuming, so using lazy would be a good fit
// if multiple threads access a lazy property simultaneously, the property may be initialized more than once


// Property Observers
// property observers observer and respond to changes in a properties value.
// they are called every time a properties value is set - even if the value is the same as the existing value
// they can be added to any stored property (except lazy stored properties)
// they can be added to any inherited property (whether stored or computed) by overriding the property within a subclass (see Overriding chapter)
// not needed for non-overridden computed properties, because you can use the setter instead.

// you can define either or both of the observers on a property:
// willSet - called just before the value is stored
// didSet - called immediately after the new value is stored
// willSet is passed the new property value, you can specify a name, if not the default name of "newValue" is used
// didSet is passed the old value, you can specify a name, if not the default name of "oldValue" is used
// willSet and didSet are not called when a value is set in an initializer before delegation takes place
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set steps to \(newTotalSteps)")
        }
        didSet { // no custom name, using default oldValue name
            print("Changed steps from \(oldValue) to \(totalSteps)")
            // totalSteps += 1  // this would NOT trigger willSet/didSet again
        }
    }
}
var steps = StepCounter()
steps.totalSteps = 5
steps.totalSteps = 19
steps.totalSteps = 19 // willSet and didSet property observers are still called


// Global and Local Variables
// a global is defined outside any function, method, closure or type
// global constants and variables are always computed lazily, but do not need the lazy modifier
// local constants and variables are never computed lazily (unless using the lazy keyword)


// Type Properties
// properties assigned to the type rather than the instance.  Only one set for the type.
// useful for values that are universal to all instances of a type, such as a constant property all instances can use
// for value types (structures and enumerations) you can define stored and computed TYPE properties
// for reference types (classes) you can only define computed TYPE properties
// unlike stored instance properties, stored type properties MUST be given a default value (since the type itself has no initializer)
// type properties are defined with the static keyword (for classes with computed type properties, you can use the class keyword instead so subclasses can override)

struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
// although the examples above only show read only computed type properties, read/write can be used

// Querying and Setting Type Properties
// type properties are queries and set with dot syntax, but on the TYPE rather than the instance!
SomeClass.storedTypeProperty = "Some other value"
SomeClass.storedTypeProperty

struct Player {
    static let maxHP = 100 // could make this a var and update it in currentHP's didSet
    var currentHP:Int = 100 {
        didSet {
            if currentHP > Player.maxHP {
                currentHP = Player.maxHP
            }
        }
    }
}

var me = Player()
me.currentHP = 1000
me.currentHP
me.currentHP = 99
me.currentHP



/* Methods */
// Instance Methods
// Classes, Enumerations, and Structures can all define instance (and type) methods
// provide ways to access and modify the instances properties, or by providing functionality related to the instances purpose
// instance methods have the exact same syntax as functions
class Counter {
    var count = 0
    
    func increment() {
        ++count
    }
    
    func decrement() {
        --count
    }
    // refer to the methods first parameter using a preposition such as with, for, or by:
    func incrementBy(val: Int) { // this method name is good style. It can be read as a sentence.
        count += val
    }
}

var myCounter = Counter()
myCounter.incrementBy(56)
myCounter.count

// modifying external parameter names
class Table {
    var legs = 4
    
    func increaseLegsTo(newLegCount newLegCount: Int) { // double up the parameter name to make it required in the func call
        legs = newLegCount
    }
}
var kitchenTable = Table()
kitchenTable.increaseLegsTo(newLegCount: 6)
kitchenTable.legs

// The self Property
// Every instance has an implicit property called self, which is exactly equivelent to the instance itself

// self rarely needs used, the main exception is when an instance method parameter name is the same as an instance property (the parameter name takes precedence)
/* // this should work but doesn't compile.  Using an online compiler it works with Swift 1.2 and 2.0, not sure what the deal is
struct NewPoint {
    var x = 0.0, y = 0.0
    
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = NewPoint(x: 4.1,y: 5.2)
somePoint.isToTheRightOfX(1.3)
*/


// Modifying Value Types from Within Instance Methods
// By default properties of a value type (struct and enum) cannot be modified from within its instance methods
// however, a method can be marked with the mutating keyword to permit the behavior (changes to properties are written when the method ends)
// mutating instance methods can set the self property to a new instance of the type, replacing itself when the method ends

struct Enemy {
    var health = 100
    mutating func reduceHealthBy(hp: Int) {
        health -= hp
    }
    
    mutating func respawn() {
        self = Enemy()
    }
}
var bigBoss = Enemy()
bigBoss.health
bigBoss.reduceHealthBy(20)
bigBoss.health
// respawn sets self = Enemy() // this replaces the current instance with a newly created one
bigBoss.respawn()
bigBoss.health
let immortalBoss = Enemy()
//immortalBoss.reduceHealthBy(5) // not allowed, constants can't use mutating instance methods!

// enum mutating method example
enum PlayerState {
    case Dead, Alive
    
    mutating func killOrRespawn() {
        switch self {
        case Dead:
            self = PlayerState.Alive
        case Alive:
            self = PlayerState.Dead
        }
    }
}
var myState = PlayerState.Alive
myState.killOrRespawn()
myState


// Type Methods
// methods that are called on the type itself.  Work for classes, enums, and structs
// use the "static" keyword to signify a type method
// use "class" to allow subclasses to override
class SomeNewClass {
    class func someTypeMethod() {
      print("called")
        // self in the type method would refer to the type itself
        // calling other type methods doesn't require the type name, this type and it's properties are in scope
    }
}

SomeNewClass.someTypeMethod()


/* Subscripts */
// subscripts are shortcuts for accessing and modifying elements of a list, collection or sequence.
// classes, structure, and enumerations can define subscripts.  
// subscripts can be read/write or read only.  this is chosen by implementing a getter and/or setter (same as computed properties
/*
subscript(index: Int) -> Int {
    get {
        // return an Int
    }
    
    set(newValue) {
        // set it to the new value
    }
}
*/

struct TimesTable {
    let multiplier: Int
    
    // read-only subscript (can drop the get {} )
    // using a read-only subscript makes sense, a times table is static and based on mathematical rules
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
threeTimesTable[5]

// Subscript Usage
// The Disctionary type implements subscript behind the scenes. (the subscript returns an Optional)

// Subscript options
// subscripts can take any number of input parameters, and can return any type.
// subscripts can use variable and variadic parameters, but cannot use in-out parameters or provide default param values
// a class or struct can provide as many subscript implementations it needs, and the correct implementation will be inferred using the types of the value(s) in the subscript braces[].  This is known as subscript overloading
struct Matrix {
    let rows: Int, cols: Int
    var grid: [Double]
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        grid = Array(count: rows * cols, repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row: Int, col: Int) -> Bool {
        return row >= 0 && row < rows && col >= 0 && col < cols
    }
    
    subscript(row: Int, col: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, col: col), "Index out of range")
            return grid[(row*cols) + col]
        }
        set {
            assert(indexIsValidForRow(row, col: col), "Index out of range")
            return grid[(row*cols) + col] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, cols: 2)
matrix[0, 1] = 5
matrix[0, 1]
matrix[0,0] // 0



/* Inheritance */
// classes can inherit methods, properties, and subscripts.
// a subclass inherits from a class (that class is called the superclass)
// the subclass can override the superclass, replacing the superclasses behavior/etc with it's own
// classes can also add property observers to inherited properties and be notified of changes

// Defining a Base Class
// any class that doesn't inherit from another class is known as a base class
// swift doesn't have a universal/default inherited class.  all classes are base classes unless you specify a superclass
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // do nothing
    }
}
let someVehicle = Vehicle()
someVehicle.currentSpeed = 5.3
someVehicle.description


/* Subclassing */
// subclassing is the act of basing a new class off an existing class
// you inherit it's characteristics, which can then be refined (or added to).
// a subclass is declared by listing the superclass name, after the class name and following a colon
class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket
bicycle.currentSpeed = 15.0
bicycle.description

// subclasses can be subclassed
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
// tandem inherites from Bicycle, which inherits from Vehicle
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 350.0
tandem.description

// Overriding
// overriding is when a subclass supplies it's own implementation of an instance method, type method, instance property, type property, or subscript

// to override something, just use the override keyword
// it can be useful to access the superclass properties, methods, or subscripts when overriding - to do so use the super keyword
// super.someMethod() // access an overridden method within the overriding method implementation
// super.someProperty // access an overridden property in a getter/setter
// super[someIndex] // access the superclass version of a subscript within the overriding implementation


// Overriding Methods
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo!!")
    }
}
let train = Train()
train.makeNoise()


// Overriding Properties
// the getter and setter of an inherited instance or type property can overridden
// a custom getter and setter can be used to override any inherited property, both stored and computed.


// Overriding Property Getters and Setters
// a subclass doesn't know if an inherited property is stored or computed (it only knows the name and type to check that the superclass has a matching property)
// if you provide a setter as part of a property override, you must provide a setter
// if you don't want to override the getter, return super.propertyName from the getter

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
var subaru = Car()
subaru.description

// overriding property observers
// to get notified of changes to an inherited property (both stored and calculated) you can use  overriding
// you cannot add property observers to inherited constant stored properties, or computed read-only properties

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let jeep = AutomaticCar()
jeep.currentSpeed = 55.0
jeep.description


// Preventing Overrides
// to prevent a method, property, or subscript from being overridden mark it as "final"
// any attemot to override when marked final is a compile-time error
// a class can also be marked final, which prevents it from being subclassed



/* Initialization */
// initialization is the process of preparing a class, enum, or struct for use
// initializers are to make sure a class instance is ready before its first use
// deinitializers can also be implemented, to perform cleanup before an instance is deallocated


// Setting initial values for stored properties
// classes and structures MUST set all stored properties to a value - either as a default, or in the initializer
// note: using a default value or setting the value in the initializer will NOT trigger any property observers

// Initializers
struct Farenheit {
    var temparature: Double
    // this would work too (then the init() wouldn't be necessary)
    // var temparature = 32.0
    init() {
        temparature = 32.0
    }
}

var f = Farenheit()
f.temparature


// Customizing Initialization
// Initialization Parameters
// parameters can be used in the initializers definition to provide custom initializers based on the parameters provided
struct Celsius {
    var temparatureInCelsius: Double
    
    init(fromFarenheit farenheit: Double) {
        temparatureInCelsius = (farenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temparatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFarenheit: 212.0)
boilingPointOfWater.temparatureInCelsius
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
freezingPointOfWater.temparatureInCelsius

struct Color {
    var red: Double, green: Double, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}
var halfGray = Color(white: 0.5)
var magenta = Color(red: 1.0, green: 0.0, blue: 1.0)


// note: Swift provides an external parameter name for EVERY initialization parameter, since their names help identify the initializer being used. It's the same as if every parameter had a hash tag before it
// initalizer external names must always be used if provided, otherwise it's a compile-time error
// var errorColor = Color(0.5)


// Initializer Parameters Without External Names
// to not use the external parameter name(s) use a _ in the initializer definition: 
// init(_ celsius: Double) {
//    temparatureInCelsius = celsius
// }

// Optional Property Types
// optional properties don't have to be initialized, are nil until a value is assigned

// Constants in Initializers
// you can wait to assign a value to a constant property until the initializer. It MUST have a value by the time initialization finished
class SurveyQuestion {
    let text: String // constant is set in the init()
    var response: String? // optional property (notice it isn't assigned in the init() either)
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}
var question = SurveyQuestion(text: "What is your favorite color?")
question.ask()
question.response = "BLUE!!!"

// Default Initializers
// if a base class or structure has default values for all of it's properties and an init() isn't implemented, Swift provides a default initializer which sets all of the properties to their default values
class ShopppingListItem {
    var name: String? // optionals automatically has a default value of nil
    var quantity = 1
    var purchased = false
}
var milk = ShopppingListItem()

// Memberwise initializers for struct
// structures automatically geta memberwise initializer, if an init isn't implemented - even when its stored properties don't have default values
// initial values are passed by name
struct Size {
    var width, height: Double
}
var twoByTwo = Size(width: 2.0, height: 2.0)


/* Initializer Delegation for Value Types */
// initializers calling other initializers - avoids duplicating code
// value types (struct and enum) don't support inheritance, therefore can only delegate to other initializers they implement
// classes can inherit and thus need to ensure all stored properties (including inherited ones) are assigned a value)
// for value types, you use self.init to refer to other initializers (from the same value type)
// implementing an init on a value type causes you to lose the default init and memberwise initializer

struct SizeWithDefault {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = SizeWithDefault()
    // this is a replacement for the default initializer we lost (due to implementing custom initializers)
    // it takes no arguments and uses the stored properties default values, and allows us to create an instance with var x = Rect()
    init() {}
    // same as the memberwise initializer we would have had we not implemented custom initializers
    init(origin: Point, size: SizeWithDefault) {
        self.origin = origin
        self.size = size
    }
    // calculates the center of the point to use as the origin, then it calls(delegates) to the init(origin, size) initializer
    init(center: Point, size: SizeWithDefault) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()

let originRect = Rect(origin: Point(x: 1.0, y: 2.0), size: SizeWithDefault(width: 5.0, height: 10.0))

let centerRect = Rect(center: Point(x: 1.0, y: 2.0), size: SizeWithDefault(width: 5.0, height: 10.0))



/* Setting a Default Property Value with a Closure or a Function */
// useful if a property requires customization or setup
// when a new instance is created, the return value of the closure or function is assigned to the property
// Note: You cannot access self. or other properties in the closure or function, as they have not been initialized
// when using a closure to assign a property value at initialization, remember to include empty parens () so swift knows you want to execute the closure immediately and assign it's return value. Otherwise the closure itself is assigned!

struct CheckerBoard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }() // don't forget the parens when assigning a closure as a default property value
    
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}

let board = CheckerBoard()
board.squareIsBlackAtRow(0, column: 1)
board.squareIsBlackAtRow(9, column: 9)


/* Type Casting */
// checking the type of a class, or treat it as if it is a different superclass or subclass from its hierarchy
// type casting is implemented using the "is" and "as" operators
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

// swift infers the type of [MediaItem] through the common superclass (MediaItem)
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Movie(name: "Goodfellas", director: "Martin Scorsese"),
    Song(name: "Blue Suede Shoes", artist: "Elvis")
]
// items in the array are of type MediaItem, to use them as a Song/Movie they must be check their type, or downcast them to a different type

// Checking Type
// use the type check operator (is) to check whether an instance is of a certain subclass type
// returns true if it is of that subclass type, false if not
var movieCount = 0

for item in library {
    if item is Movie {
        ++movieCount
    }
}

movieCount


// Downcasting
// a constant or variable of a certain class type may refer to an instance of a subclass behind the scenes. 
// you downcast the constant/variable as the subclass type using as? or as!
// as? returns an optional value of the type trying to be downcast to (since downcasting can fail)
// as! downcasts and force-unwraps the result
// use as? if you are not sure the downcast will succeed, if it is not successful/possible it's value will be nil
// use as! if you are POSITIVE the downcast will succeed - if it doesn't there will be a runtime-error!
// use as to force downcast, and doesn't need optional unwrapping. Is always safe in a switch case statement
for item in library {
    // as? returns an optional here, returns Movie?, so we use optional binding to check and create the temp constant
    if let movie = item as? Movie {
        print("\(movie.name) directed by \(movie.director)")
    }
}
// casting doesn't actually modifiy the instance or change it's value. Casting just changes how it is treated and accessed


// Type Casting for Any and AnyObject
// Any and AnyObject are type aliases, provided for dealing with non-specific types
// AnyObject can represent an instance of any class type
// Any can represent an instance of any type, including function types
// only use Any/AnyObject when you explicitly need the behavior they provide


// AnyObject
// Cocoa APIs commonly return an array of AnyObject due to objective-c not having explicitly typed arrays
// the API often defines what types are actually held in the returned [AnyObject], in which case you can use "as" which forces the downcast, without the need for optional unwrapping
let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Alien", director: "Ridley Scott")
]


for object in someObjects {
    let movie = object as! Movie
        print("\(movie.name) directed by \(movie.director)")
}

// shorter version, downcasts the entire array rather than each item
for movie in someObjects as! [Movie] {
        print("\(movie.name) directed by \(movie.director)")
}


// Any
var things = [Any]()

things.append(0.0)
things.append((1.0, 5.2))
things.append("test")
things.append(Movie(name: "Jaws", director: "Steven Spielberg"))
things.append({ (name: String) -> String in "Hello, \(name)"})

for thing in things {
    switch thing {
    case 0 as Int:
        print("Zero as an Int")
    case 0 as Double:
        print("Zero as a Double")
    case let movie as Movie:
        print("\(movie.name)")
    case let text as String:
        print(text)
    case let (x, y) as (Double, Double):
        print("coordinate at \(x), \(y)")
    default:
        print("Unknown!")
    }
}

// notice the use of the forced version of the type cast operator (as) to check and cast to a type. It is always safe to use in a switch statement



/* Nested Types */
// Allow types to have supporting types nested, which help them provide their functionality

struct BlackJackCard {
    
    // nested Suit enum
    enum Suit: Character {
            case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        
        struct Values {
            let first: Int, second: Int?
        }
        
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }

let rank: Rank, suit: Suit

var description: String {
var output  = "Suit is \(suit.rawValue),"
    output += " value is \(rank.values.first)"
    
    if let second = rank.values.second {
        output += " or \(second)"
    }
    return output
    }
}


let theAceOfSpades = BlackJackCard(rank: .Ace, suit: .Spades)
theAceOfSpades.description

// referring to a nested type outside the context it is defined:
let heartSymbol = BlackJackCard.Suit.Hearts.rawValue