
# 🎮 Unity Cheat Sheet

**Unity Cheat Sheet** — a quick reference guide packed with essential tips, shortcuts, and best practices for developers, artists, and designers working with the Unity game engine.

---

## 🧰 General Editor Shortcuts

| Action              | Shortcut (Windows)                               | Shortcut (Mac)                                |
| ------------------- | ------------------------------------------------ | --------------------------------------------- |
| Move Tool           | `W`                                              | `W`                                           |
| Rotate Tool         | `E`                                              | `E`                                           |
| Scale Tool          | `R`                                              | `R`                                           |
| Rect Tool           | `T`                                              | `T`                                           |
| Play / Pause / Step | `Ctrl + P`, `Ctrl + Shift + P`, `Ctrl + Alt + P` | `Cmd + P`, `Cmd + Shift + P`, `Cmd + Alt + P` |
| Focus on Object     | `F`                                              | `F`                                           |
| Duplicate           | `Ctrl + D`                                       | `Cmd + D`                                     |
| Undo / Redo         | `Ctrl + Z / Y`                                   | `Cmd + Z / Shift + Cmd + Z`                   |

---

## 📦 Project Structure Tips

* ✅ Keep scripts in `/Scripts/`, assets in `/Assets/`, scenes in `/Scenes/`.
* ✅ Use `/Prefabs/` for reusable GameObjects.
* ✅ Follow **PascalCase** for class names and **camelCase** for variables.

---

## 🔧 Scripting Essentials (C#)

### Common Methods

```csharp
void Start() {
    // Called before the first frame update
}

void Update() {
    // Called once per frame
}

void FixedUpdate() {
    // Called at fixed intervals (use for physics)
}

void OnTriggerEnter(Collider other) {
    // Trigger detection
}
```

### Access Components

```csharp
Rigidbody rb = GetComponent<Rigidbody>();
rb.AddForce(Vector3.up * 5f);
```

### Instantiate Prefabs

```csharp
Instantiate(myPrefab, transform.position, Quaternion.identity);
```

### Basic Coroutine

```csharp
IEnumerator WaitAndPrint() {
    yield return new WaitForSeconds(2f);
    Debug.Log("Waited 2 seconds");
}
```

---

## 🎨 UI Quick Tips

* Use `Canvas > Panel > Buttons` for UI structure.
* Always anchor UI elements properly for responsiveness.
* Use `TextMeshPro` instead of default `Text` for crisp text.
* Add `Canvas Scaler` and set to `Scale with Screen Size`.

---

## 🧠 Best Practices

* ✅ Use `Time.deltaTime` for frame-rate independent movement:

  ```csharp
  transform.Translate(Vector3.forward * speed * Time.deltaTime);
  ```

* ✅ Use prefabs for everything reusable.

* ✅ Always check for `null` before accessing components.

* ✅ Comment and organize your code with regions:

  ```csharp
  #region Movement
  // Movement code
  #endregion
  ```

---

## ⚙️ Performance Tips

* ❗ Avoid using `GameObject.Find()` in `Update()`.
* ✅ Cache component references in `Start()` or `Awake()`.
* ❗ Use `Object Pooling` for frequent spawning.
* ✅ Use `Static` for non-moving environment objects.
* ❗ Avoid allocating memory (e.g., `new`) inside `Update()`.

---

## 🧪 Debugging Tips

* Use `Debug.Log()`, `Debug.DrawRay()`, or breakpoints.
* Use `Inspector` to tweak variables in real-time.
* Enable **Gizmos** to visualize object behavior in Scene view.

---

## 🔗 Useful Unity Resources

* [Unity Documentation 📚](https://docs.unity3d.com/)
* [Unity Learn 🧠](https://learn.unity.com/)
* [Brackeys YouTube Channel 🎥](https://www.youtube.com/user/Brackeys)
* [Unity Asset Store 🛒](https://assetstore.unity.com/)
* [Unity Forum 🗣️](https://forum.unity.com/)

---