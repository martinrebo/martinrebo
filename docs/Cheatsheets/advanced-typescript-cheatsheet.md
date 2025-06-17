# ⚡ Advanced TypeScript Cheatsheet

This cheatsheet covers powerful TypeScript features used in large-scale applications and advanced scenarios.

---

## 📦 Utility Types

| Utility Type            | Description                                         | Example                                 |
|-------------------------|-----------------------------------------------------|-----------------------------------------|
| `Partial<T>`            | Makes all properties in `T` optional                | `Partial<{ a: string }>` → `{ a?: string }` |
| `Required<T>`           | Makes all properties in `T` required                | `Required<{ a?: string }>` → `{ a: string }` |
| `Readonly<T>`           | All properties are readonly                         | `Readonly<{ a: string }>`               |
| `Record<K, T>`          | Constructs object type with keys `K` and values `T` | `Record<'a' | 'b', number>` → `{ a: number, b: number }` |
| `Pick<T, K>`            | Picks set of properties `K` from type `T`           | `Pick<{ a: string; b: number }, 'a'>` → `{ a: string }` |
| `Omit<T, K>`            | Removes properties `K` from `T`                     | `Omit<{ a: string; b: number }, 'a'>` → `{ b: number }` |
| `Exclude<T, U>`         | Excludes from `T` types assignable to `U`           | `Exclude<'a' | 'b', 'a'>` → `'b'`        |
| `Extract<T, U>`         | Extracts from `T` types assignable to `U`           | `Extract<'a' | 'b', 'a' | 'c'>` → `'a'` |
| `NonNullable<T>`        | Excludes `null` and `undefined` from `T`            | `NonNullable<string | null>` → `string` |
| `Parameters<T>`         | Tuple of function parameters                        | `Parameters<(a: number, b: string) => void>` → `[number, string]` |
| `ReturnType<T>`         | Return type of a function                           | `ReturnType<() => string>` → `string`   |
| `ConstructorParameters<T>` | Tuple of constructor params                    | `ConstructorParameters<typeof Date>`    |
| `InstanceType<T>`       | Instance type of a constructor                      | `InstanceType<typeof Date>` → `Date`    |
| `Awaited<T>`            | Unwraps `Promise<T>` or nested promises             | `Awaited<Promise<Promise<string>>>` → `string` |

---

## 🧠 Advanced Types

### 🔁 Mapped Types

```ts
type OptionsFlags<T> = {
  [K in keyof T]: boolean;
};

type Features = {
  darkMode: () => void;
  newUserProfile: () => void;
};

type FeatureFlags = OptionsFlags<Features>;
// => { darkMode: boolean; newUserProfile: boolean }
```

### 🔍 Conditional Types

```ts
type IsString<T> = T extends string ? true : false;

type A = IsString<'hello'>;  // true
type B = IsString<42>;       // false
```

### 🧪 Inference with `infer`

```ts
type ElementType<T> = T extends (infer U)[] ? U : T;

type A = ElementType<string[]>; // string
type B = ElementType<number>;   // number
```

---

## 🧱 Template Literal Types

```ts
type EventType = 'click' | 'hover';
type PrefixedEvent = `on${Capitalize<EventType>}`;
// => "onClick" | "onHover"
```

---

## 🔐 Type Guards

```ts
function isString(value: unknown): value is string {
  return typeof value === 'string';
}

function example(x: unknown) {
  if (isString(x)) {
    x.toUpperCase(); // safe
  }
}
```

---

## 🧵 Discriminated Unions

```ts
type Shape = 
  | { kind: 'circle'; radius: number }
  | { kind: 'square'; side: number };

function area(shape: Shape): number {
  switch (shape.kind) {
    case 'circle': return Math.PI * shape.radius ** 2;
    case 'square': return shape.side ** 2;
  }
}
```

---

## 🧰 Advanced Function Types

### Variadic Tuple

```ts
type AppendArg<Fn, Arg> = Fn extends (...args: infer A) => infer R
  ? (...args: [...A, Arg]) => R
  : never;

type Fn = (a: number, b: string) => boolean;
type NewFn = AppendArg<Fn, Date>; 
// (a: number, b: string, c: Date) => boolean
```

---

## 🧾 Declaration Merging

```ts
interface User {
  name: string;
}

interface User {
  age: number;
}

// Merged: { name: string; age: number }
```

---

## 🧨 Module Augmentation

```ts
// my-lib.d.ts
declare module 'my-lib' {
  interface Config {
    debug: boolean;
  }
}
```

---

## 🧱 Index Signatures & Key Remapping

```ts
type Flags = {
  [key: string]: boolean;
};

type EventNames<T> = {
  [K in keyof T as `on${Capitalize<string & K>}`]: () => void;
};

type UserEvents = EventNames<{ click: any; hover: any }>;
// => { onClick: () => void; onHover: () => void }
```

---

## 🧪 Intrinsic String Manipulation Types

| Type             | Description                |
|------------------|----------------------------|
| `Uppercase<T>`   | Uppercases a string literal |
| `Lowercase<T>`   | Lowercases a string literal |
| `Capitalize<T>`  | Capitalizes first letter   |
| `Uncapitalize<T>`| Uncapitalizes first letter |

---

## 🚀 Misc Tips

- Use `as const` to create literal types:

```ts
const roles = ['admin', 'user', 'guest'] as const;
type Role = typeof roles[number]; // "admin" | "user" | "guest"
```

- Use `satisfies` for better inference:

```ts
const config = {
  port: 3000,
  debug: true,
} satisfies { port: number; debug: boolean };
```

- Prevent type widening with `as const`:

```ts
const direction = 'left' as const; // type is "left", not string
```

---

🧠 **Pro Tip**: Use `.d.ts` files and `declare` statements to type 3rd-party or legacy JavaScript libraries for better DX and safety.

---
