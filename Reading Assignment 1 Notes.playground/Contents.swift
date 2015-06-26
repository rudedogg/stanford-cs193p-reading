//: Playground - noun: a place where people can play

import UIKit



/* Constants And Variables */

// define a constant - can only be assigned a value exactly once.  Always use if the value isn't going to change!
let myConstant = 1

// myConstant = 5 - not allowed, the constant has already been assigned a value.  This won't compile


// define a variable without declaring the type explicitly (type inference)
var answerToEverything = 42

// Declare multiple variables on one line
var x = 1, y = 2.0, z = "Hello"

// Type annotation - think of the colon  as meaning "...of type..."
var welcomeMessage: String
// welcomeMessage = getWelcomeMessage() // dynamically set the welcomeMessage

// It is bad practice to use a type annotation when the type can be inferred. A type annotation makes more sense if the variable doesn't have an initial value
var welcomeMessage2: String = "This is bad practice, don't do this"

// Declare multiple variables of the same type
var red, green, blue: Double

let π = 3.14159
print(π)

// Only use a reserved keyword if you have no choice.  Keywords can be escaped with `backticks`
let `let` = 5


// "string interpolation" - output a variable as a string, useful for print()/debugging
print("WelcomeMessage2 = \(welcomeMessage2)")



/* Comments */

// Single line

/* Multiline
   comment
   //How cool
  /* Even nested mutiline comments are allowed! */
*/



/* Semicolons */
print("Who needs semicolons?")
print("I do"); print("..")



/* Integer */
// Integers can be signed (negative, 0, and positive) or unsigned (positive of 0)
// Has 8, 16, 32, and 64 bit integers
var unsignedEightBitInt: UInt8
// unsignedEightBitInt = -2  // causes integer overflow

// 32-bit signed integer is type Int32

// All types in swift have a capitalized name

print(UInt8.min)
print(UInt8.max)
print(Int32.min)
print(Int32.max)

print(Int.min)
print(Int.max)
// Usually you just want to use "Int" - which will be 32 or 64 bit - whichever is native on the platform the code is executed
// On 32 bit platform, Int = Int32
// On 64 bit platform, Int = Int64

// Similar to Int8, Int 16, etc, there is a UInt type for unsigned 32/64 bit integers, which has the same size as the current platform
print(UInt.min)
print(UInt.max)

// Even if you are only storing postive values, using Int is preferred (code interoperability, type inference, etc).  Only use UInt if you actually need the extra storage range.



/* Floating-Point Numbers */
// Double = 64 bit
// Float = 32 bit

// using Double is preferred
// Double has a precision of at least 15 decimal digits
// Float can have a precision of as little as 6 decimal digits
var myDouble = 1.123456789
var myFloat: Float = 1.123456789



/* Type Safety and Type Inference */
// Swift is type safe
// Performs type checks when compiling code, and flags any mismatched types so you can fix them early in the development process

// type safe != always specifying the type of every variable
// type inference is there so you don't have to do that

let pi = 3.14159 // type inference knows we want a Double (Swift always chooses Double rather than float when infering the type)
let meaningOfLife = 42 // type inference knows we want an Int

let anotherPi = 3 + 0.14159 // Swift knows this should be a Double (because 3 is a literal, if 3 were a var, we'd need to cast it using Double(three))



/* Booleans */
// the type name is "Bool"
// In swift boolean values are "logical" - that means they can only be either true or false
let orangesAreOrange = true  // type is inferred as Bool when initialized to true/false
let turnipsAreDelicious = false

// A Bool makes a handy if condition
if turnipsAreDelicious {
    print("I LOVE turnips!")
}
else {
    print("Eww, turnips")
}

let i = 1

// this is a compile time error, a Bool can only be true/false!
//if i {
//}
if i == 1 {
    print("i==1")
}



/* Optionals */
// An optional means, there is a value and it is x, or there isn't a value at all
// Optionals are a new feature not in C/Objective-C
// Optionals can be used for ANY TYPE!

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber is inferred to be an Int? ("optional integer")

// to set an optional to a valueless state you can set it to nil
// again, this just clears to value
var serverResponseCode: Int? = 404
serverResponseCode = nil

// nil CANNOT be used with nonoptional constants and variables.  If you need to clear a variable, it should be declared as an optional!

