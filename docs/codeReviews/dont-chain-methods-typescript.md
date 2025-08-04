# ❌ Don’t Chain Method Calls in TypeScript (and What to Do Instead)

In *The Pragmatic Programmer*, there's an important warning:

> ❗ “Don’t chain method calls.”

Let's explore what that means — in the context of **TypeScript**.

---

## 🧨 Problematic Example in TypeScript

```ts
// 🚫 Bad: Method chaining across multiple objects
const amount = customer.getOrders().getLast().getTotals().amount;
```

This is problematic because:

- It **violates the Law of Demeter**
- It creates **tight coupling** between the calling code and internal structure
- It is **fragile**: any method returning `null`, `undefined`, or throwing an error will break the chain
- It’s **hard to test**, **hard to debug**

---

## 🛠️ Better Approach: Encapsulation

```ts
// ✅ Good: Add a method that encapsulates the logic
class Customer {
  getTotalDue(): number {
    const lastOrder = this.orders.at(-1);
    if (!lastOrder) return 0;
    const totals = lastOrder.getTotals();
    return totals?.amount ?? 0;
  }

  constructor(private orders: Order[]) {}
}
```

### Usage:

```ts
const amount = customer.getTotalDue();
```

Now:
- The **consumer code is simple and clean**
- The internal structure of `Customer` and `Order` is **hidden**
- Easier to **change internals** later

---

## 🔍 Law of Demeter (Revisited)

> "Only talk to your immediate friends."

In TypeScript, that means:
- Don't reach into `.a().b().c()`
- Instead, ask the object directly for what you want

---

## 🧠 Summary

| ❌ Bad (chaining)                            | ✅ Good (encapsulated)             |
|---------------------------------------------|-----------------------------------|
| `a.b().c().d`                                | `a.getValue()`                    |
| Fragile — breaks when internals change       | Robust — internals are hidden     |
| Exposes structure of objects                 | Keeps responsibility in one place |
| Hard to test and mock                        | Easy to mock at interface level   |

---

## 📚 Further Reading

- *The Pragmatic Programmer* by Andy Hunt & Dave Thomas
- [Law of Demeter - Wikipedia](https://en.wikipedia.org/wiki/Law_of_Demeter)

---

> ✨ Always encapsulate object navigation inside your class logic — not the calling code!
