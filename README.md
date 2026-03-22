# 📱 SwiftUI Combine Backpressure Demo

A SwiftUI demo showcasing how to handle **backpressure** in Combine using operators like **debounce** and **throttle** to optimize API calls and prevent unnecessary network requests.

---

## 🚀 Features

* 🔍 Real-time search simulation
* ⚡ Instant API calls (no control)
* ⏳ Debounce (waits for user to stop typing)
* 🚦 Throttle (limits request frequency)
* 📊 Visual comparison of request behavior
* 🧪 Clean and simple POC for learning Combine

---

## 🧠 What is Backpressure?

Backpressure occurs when a system receives more events than it can handle efficiently.

In this demo:

* Every keystroke triggers an event
* Without control → too many API calls ❌
* With Combine → optimized flow ✅

---

## 🛠 Techniques Used

### 1. Instant (No Control)

* Triggers API call on every keystroke
* Demonstrates the problem

### 2. Debounce

* Waits for a pause in typing (e.g., 1 second)
* Only fires when user stops typing

### 3. Throttle

* Limits API calls to at most once per interval
* Ignores extra inputs within the time window

---

## 🏗 Architecture

* **SwiftUI** for UI
* **MVVM** architecture
* **Combine** for reactive data flow

```
View → ViewModel → Combine Pipeline → API Simulation
```

---

## 📸 Demo

Add your GIF here 👇

```md
![Demo](https://raw.githubusercontent.com/rakeshiosdev/swiftui-combine-backpressure/main/StreamControlEngine/Resorces/demo.gif)
```

## 📂 Project Structure

```
├── View
├── ViewModel
├── Model
├── CombinePipeline
└── Resources
```

---

## ▶️ Getting Started

1. Clone the repository

```bash
git clone https://github.com/your-username/combine-backpressure-demo.git
```

2. Open in Xcode

3. Run on simulator

---

## 💡 Key Learnings

* Difference between debounce vs throttle
* Handling high-frequency UI events
* Optimizing API calls
* Writing clean Combine pipelines

---

## 🔥 Future Improvements

* Add real API integration
* Add metrics (request count, time saved)
* Unit tests for Combine pipelines
* Logging & monitoring

---

## 🤝 Contributing

Feel free to fork and improve this project.

---

## ⭐ Support

If you found this useful, give it a ⭐ on GitHub!
