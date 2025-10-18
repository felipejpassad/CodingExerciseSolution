# **Coding Exercise Solution**

This project was developed as part of a **programmer selection process**.
The application was built using **ASP.NET Web Forms**, with **JavaScript** primarily employed to solve the proposed exercises.

## 🚀 **Implemented Features**

The project includes two main exercises:

### **1. Convert Currency Amount to Words**

* **Page**: NumberToWords.aspx

* **Description**: Converts numeric values (in dollars) into their written representation.

* **Technologies used**:

  * **JavaScript** for the core logic

  * **jQuery** for applying the currency mask and handling variables


### **2. Palindrome Checker**

* **Page**: Palindrome.aspx

* **Description**: Checks whether the entered word is a palindrome.

* **Solutions provided:**

  I implemented two solutions: one in JavaScript, which updates the result dynamically as the user types, and another in VB.NET code-behind, which calculates the result upon a button click.

  * **1. JavaScript**:

    * Implements the verification logic directly on the frontend

    * Uses **jQuery** to prevent invalid characters and handle variables

    * Applies colors to the result (green for palindrome, red for not palindrome)

  * **2. VB.NET (Palindrome.aspx.vb)**:

    * Reverses the entered string on the server side

    * Applies colors to the result (green for palindrome, red for not palindrome)

## 🛠️ **Technologies Used**

* **ASP.NET Web Forms**

* **VB.NET**

* **JavaScript**

* **jQuery**


## 📂 **Project Structure**

```
 ProgrammersTest/

          ├── NumberToWords.aspx   # Exercise 1 - Currency to words conversion
   
          ├── Palindrome.aspx   # Exercise 2 - Palindrome checker
   
          ├── Palindrome.aspx.vb   # Exercise 2 - Alternative implementation (code-behind)
   
          └── ... # Other files
```