// in objective-c nil is a pointer to a nonexistent object, in swift nul is the abscense of a value.  Optionals of any type can be set to nul, not just object types,

// to check if an optional has a value, simple compare to nil

if convertedNumber != nil {
    print(convertedNumber)
    
    // Since we checked and convertedNumber definitely has a value, we can unwrap it for display (this is called "forced unwrapping"
    print("Optionals need unwraped \(convertedNumber!)")
}

// using ! to access a non-existent option value triggers a runtime error.  Don't let it happen - check != nil first!

// Optional Binding
// Optional binding can be used on if and while statements
// If the value exists, it extracts it to a temp variable, all in one step
var someOptional: String? = "Test"
var someOptional2: String?

// the temp variable can be a constant
if let constantName = someOptional {
    print(constantName)
}

// Nothing is output, the if is skipped since someOptional2 doesn't have a value
if var varName = someOptional2 {
    print(varName)
}


// Int().init?(string) allows this to work (it returns an optional). Pattern should be useful.
// can be either a variable or constant
if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
}
else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}


// multiple optional bindings - both must have a value
if let actualNumber = Int(possibleNumber), var varName = someOptional {
    print(actualNumber)
    print(someOptional2)
}

// implicitly unwrapped optionals
// Used when you know an optional will always have a value after it is set, and makes it so you don't have to unwrap it to use it
// think of it as giving permission for the optional to be unwrapped automatically
// declared with a `!` following the type, rather than a `?`
let newOptional: String! = "Testing"
print(newOptional)


if newOptional != nil {
    print(newOptional) // check isn't required but is allowed.  Should use a normal Optional instead in this case though!
}

// combining implicitly unwrapped optional and option binding to create a var that is implicitly unwrapped
if let definiteString = newOptional {
    print(definiteString)
}



/* Assertions */
// Use assertions when a value can be false, but MUST be true to continue.  Not an alternative for properly checking things in code and working with the user, but useful for development

// this triggers the assertion, true is not = to false
//assert(true==false, "Descriptive message to help debug the assert")

// message is optional
//assert(1>=2)


/* Basic Operators */
// Temrinology
// Unary operator - operates on a single target.  The -var (unary minus operator) is an example
// Binary operator - operates on two targets - var1 * var2 (multiplication, addition, etc)
// Ternary operator - operates on three targets.  The ternary conditional operator is an example (x>1 ? true : false)

/* Assignment Operator */
// Assign multiple values using tuples
let (x1, y1) = (1, 2)
print(x1)
print(y1)

print("Strings can be " + "concatenated with +")

/* Modulo/Remainder */
10 % 3
// Works for floating point too :)
1 % 0.99
// And negatives
10 % -8
-10 % 8

/* Unary minus operator */
// - toggles the sign - + becomes -, - becomes +
var x3 = 300
-x3
var x4 = -400
-x4

/* Compound assignment operators */
x3 += x4
// compound assignment operators don't return a value though - compoundAssignment isn't set
let compoundAssignment = x3 += x4
print(compoundAssignment)

/* incrememnt/decrement operators */
var inc = 1
inc++ // increments inc AFTER returning it's value
// inc is now 2
++inc // increments inc BEFORE returning it's value
inc--
--inc
// typically you'll want to use ++var and --var since it's usually the desired behavior


/* Ternary conditional operator */
// question ? returnIfTrue : returnIfFalse
// avoid overuse, especially in a single statement!

// replaces
/* 
if question {
  returnIfTrue
} else {
  returnIfFalse
}
*/

// Example of setting a row's height using the ternary conditional operator
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)


/* Range Operators */
/* Closed Range Operator */
for index in 1...5 {
    print(index)
}

/* Half-Open Range Operator */
// Gives a range but is not inclusive, (0..>3) would be 0, 1, 2
// Useful for looping over arrays
let names = ["Austin", "George", "Frank"]

let count = names.count

for i in 0..<count {
    print(names[i])
}


/* Logical Operators */
// evaluated left to right
// !a = NOT  // use good variable names ie !allowedEntry is read as "not allowed entry"
// a && b = AND
// a || b = OR


