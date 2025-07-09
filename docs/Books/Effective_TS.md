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

### Item20: Understand how a variable get its type

* `satisfies Record<string, Point>` This is an improvement over a const assertion because it will report the error where you define the object, rather than where you use it.

* Understand how TypeScript infers a type from a literal by widening it.Familiarize yourself with the ways you can affect this behavior: const, type annotations, context, helper functions, as const, and satisfies.

### Item21: Create Objects all at once

* Prefer to build objects all at once rather than piecemeal.
* Use multiple objects and object spread syntax ({...a, ...b}) to add properties in a type-safe way.
* Know how to conditionally add properties to an object.

### Item22: Understand Type Narrowing

* Also known as Control Flow Analysis. But in TypeScript, a symbol has a type at a location. 
* `if`, `instanceof`, property check, `isArray` 
* falsy primitive values: null, empty string, 0
* *tagged/discriminated union*. `switch` #item59
* special function "user-defined type guard"
* The issue is that TypeScript doesn’t understand the relationship between the has and get methods of a `Map`. It doesn’t know that checking has eliminates the possibility of undefined in a subsequent lookup with get
* This pattern is common and can be written more concisely using the “nullish coalescing” operator (??)
* Callbacks DON'T narrow

### Item23: Be consistent in the use of aliases

* We’re using two names for the same thing: This is a distinction without a difference (Item 41).
* So TypeScript makes the pragmatic choice to assume the function does not invalidate its type refinements. Item 48 discusses other situations like this where TypeScript trades safety for convenience.
* Be aware of how function calls can invalidate type refinements on properties. Trust refinements on local variables more than on properties.

### Item24: Understand how context is used in type inference

* string literals, tuple, object, callbacks, 

### Item25: Understand evolving types

* "evolving arrays"
* Improved type inference is a good reason to prefer for-of loops to forEach loops in TypeScript.

### Item26: Use Fn constructs and libraries

* lodash and underscore

### Item27: Use async

### Item28: Uses classes and currying to create new inference sites

* Prefer the currying approach if you’d like to create a local type alias.

## Chapter 4: Type Design

### Item29: Prefer types that represent valid states

* state.error vs state.loading

### **Item30**: Liberal in what you accept, strict in what you produce !!

* Postel's Law - robustness principle. (TCP net protocol)
* Input types tend to be broader than output types. Optional properties and union types are more common in parameter types than return types.
* Avoid broad return types since these will be awkward for clients to use.
* To reuse types between parameters and return types, introduce a canonical form (for return types) and a looser form (for parameters).
* Use `Iterable<T>` instead of `T[]` if you only need to iterate over your function parameter

### Item31: Don't repeat type info in doc
### Item32: Avoid include null or undefined in type aliases

* ...or write NullableVar
* Avoid defining type aliases that include null or undefined.

### Item33: Push null values to the perimeter 

* Avoid designs in which one value being null or not null is implicitly related to another value being null or not null.
* Push null values to the perimeter of your API by making larger objects either null or fully non-null. This will make code clearer both for human readers and for the type checker.
* Consider creating a fully non-null class and constructing it when all values are available.

### Item34: Prefer Unions of interfaces to interfaces with unions

* Interfaces with multiple properties that are union types are often a mistake because they obscure the relationships between these properties.
* Unions of interfaces are more precise and can be understood by TypeScript.
* Use tagged unions to facilitate control flow analysis. `type Layer = FillLayer | LineLayer | PointLayer;`
* Consider whether multiple optional properties could be grouped to more accurately model your data.

### Item35: Precise alternatives to string types

* Prefer keyof T to string for function parameters that are expected to be properties of an object.

```ts
function pluck<T>(record: T[], key: keyof T): T[keyof T][];

function pluck<T, K extends keyof T>(records: T[], key: K): T[K][] {
  return records.map(r => r[key]);
}
```

### Item36: Distinct type for special values

* Avoid special values that are assignable to regular values in a type. They will reduce TypeScript’s ability to find bugs in your code.
* Prefer null or undefined as a special value instead of 0, -1, or "".
* Consider using a tagged union rather than null or undefined if the meaning of those values isn’t clear.

### Item37: Limit optional properties

* Optional properties can prevent the type checker from finding bugs and can lead to repeated and possibly inconsistent code for filling in default values.
* Think twice before adding an optional property to an interface. Consider whether you could make it required instead.
* Consider creating distinct types for un-normalized input data and normalized data for use in your code.
* Avoid a combinatorial explosion of options

### Item38: Avoid repeated parameters of same type

