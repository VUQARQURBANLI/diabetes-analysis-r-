# 🩺 Diabetes Data Analysis (EDA & Analytics)

## 📌 Project Description

This project aims to analyze and understand the key factors that are associated with diabetes. We used the Pima Indians Diabetes Dataset and conducted thorough data cleaning, transformation, exploratory data analysis (EDA), and correlation analysis to extract meaningful insights.

---

## 📁 Dataset Information

- **Name:** Pima Indians Diabetes Dataset
- **Source:** UCI Machine Learning Repository
- **Observations:** 768
- **Variables:** 9 (8 features + 1 target `Outcome`)

---

## 🧹 1. Data Cleaning Process

Some variables in the dataset had invalid zero values which were treated as missing (NA). These were:

- Glucose
- BloodPressure
- SkinThickness
- Insulin
- BMI

### Cleaning Strategy:

- Replaced zeroes with `NA`
- Filled missing values with **median** of respective columns

---

## 🔁 2. Data Transformation

To normalize skewed distributions, we applied transformations:

- `log1p()` applied to:  
  - Insulin  
  - Glucose  
  - DiabetesPedigreeFunction  
  - Pregnancies

- `sqrt()` applied to:
  - DiabetesPedigreeFunction (for comparison)

---

## 📊 3. Exploratory Data Analysis (EDA)

We grouped data by diabetes outcome (`0` = No Diabetes, `1` = Diabetes) and compared feature means:

### Key Observations:

| Feature                 | Insight |
|-------------------------|---------|
| Glucose                 | Significantly higher in diabetics |
| Pregnancies             | Slightly higher in diabetics |
| Blood Pressure          | Slight difference |
| Skin Thickness          | Slightly higher in diabetics |
| Insulin                 | Much higher in diabetics |
| BMI                     | Higher in diabetics |
| Diabetes Pedigree Func | Strong influence detected |
| Age                     | Diabetics tend to be older |

---

## 📉 4. Visual Analysis

- **Boxplots** were used to compare distributions by Outcome.
- **Density plots** showed how variable distributions differ between diabetic and non-diabetic groups.
- **Histogram** visualizations were used to assess normality and transformation effects.

---

## 🔗 5. Correlation Analysis

We used `corrplot` to examine relationships between features.

### Findings:
- Glucose, BMI, and Age showed strong correlations with diabetes.
- Most features had weak correlation with each other, suggesting multicollinearity is low.

---

## 📌 Conclusion

This analysis helped us identify the most influential features related to diabetes. If extended with Machine Learning, this cleaned and explored data can provide accurate predictions. However, this version is focused purely on analytics and EDA.

---

## 🔧 Technologies Used

- Language: **R**
- Libraries: `tidyverse`, `ggplot2`, `dplyr`, `patchwork`, `corrplot`

---

## 👨‍💻 Author

- **Name:** Vüqar
- **Role:** Data Science Learner
- **Goal:** Build real-world health data analytics projects and improve R skills