/* Strings and Characters */
// strings are represented by the String type, which represents a collection of values of the Character type
// + concatenates
// var/let controls mutability, like all values in swift
// Swift String is bridged with Foundation's NSString class.  The NSString API is available on any swift String when you cast it to NSString
// A Swift String can be used with any API that requires an NSString instance
let stringLiteral = "This is a string literal.  It's type is inferred as a string since I've assigned an initial string value"

// Initializing an empty string ( these two methods create identical strings)
var emptyString = "" // empty string literal
var anotherEmptyString = String() // initializer syntax

// check if a string is empty using the .isEmpty property
if emptyString.isEmpty {
    print("Uh oh, that emptyString is empty")
}

// mutability
var mutable = "I am"
mutable += " a mutant"

// let crates a constant as expected
let unmutable = "I am"
//unmutable += " not a mutant, and this throws an error!"

// Strings are value types
// anytime you pass a string a new COPY is sent, NOT the original String (or a reference/pointer)
// this means you need not worry about altering a String in a function, it is merely a copy, and can only be modified by you
// The copy-by-default behavior is optimized by the compiler, a copy is only created when necessary (you change it's value)

// Characters
// Characters can be accessed through the .characters property
for letter in "THis is a string!".characters {
    print(letter)
}

// Stand alone Character
let exclamation: Character = "!"
print(exclamation)

// String values can be constructed with an array of Characters

let catCharacters: [Character] = ["C", "A", "T"]
let catString = String(catCharacters)
print(catString)

var favoritePlay = "Cats"
// use String.append() to append a character to a string. To append a String to a String, just use +
favoritePlay.append(exclamation)

// String Interpolation
// Include values in a String
var message = "5.5 * 5 = \(5.5 * 5)"
// expressions in the parentheses of an interpolated string cannot contain an escaped `\` or `"`

// Counting Characters
"this is a long string".characters.count
"123".characters.count

var cafe = "cafe"
cafe.characters.count
print(cafe)

// append unicode accent character to "cafe"
cafe += "\u{301}"

// unicode characters may not affect the count!
cafe.characters.count // still four characters, even though we've added the accent character
print(cafe)
// Characters in a string don't all use the same amount of memory!
// .characters causes Swift to loop over the entire string, may cause issues on a really large string.


// Comparing Strings
"this" == "that"

// Strings are considered equal if their extended grapheme clusters are canonically equivalent
"\u{E9}" == "\u{65}\u{301}"
// both are equivalent to é

// On the other hand, Latin A and Russian A are not considered equal, since they do not have the same linguistic meaning. 
// String and character comparisons are not locale-sensitive


// Prefix and Suffix Equality
// Performs a character-by-character canonical equivalence comparison as described above
"This".hasPrefix("Th")
"This".hasSuffix("s")



/* Mutability of Collections */
// collections: Array, Set, Dictionary
// Like the rest of Swift, collections are strongly typed and only store one type
// var = mutable, let = immutable
// use immutable collections (constants) if the collection doesn't need to change.  When using let Swift can perform optimizations

// Arrays
// Swift's Array type is bridged to Foundation's NSArray class

// long form
var collection: Array<String> = []
//short form (preferred)
var collection2 = [String]()

collection2.append("This")
collection2.count

// If type information is already provided, an Array can be cleared using:
collection2 = [] // collection2 is still of type [String]
collection2.append("It knows I'm a String")

// Array Initializers
// pass the initializer two variables, `count` which is the number of items, and `repeatedValue` which is the default)
var threeDoubles = [Double](count:3, repeatedValue: 0.0)
print(threeDoubles)

var moreDoubles = [Double](count:2, repeatedValue: 1.5)

// Arrays of the same type can be concatenated, the type is inferred
var myDoubles = threeDoubles + moreDoubles
print(myDoubles)

// Arrays can be initialized using an "Array Literal"
var shoppingList: [String] = ["Eggs", "Bacon"]
// this is the exact same, since we are initializing the array with string literals, Swift knows to use the String type
var shoppingList2 = ["Eggs", "Bacon"]

// get the number of items in an array (read-only property).  Don't try incrementing count to expand an Array!
shoppingList.count

// isEmpty propery returns a boolean, does count == 0 comparison
shoppingList.isEmpty

// Add compatible items to array
shoppingList.append("Tabasco")
shoppingList += ["new car", "new house"]