* Avoid writing functions that take consecutive parameters with the same TypeScript type.
* Refactor functions that take many parameters to take fewer parameters with distinct types, or a single object parameter.

### Item39: Prefer unifying types to modeling differences

* camelCase vs snake_version (accept superficial inconsistency)

### Item40: Prefer imprecise types to inacurate types

* Avoid the uncanny valley of type safety: complex but inaccurate types are often worse than simpler, less precise types. If you cannot model a type accurately, do not model it inaccurately! Acknowledge the gaps using any or unknown.
* Pay attention to error messages and autocomplete as you make typings increasingly precise. It’s not just about correctness: developer experience matters, too.
* As your types grow more complex, your test suite for them should expand.


### Item41: Name types with problem domain

### Item42: Avoid types of anectdotal data

* What if there’s no spec or official schema available? Then you’ll have to generate types from data. Tools like quicktype can help with this.

## Chapter 5: Unsoundness and the any type

* unsoundness: when a symbol’s static type does not match its runtime type. Even if you eliminate all the anys from your code, you may still fall into soundness traps.

### Item43: Use narrowest scope for any

* `as any` is preferable. `ts-expect-error` preferable over `ts-ignore`

### Item44: prefer precise variants of any

* `any[]`, `any[][]`,`{[key: string]: any} or Record<string, any>`, 
* type `object`, Iterating over object types is particularly tricky in TypeScript. #item60
* Avoid using any if you expect a function type
* Rest parameters are perhaps the most common use of the any[] type.
* `unknown[]` instead of any[]

### Item 45: Hide unsafe type assertions

* better approach would be to keep the type signature as it was and add an assertion in the function body
* Another way to hide a type assertion is by providing a single overload of the function
* Sometimes unsafe type assertions and any types are necessary or expedient. When you need to use one, hide it inside a function with a correct signature.
* Don’t compromise a function’s type signature to fix type errors in the implementation.
* Make sure you explain why your type assertions are valid, and unit test your code thoroughly.

### Item 46: Use unknown instead of any

* Understand the difference between {}, object, and unknown.

### Item 47: Prefer type-safe aproaches to monkey patching

* Adding properties to built-in objects at runtime is known as “monkey patching” and is particularly common with code that uses jQuery or D3

### Item 48: Avoid Soundness Traps

* any, type assertions, Object and array lookups, noUncheckedIndexedAccess, inaccurate type definitions, 
* Bivariance in class hierarchies. 
  *  Functions are covariant in their return types. Functions are contravariant in their parameter types.
* TS inaccurate model of variance for objects and arrays
* Fn calls don't invalidate refinements
* Assignability and Optional properties

### Item 49: Track your type coverage

* type-coverage npm

## Chapter 6: Generics and type-level programming

### Item50: Think of Gens as Fn between types

* Built-in `Partial<T>` equivalent to `type MyPartial<T> = {[K in keyof T]?: T[K]};`
* Built-in `PropertyKey` alias for string | number | symbol (type level equivalent of as any)
* Built-in `Pick<T,K>` equivalent to `type MyPick<T extends object, K extends keyof T> = {[P in K]: T[P]};`
  * You can write TSDoc for generic types and the TypeScript language service will surface it in relevant situations, just as it would for functions. The type-level equivalent of @param is @template:1

```ts

/**
 * Construct a new object type using a subset of the properties of another one
 * (same as the built-in `Pick` type).
 * @template T The original object type
 * @template K The keys to pick, typically a union of string literal types.
 */
type MyPick<T extends object, K extends keyof T> = {
  [P in K]: T[P]
};
```

