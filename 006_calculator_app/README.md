# Calculator App

A simple calculator built with **Flutter** and **Dart**.
This is my **sixth project**, but the **first one written entirely on my own** without copying code from any course or guide.
I wanted to challenge myself by creating a working, styled app from scratch — and this is the result.

---

## ✨ Features

- Basic arithmetic operations (`+`, `-`, `×`, `÷`)
- Percentage calculations (`%`)
- Decimal separator selection (`comma` or `period`)
- Toggle plus/minus (`±`)
- Input validation (prevents invalid operator sequences and division by zero)
- History display for the last calculated expression
- About dialog with app info and GitHub link
- Responsive circular buttons with color-coded types

---

## 📸 Screenshots

|                                                      Main View – preliminary layout                                                      |                                                   Main View – sample calculation                                                    |                                                         About Dialog                                                          |
| :--------------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------: |
| `<img src="/Users/tomasz/Library/Caches/Clop/images/CleanShot 2025-08-09 at 21.04.30@2x.png" alt="Main View – preliminary" width="300">` | `<img src="/Users/tomasz/Library/Caches/Clop/images/CleanShot 2025-08-09 at 21.08.55@2x.png" alt="Main View – sample" width="300">` | `<img src="/Users/tomasz/Library/Caches/Clop/images/CleanShot 2025-08-09 at 21.14.24@2x.png" alt="About Dialog" width="300">` |

### Proving the correctness of the calculations submitted

Expression:

$$
100 \div 4 + 5 \times 15 \% 4 - 7 \times 2
$$

1. **Division first**:

$$
100 \div 4 = 25
$$

$$
25 + 5 \times 15 \% 4 - 7 \times 2
$$

2. **Modulo next** (`%` means remainder):

$$
15 \% 4 = 3
$$

$$
25 + 5 \times 3 - 7 \times 2
$$

3. **Multiplication** (left to right):
   First: $5 \times 3 = 15$
   Then: $7 \times 2 = 14$

$$
25 + 15 - 14
$$

4. **Addition/Subtraction** (left to right):

$$
25 + 15 = 40
$$

$$
40 - 14 = 26
$$

#### ✅ **Final answer**: **26**

---

## 🛠️ Tech Stack

- **Flutter** (UI framework)
- **Dart** (programming language)
- [`math_expressions`](https://pub.dev/packages/math_expressions) – for parsing and evaluating math expressions
- [`fluttertoast`](https://pub.dev/packages/fluttertoast) – for error messages
- [`url_launcher`](https://pub.dev/packages/url_launcher) – for opening GitHub link

---

## 📂 Project Structure

```

lib/

├── data/

│   └── buttons_data.dart       # Button definitions

├── models/

│   └── button.dart             # Button model

├── buttons.dart                # Buttons widget

├── calc_page.dart              # Main calculator page with logic

├── calc_text_field.dart        # Text field widget for display

└── main.dart                   # App entry point

```

---

## 🚀 My Learning Goals for This Project

- Build an app entirely without following a tutorial
- Practice splitting code into multiple files and widgets
- Learn to manage user input and validation
- Handle basic app state with `StatefulWidget`
- Use packages from pub.dev for extended functionality

---

## 📜 License

This project is open-source. You are free to use, modify, and share it.