// Get items in array using subscript syntax
// Arrays in swift are zero-indexed
var firstItem = shoppingList[0]

// Get the last item in an Array.  Returns an Optional, will return nil ONLY if the .isEmpty
print(shoppingList.last)


// Modify items in array
shoppingList[3] = "like-new car"
shoppingList
// Can assign values using range.  Using a larger range than provided values will remove them
shoppingList[1...4] = ["Bananas", "Apples"]
print(shoppingList)


// Insert item at index
// We really need that maple syrup!
shoppingList.insert("Maple Syrup", atIndex: 0)

// Remove item at index
// Found the syrup in the pantry, we don't need it anymore
// removeAtIndex() returns the item, so it could be assigned like so: let firstItem = shoppingList.removeAtIndex(0)
shoppingList.removeAtIndex(0)

print(shoppingList)

// Trying to access an invalid index throws a runtime error, the largest valid index is always count - 1 (due to using zero index)

// Gaps are automatically closed - no sparse Arrays

// to remove the last item of the Array, use removeLast() to save from querying the count
let apples = shoppingList.removeLast()

// Iteration
// for in iterates over the values
for item in shoppingList {
    print(item)
}

// Array.enumerate() returns a pair with the index and value
for (index, value) in shoppingList.enumerate() {
    print("index: \(index) value: \(value)")
}


/* Control Loops */
var dogs = ["Zoey", "Sasha"]
// for in
for dog in dogs {
    print(dog)
}
// for in with index access
for (index, value) in dogs.enumerate() {
    print("Dog # \(index+1): \(value)")
}
// usual for loop
for var index = 0; index < 3; ++index {
    print(index)
}

// while - if true executes, stops when false
var testCondition = 0

while testCondition <= 5 {
    print(testCondition++)
}

// repeat while (do while) - always runs at least once, continues executing while condition is true
repeat {
    print(testCondition++)
} while testCondition <= 10



/* Conditional Statements */
var shouldRun = true

// if statement
if shouldRun {
    print("We're running")
} else {
    print("We're not running")
}


// Switch
let favoriteColor = "Red"
// switch compares a value against several possibilities of the same type
switch favoriteColor {
 // case "Green":
    // empty case is not allowed, this would throw an error!
    case "Red", "Yellow":
      print("My favorite color is Red (or Yellow)!")
    case "Blue":
      print("My favorite color is Blue!")
default: // catch-all, MUST be last
    print("My favorite color is \(favoriteColor)")
}
// once a match is found, the other conditions aren't evaluated! Only one case will be executed.  This is to prevent accidental fallthrough when a break is forgotten
// no break statement required


// ranges work too!
var bestScore = 53
switch bestScore {
case 0...20:
    print("You suck!")
case 21...50:
    print("You're okay")
case 51...100:
    print("You're good!")
default:
    print("Out of the park!")
}
// ranges work in switches because ... and ..< functions are overloaded to return eigher an IntervalType or Range.  An IntervalType in a switch statement, a Range in a for in loop

// value binding
let myPoint = (2, 0)

switch myPoint {
case(let x, 0):
    print("On the X axis at \(x)")
case(0, let y):
    print("On the Y axis at \(y)")
case(let x, let y):
    print("At \(x),\(y)")
}


/* Control Transfer Statements */
// swift has four control transfer statements
//   continue
//   break
//   fallthrough
//   return

// continue
// stops (short-circuits)  a loop and has it start again at the beginning of the next iteration
// a for loop is still incrmemented


// break
// ends execution of an entire control flow statment (such as a switch or loop)
// execution continues after the closing brace of the control flow statement, nothing else is executed!
// break can be used to ignore a switch case - since an empty case causes a compile time error


// fallthrough
// exists since Swift doesn't require a break statement after each case, like other languages
// will cause the next case to be executed (it's condition is NOT checked though!  it's executed no matter what!)



/* Functions */

func sayHello(personName: String) -> String {
    return "Hello \(personName)"
}

func sayHello2() -> String {
    return "Hello"
}

print(sayHello("Austin"))
print(sayHello2())

func times(_ x: Int,_ y: Int) -> Int {
    return x * y
}
times(5,2)
// functions with no return value return Void, which is an empty tuple ()
// if a function has a return type, it must return a value! Not returning a value is a compile-time error 