* TypeScript types are best thought of as sets of values (#Item7), so generic types inherently operate on sets. This is quite distinct from JavaScript functions where you know that each parameter will have a single value every time the function is called. In practice this means that you always need to think about how your generic type will behave with union types. Item 53 shows you how to do this.
* Use extends to constrain the domain of type parameters, just as you’d use a type annotation to constrain a function parameter.
* Choose type parameter names that increase the legibility of your code, and write TSDoc for them.
* Think of generic functions and classes as conceptually defining generic types that are conducive to type inference.

### Item51: Avoid unnecessary type parameters

* Golden Rule of Generics”: Type Parameters Should Appear Twice. Type parameters are for relating the types of multiple values. If a type parameter is only used once in the function signature, it’s not relating anything.
  * except fn parameters assingable to each other. Use single overload. 

* Remember that a type parameter may appear in an inferred type.
* Avoid “return-only generics.”
* Unneeded type parameters can often be replaced with the unknown type.

### Item52: Prefer conditional types to overload signatures

* option is to provide multiple type declarations, also known as “overload signatures” (see Item 3 for a refresher).
* While JavaScript only allows you to write one implementation of a function, TypeScript allows you to write any number of type signatures.
* When you provide overload signatures, TypeScript processes them one by one until it finds a match. The error you’re seeing is a result of the last overload

```ts
declare function double<T extends string | number>(
  x: T
): T extends string ? string : number;
```

### Item53: Know how to control the distribution of unions over conditional types

* How can we prevent distribution? Unions only distribute over conditional types if the condition is a bare type (T extends ...). So to prevent distribution, we need to complicate the expression a bit. The standard way to do this is to wrap T in a one-element tuple type, [T]:

```ts
type Comparable<T> =
    [T] extends [Date] ? Date | number:
    [T] extends [number] ? number :
    [T] extends [string] ? string :
    never;

```

* Using an accumulator is a common technique with recursive generic types because it can improve their performance. Item 57 will explain how.

```ts
type NTuple<T, N extends number> =
    N extends number
    ? NTupleHelp<T, N, []>
    : never;
```

* Conditional types have two other surprising behaviors that you should be aware of when they distribute over the boolean and never types.

### Item54: Use Template literal types to model DSLs and relationships btw strings

* Use template literal types to model structured subsets of string types and domain-specific languages (DSLs).
* Combine template literal types with mapped and conditional types to capture nuanced relationships between types.
* Take care to avoid crossing the line into inaccurate types. Strive for uses of template literal types that improve developer experience without requiring knowledge of fancy language features.

### Item55: Write tests for your types

For code on DefinitelyTyped, use dtslint. For your own code, use vitest, expect-type, or the Type Challenges approach. If you want to test type display, use eslint-plugin-expect-type.

### Item56: Pay attention how types display

* `type Resolve<T> = T extends Function ? T : {[K in keyof T]: T[K]};`

```ts
// Good implementation, bad display
type PartiallyPartial<T, K extends keyof T> =
  Partial<Pick<T, K>> & Omit<T, K>;

// widespread trick to flatten display (also call Simplify, NOP, NOOP, MergeInsertions)
type Resolve<T> = T extends Function ? T : {[K in keyof T]: T[K]};

type PartiallyPartial<T, K extends keyof T> =
  Resolve<Partial<Pick<T, K>> & Omit<T, K>>;

// How Resolve works? Homomorphic mapped type: 
type ObjIdentity<T> = {[K in keyof T]: T[K]};
// For functions to work, we need conditional type guarding 

```

* Concise type: 

```ts
type PartiallyPartial<T extends object, K extends keyof T> =
  [K] extends [never]
  ? T  // special case
  : T extends unknown  // extra conditional to preserve distribution over unions
  ? Resolve<Partial<Pick<T, K>> & Omit<T, K>>
  : never;
```

* Common techniques that can be replace by Resolve
  * `Exclude<keyof T, never>` to inline keyof expressions
  * `unknown & T` or `{} & T` to inline object types

### Item57: Prefer Tail Recursive Generic Types

* If the last thing a function does is call itself recursively and return that value, it can give up its space on the stack: its work is done and it doesn’t need it any more. This is known as Tail Call Optimization (TCO) and functions with this form are called tail recursive.

```ts

type ToSnake<T extends string, Acc extends string = ""> =
  string extends T
  ? string  // We want ToSnake<string> = string
  : T extends `${infer First}${infer Rest}`
  ? ToSnake<
      Rest,
      First extends Uppercase<First>
      ? `${Acc}_${Lowercase<First>}`
      : `${Acc}${First}`
    >
  : Acc;

  ```

### Item58: Consider Codegen to Complex types

* For our SQL queries, one option is to use the PgTyped library. It finds appropriately-tagged SQL queries in your TypeScript, examines them against a live database, and writes out a type declaration file with the input and output types. pgtyped command would need to be rerun whenever a query changes or the database schema changes.
* Don’t like the snake_case type names? Just pipe them through sed or your text processing tool of choice.
* Items 42 and 74 explore other ways in which codegen can be used to improve type safety and reduce maintenance overhead.


## Chapter 7: Typescript Recipes

### Item59: Use never types to perform exhaustiveness checking

* Tips and tricks Stefan Baumgartner’s TypeScript Cookbook.
* omision error of switch of if case

```ts
// switch default case
function assertUnreachable(value: never): never {
  throw new Error(`Missed a case! ${value}`);
}

// switch default case
 const exhaustiveCheck: never = shape;
 throw new Error(`Missed a case: ${exhaustiveCheck}`);

 // switch default case
shape satisfies never
throw new Error(`Missed a case: ${shape}`);

```

* For switch with returns Add Function return value
* For pairs checking ``` const pair = `${a},${b}` as `${Play},${Play}`; ``` default: assertUnreachable(pair)
  * By default, `${a},${b}` would have a type of string. `${Play},${Play}` is a subtype of string consisting of the nine possible pairs of plays separated by a comma. We can apply the usual exhaustiveness checking trick to make sure we’ve covered all nine.
* The typescript-eslint rule switch-exhaustiveness-check can also be used for exhaustiveness checking. Whereas assertUnreachable is opt-in, the linter rule is opt-out

### Item60: Know how to operate over objects

```ts
for (const kStr in obj) {
  const k = kStr as keyof typeof obj;
  //    ^? const k: "one" | "two" | "three"
  const v = obj[k];  // OK
}
```
* *Object.entries* excludes inherited properties and lets you iterate over both simultaneously
  
```ts
function foo(abc: ABC) {
  for (const [k, v] of Object.entries(abc)) {
    //        ^? const k: string
    console.log(v);
    //          ^? const v: any
  }
}

```

* Another reason that TypeScript infers string in for-in loops is prototype pollution
* A safe way to get more precise types is to explicitly list the keys you’re interested in:

```ts
function foo(abc: ABC) {
  const keys = ['a', 'b', 'c'] as const;
  for (const k of keys) {
    //       ^? const k: "a" | "b" | "c"
    const v = abc[k];
    //    ^? const v: string | number
  }
}
```

* While iterating over objects comes with many hazards, iterating over a Map does not. #item16 replace object for map

### Item61: Use Record Types to keep values in sync

* Recognize the fail open versus fail closed dilemma.
* Use Record types to keep related values and types synchronized.
* The key is to use a Record type with the right set of keys. It’s important that we used an object with boolean values here:

```ts
const REQUIRES_UPDATE: Record<keyof ScatterProps, boolean> = {
  xs: true,
  ys: true,
  xRange: true,
  yRange: true,
  color: true,
  onClick: false,
};

function shouldUpdate(
  oldProps: ScatterProps,
  newProps: ScatterProps
) {
  for (const kStr in oldProps) {
    const k = kStr as keyof ScatterProps;
    if (oldProps[k] !== newProps[k] && REQUIRES_UPDATE[k]) {
      return true;
    }
  }
  return false;
}
```

### Item62: use Rest parameters and tuple types to model variadic functions

* we want the function to take a variable number of arguments, depending on an inferred type.
* This is the most general technique for modeling variadic functions. You could also use overload signatures to achieve a similar effect, but this would result in code duplication and, as Item 52 explained, conditional types handle unions more naturally than overloads.
* Sometimes the number or type of parameters to a function depends on a TypeScript type. When this happens, you can model it using rest parameters with a tuple type.

```ts
interface RouteQueryParams {
  '/': null,
  '/search': { query: string; language?: string; }
  // ...
}

function buildURL<Path extends keyof RouteQueryParams>(
  route: Path,
  ...args: (
      RouteQueryParams[Path] extends null
      ? []
      : [params: RouteQueryParams[Path]]
    )
) {
  const params = args ? args[0] : null;
  return route + (params ? `?${new URLSearchParams(params)}` : '');
}

```

### Item63: Use optional never properties to model exlusive Or

* The standard trick is to use an optional never type in your interface to disallow a property:

```ts

interface OnlyThingOne {
  shirtColor: string;
  hairColor?: never;
}
interface OnlyThingTwo {
  hairColor: string;
  shirtColor?: never;
}
type ExclusiveThing = OnlyThingOne | OnlyThingTwo;

```

* You can also use a tagged union (Item 34) to achieve an exclusive or:

```ts 
interface ThingOneTag {
  type: 'one';
  shirtColor: string;
}
interface ThingTwoTag {
  type: 'two';
  hairColor: string;
}
type Thing = ThingOneTag | ThingTwoTag;

```

* Rather than adding optional never properties by hand, it’s possible to define a generic exclusive or (XOR) helper:

```ts
type XOR<T1, T2> =
    (T1 & {[k in Exclude<keyof T2, keyof T1>]?: never}) |
    (T2 & {[k in Exclude<keyof T1, keyof T2>]?: never});
```

### Item64: Consider Brands for Nominal Typing

* This is known as nominal typing, as opposed to TypeScript’s usual structural typing. With nominal typing, a value is a Vector2D because you say it is, not because it has the right shape.
* You can’t construct an object that is a string and has a _brand property. This is purely a game with the type system. (If you think you can assign properties to a string, #Item10 will explain why you’re mistaken.)

```ts
type AbsolutePath = string & {_brand: 'abs'};

function listAbsolutePath(path: AbsolutePath) {
  // ...
}
function isAbsolutePath(path: string): path is AbsolutePath {
  return path.startsWith('/');
}

type Meters = number & {_brand: 'meters'};
type Seconds = number & {_brand: 'seconds'};

// another common technique
declare const brand: unique symbol;
export type Meters = number & {[brand]: 'meters'};

// binary search sorterd list
type SortedList<T> = T[] & {_brand: 'sorted'};

```

* Be familiar with the various techniques for branding: properties on object types, string-based enums, private fields, and unique symbols.
  
## Chapter 8: Type Declarations and @types

### Item65: Put the TS and @types in devDependencies

### Item66: Understand the three versions involved in type declarations

* version package + version of type declarations + TS version

### Item67: Export all Types that appear in public APIS

* Export types that appear in any form in any public method. Your users will be able to extract them anyway, so you may as well make it easy for them.

### Item68: Use TSDoc for API comments

```ts
**
 * Generate a greeting.
 * @param name Name of the person to greet
 * @param title The person's title
 * @returns A greeting formatted for human consumption.
 */
function greetFullTSDoc(name: string, title: string) {
  return `Hello ${title} ${name}`;
}

/** A measurement performed at a time and place. */
interface Measurement {
  /** Where was the measurement made? */
  position: Vector3D;
  /** When was the measurement made? In seconds since epoch. */
  time: number;
  /** Observed momentum */
  momentum: Vector3D;
}

```

### Item69: Provide a type for this in callbacks if its part of their API

* JavaScript’s this keyword is one of the most notoriously confusing parts of the language. Unlike variables declared with let or const, which are lexically scoped, this is dynamically scoped: its value depends not on where it appears in your code but on how you get there.
* Avoid dynamic this binding

### Item70: Mirror Types to Server Dependencies

### Item71: Use module augmentation to improve types

* TypeScript has a few historical warts of its own. One of these is the type declaration for JSON.parse, which returns any
  
```ts
// declarations/safe-json.d.ts
interface JSON {
  parse(
    text: string,
    reviver?: (this: any, key: string, value: any) => any
  ): unknown;
}

```

* Using it requires a type assertion, which is exactly what you want:
  * `const response = JSON.parse(apiResponse) as ApiResponse;`
* You can find a collection of improvements to the built-in types in the ts-reset npm package.

## Chapter 9: Writing and running your code

### Item72: Prefer ECMAscript Features to Typescript features

* ⚠️ Enums_ But enums in TypeScript have some quirks. There are actually several variants on enums that all have subtly different behaviors: number-valued, string valued, const enum. 
* ⚠️  Parameter properties:
  * They are one of the few constructs that generate code when you compile to JavaScript (enums are another). Generally, compilation just involves erasing types.
  * Because the parameter is only used in generated code, the source looks like it has unused parameters.
  * A mix of parameter and nonparameter properties can hide the design of your classes.

```ts
class Person {
  name: string;
  constructor(name: string) {
    this.name = name;
  }
}
// Equals to:
class Person {
  constructor(public name: string) {}
}
```
* Namespaces and triple-slash imports
  * before 2015: `/// <reference path="other.ts"/>`
* Experimental decorators
  * Decorators can be used to annotate or modify classes, methods, and properties. If a symbol is preceded by an @ sign, then it’s a decorator. They’re common in Angular and several other frameworks.
  ```ts
    class Greeter {
    greeting: string;
    constructor(message: string) {
    this.greeting = message;
    }
    @logged  // <-- this is the decorator
    greet() {
    return `Hello, ${this.greeting}`;
    }
    }

    function logged(originalFn: any, context: ClassMethodDecoratorContext) {
    return function(this: any, ...args: any[]) {
    console.log(`Calling ${String(context.name)}`);
    return originalFn.call(this, ...args);
    };
    }

    console.log(new Greeter('Dave').greet());
    // Logs:
    // Calling greet
    // Hello, Dave
  ```

* Member Visibility Modifiers (Private, Protected, Public)
  * ES2022 officially added support for private fields. Unlike TypeScript’s private, ECMAScript’s private is enforced both for type checking and at runtime. To use it, prefix your class property with a #: