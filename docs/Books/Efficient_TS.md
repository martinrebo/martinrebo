# Efficient TS

## Chapter 1: Getting to know TS

* TypeScript is an unusual language in that it neither runs in an interpreter (as Python and Ruby do) nor compiles down to a lower-level language (as Java and C do). Instead, it compiles to another high-level language, JavaScript.

### Item1: TS vs JS

* TS superset of JS

### Item2: TS Options

* use `noImplicitAny`
* for `stricNullChecks` add check/narrowing (`if (propertyExists)`) or non-null assertion (`propertyExists!.context`) - #Item9
* use `strict` > 👀 `noUncheckedIndexedAccess` - #Item48

### Item3: Code is independent of Types

* Cannot check types at runtime
* Interfaces are only types. Classes have type and value, they can be checked at runtime
* Code with type errors can produce output
* `noEmitOnError` to disable output on errors
* Type Operations cannot affect runtime values (`(val) => vas as number`)
* Runtime types may not the same as Declared types. "Unsound" types - #Item 48
* Cannot overload a fn based on TS types (c++ feature). Only works on type level
* You can provide multiple type signatures for a fn, but only a single implementation
* TS no effect on runtime performance (build time - and perfomance overhead vs native eg. generators)

### Item4: Structural Typing

* Ok to have different name types with same structure
* It can cause code errors as types are "open" not precise - #Item63 + #Item64 
* Excess property checking - #Item11
* Iterating over objects - #Item60
* Structural typing can lead to surprises on classes too!
* Can help to abstract dependencies on tests (no mocking libraries necessary) - #Item70

### Item5: Limit `any`

* No type safety
* Allows break contracts
* No language service (no infer, no rename Symbols)
* Masks bugs on refactoring
* Hides type design
* Undermines confidence on the type sys

## Chapter 2: TS type Sys

### Item6: use IDE to explore Type Sys

* `tsc` compiler and `tsserver` standalone server 
* widening (#Item20) narrowing (#Item22)

### Item7: Think of types as sets of values

* correspondence between TypeScript terms and terms from set theory.
* TypeScript types form intersecting sets (a Venn diagram) rather than a strict hierarchy. Two types can overlap without either being a subtype of the other.
* Disclaimer: these are relationships, not TypeScript code!
  
    ```js
    keyof (A&B) = (keyof A) | (keyof B)
    keyof (A|B) = (keyof A) & (keyof B)
    ```
    If you can build an intuition for why these equations hold, you’ll have come a long way toward understanding TypeScript’s type system!

* `never` bottom type vs `unknown` top type
* types are sets of values and the things you can do with them

### Item8: Symbol is Type Space vs Value Space

* Know how to tell whether you’re in type space or value space while reading a TypeScript expression. Use the TypeScript playground to build an intuition for this.

* Every value has a static type, but this is only accessible in type space. Type space constructs such as type and interface are erased and are not accessible in value space.

* Some constructs, such as class or enum, introduce both a type and a value.

* typeof, this, and many other operators and keywords have different meanings in type space and value space.

### Item9: Prefer Type Annotations to Type Assertions

* Prefer type annotations (: Type) to type assertions (as Type).

* Know how to annotate the return type of an arrow function.

* Use type assertions and non-null assertions only when you know something about types that TypeScript does not.

* When you use a type assertion, include a comment explaining why it’s valid.

### Item10: Avoid Object wrapper types

* `String, Number, Boolean, Symbol, BigInt` vs `string, number, boolean, symbol, bigInt`

### Item11: Excess Property Checking vs Type Checking

* Excess property checking does not happen when you use a type assertion
* A “weak type” is an object type with only optional properties. For these types, assignability checks require at least one matching property.

### Item12: Apply types to entire Fn expressions

* Use typeof fn to match the signature of another function, or Parameters and a rest parameter if you need to change the return type.

### Item13: type vs interface

* Understand the differences and similarities between type and interface. Know how to write the same types using either syntax. Be aware of declaration merging for interface and type inlining for type. For projects without an established style, prefer interface to type for object types.

### Item14: use readonly

### **Item 15:** Use Type operations and generic types to avoid repeating yourself

* Mapped types: `type Pick<T, K> = { [k in K]: T[k] };`
* `[k in keyof Options]` = Partials `Partial<Options>`
* You can include an as clause in them to rename the keys. There are many uses for this, but one is to invert the keys and values in a mapping: `type LongToShort = { [k in keyof ShortToLong as ShortToLong[k]]: k };`
* If the index clause in your mapped type is of the form K in keyof T or a few variants on it, then TypeScript treats it as a **“homomorphic”** mapped type. 
* The canonical use case for typeof is if you have a single value that you’d like to be the source of truth for a type (perhaps it’s some kind of schema or API specification). By making the value the source of truth, you avoid duplication in defining the type.
* `ReturnType<typeof getUserInfo>`

### Item16: Prefer more precise alternatives to Index Signatures

* Index signature: `type Rocket = {[property: string]: string};`
* What should you use index signatures for? Historically, they were the best way to model truly dynamic data.
* use Map: `Map<string, string>[]`
* While this may feel tedious, it does ensure that your data actually has the shape you expect. 
* This pattern of doing data validation on a broad type (Map<string, string>) to get a more specific one (Rocket) is common in TypeScript.
* Maps work around some famous gotchas involving the prototype chain.
* If the problem with using an index signature is that string is too broad, then you can use a `Record`. 
* Record is a built-in wrapper around a mapped type (Item 15).

### Item17: Avoid numeric index signatures

* JavaScript does not have a notion of “hashable” objects like you find in Python or Java.
* In particular, numbers cannot be used as keys. If you try to use a number as a property name, the JavaScript runtime will convert it to a string
* TypeScript models this by allowing numeric keys and distinguishing between these and strings. This is purely a fiction—string keys are accepted at runtime as the ECMAScript standard dictates that they must—but it is a helpful one that can catch mistakes:

### Chapter 3: Type inference and control flow Analysis

* In most languages, a variable has a type and it never changes. TypeScript is a bit different. A variable has a type at a location in your code. The process by which its type changes due to surrounding code is known as control flow analysis.

### Item18: Avoid cluttering with Inferable types

* Object literals for excess property checking
* function has multiple return statements, if it’s part of a public API, or if you want to use a named return type
  
### Item19: Use different variables for different types

* Union types are harder to work with than simple types like string or number because you usually have to check what they are before you do anything with them.

### Iten20: Understand how a variable get its type

* `satisfies Record<string, Point>` This is an improvement over a const assertion because it will report the error where you define the object, rather than where you use it.

* Understand how TypeScript infers a type from a literal by widening it.Familiarize yourself with the ways you can affect this behavior: const, type annotations, context, helper functions, as const, and satisfies.


