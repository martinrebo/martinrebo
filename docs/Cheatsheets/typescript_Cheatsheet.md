
# 🧠 TypeScript Cheatsheet 🇹🇷

> The essential guide for JavaScript devs upgrading to TypeScript 🚀

---

## 📦 Basic Types

```ts
let isDone: boolean = false;
let age: number = 40;
let username: string = "Martin";
let notSure: any = 4;

let list: number[] = [1, 2, 3];
let tuple: [string, number] = ["hello", 42];

enum Color {
  Red,
  Green,
  Blue,
}
let c: Color = Color.Green;
```

---

## 🎯 Type Inference

```ts
let name = "Alice";  // inferred as string
let count = 5;       // inferred as number
```

---

## ✅ Functions

```ts
function add(a: number, b: number): number {
  return a + b;
}

const greet = (name: string = "Guest"): string => {
  return `Hello, ${name}!`;
}
```

---

## 🧱 Interfaces vs. Types

```ts
interface User {
  name: string;
  age: number;
  isAdmin?: boolean; // optional
}

type Product = {
  id: number;
  title: string;
};
```

🔁 **Extending**:

```ts
interface Admin extends User {
  permissions: string[];
}

type Extended = User & { role: string };
```

---

## 📚 Type Aliases & Unions

```ts
type ID = string | number;
let userId: ID = 101;

type Status = "loading" | "success" | "error";
```

---

## 🔄 Type Narrowing

```ts
function printId(id: string | number) {
  if (typeof id === "string") {
    console.log(id.toUpperCase());
  } else {
    console.log(id.toFixed(2));
  }
}
```

---

## 🧪 Type Assertions

```ts
let someValue: any = "hello world";
let strLength: number = (someValue as string).length;
```

---

## 🧰 Generics

```ts
function identity<T>(arg: T): T {
  return arg;
}

const result = identity<string>("Hello");
```

---

## 📦 Classes

```ts
class Animal {
  constructor(public name: string) {}
  move(distance: number) {
    console.log(`${this.name} moved ${distance}m.`);
  }
}

class Dog extends Animal {
  bark() {
    console.log("Woof! 🐶");
  }
}

const rex = new Dog("Rex");
rex.bark();
rex.move(10);
```

---

## 🔒 Access Modifiers

* `public` – accessible anywhere
* `private` – accessible only in the class
* `protected` – accessible in class and subclasses
* `readonly` – cannot be modified after declaration

```ts
class Person {
  private ssn: string;
  readonly id: number;

  constructor(id: number, ssn: string) {
    this.id = id;
    this.ssn = ssn;
  }
}
```

---

## ⚙️ Utility Types

```ts
type Partial<T> = { [P in keyof T]?: T[P] };
type Required<T> = { [P in keyof T]-?: T[P] };
type Readonly<T> = { readonly [P in keyof T]: T[P] };

type User = { id: number; name: string };
type ReadonlyUser = Readonly<User>;
```

---

## 🚦 Type Guards

```ts
function isString(val: any): val is string {
  return typeof val === "string";
}

function doSomething(x: string | number) {
  if (isString(x)) {
    console.log(x.toUpperCase());
  }
}
```

---

## 🧠 Advanced Tips

* Use `never` for impossible cases
* Use `unknown` instead of `any` for safety
* Prefer interfaces for object shapes
* Use `keyof` and `typeof` for type reflection

---

## 🛠️ Tooling & Resources

* 🧰 **TS Playground**: [https://www.typescriptlang.org/play](https://www.typescriptlang.org/play)
* 📘 **Docs**: [https://www.typescriptlang.org/docs](https://www.typescriptlang.org/docs)
* 🧪 **tsconfig Reference**: [https://www.typescriptlang.org/tsconfig](https://www.typescriptlang.org/tsconfig)
* 🔍 **Types Search**: [https://www.npmjs.com/search?q=types](https://www.npmjs.com/search?q=types)

---

## 🧵 tsconfig.json (Minimal Setup)

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true
  }
}
```

---

## ⛑️ Error Handling Example

```ts
function safeParse(json: string): unknown {
  try {
    return JSON.parse(json);
  } catch {
    return null;
  }
}
```

---

## 📌 Common Pitfalls

| Mistake                  | Fix                                   |
| ------------------------ | ------------------------------------- |
| Overusing `any`          | Use `unknown` or proper type guards   |
| Forgetting `strict` mode | Always enable `strict: true`          |
| Ignoring `never` return  | Use for exhaustive checks             |
| Skipping types in props  | Use interfaces or `React.FC` in React |

---

## 🧩 With React (Optional)

```tsx
type Props = {
  title: string;
  onClick: () => void;
};

const Button: React.FC<Props> = ({ title, onClick }) => (
  <button onClick={onClick}>{title}</button>
);
```

---

👨‍💻 Happy Hacking with TypeScript!

*TypeScript: JavaScript that scales.* ⚡

---
