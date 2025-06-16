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

