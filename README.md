Abstract
This project explores the real-time monitoring of healthcare indicators using modern data science techniques. The dataset comprises 1,000 records of healthcare data, focusing on patient age, clinical departments, and calculated risk scores. The primary objective was to develop a centralized analytics dashboard, "VitalMetrics," to visualize the correlation between demographic factors and health outcomes. Through rigorous data filtering and the application of linear regression modeling, the system identifies trends across various medical departments to assist in resource allocation and risk mitigation. This report details the full workflow from data ingestion to interactive visualization, providing insights into the underlying patterns of clinical informatics and departmental risk distribution.

README.md
VitalMetrics: Health Analytics Dashboard
VitalMetrics is a high-performance R Shiny application designed for the interactive analysis of health records. It provides a generalized framework for clinicians and health administrators to visualize health risk factors across different age groups and departments in real-time.

🚀 Key Features
Integrated Data Ingestion: Seamlessly processes clinical data from local CSV sources and sub-directories.

Executive KPI Overview: Features reactive "Value Boxes" to display total records, average risk scores, and system status.

Dynamic Demographic Filtering: An interactive sidebar slider allows for the instantaneous filtering of the entire dataset by patient age.

Advanced Trend Visualization: Utilizes Plotly to generate interactive scatter plots that display the relationship between Age and Risk Score, color-coded by medical department.

Predictive Trendlines: Incorporates linear regression (LM) smoothing to help analysts identify and project health trajectories within the population.

🛠️ Technical Stack
Language: R

Dashboard Framework: Shiny / Shinydashboard

Visualizations: Plotly, ggplot2

Data Manipulation: Tidyverse (dplyr)

📁 Project Structure
Plaintext
VitalMetrics/
├── app.R          # Main application logic and UI code
├── data.csv       # Clinical dataset (Age, Department, Risk_Score)
└── README.md      # Technical documentation
⚙️ Setup and Installation
Requirement: Ensure R and RStudio are installed.

Install Libraries: Run the following command in your R console:

R
install.packages(c("shiny", "shinydashboard", "tidyverse", "plotly"))
Data Placement: Ensure your data.csv is in the same folder as the app.R file.

Running the App:

Open app.R in RStudio.

Go to Session > Set Working Directory > To Source File Location.

Click Run App.

📊 Analytics Modules
Global Insights: A macro-level summary of health metrics across all loaded datasets.

Risk Analysis: Focused statistical breakdown of departmental health risks to identify outliers and critical care needs.

Code Update (Sidebar Menu)
Update this section in your app.R to change the tab name from "National Overview" to "Global Insights":
