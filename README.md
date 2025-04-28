# Esquisse Data Visualisation App with Colour-Blind Friendly Add-In

## Overview

This project enhances the **Esquisse Data Visualisation App** by integrating an add-in that checks for colour-blind friendly colour usage. Built as an **R Shiny app**, it provides a user-friendly interface for creating accessible data visualizations without requiring advanced technical skills.

## Features

- **Drag-and-Drop Data Visualisation**: Build charts and graphs effortlessly using Esquisse.
- **Colour-Blind Friendly Check**: Automatically validate the colour palette to ensure accessibility.
- **Customizable Charts**: Choose from a variety of chart types and styles.
- **Data Import**: Easily upload datasets in multiple formats.
- **Export Options**: Save or share your visualizations in various formats.

## Installation

To set up the app locally:

1. Clone the repository:
   ```
   git clone https://github.com/Philip-Leftwich/Esquisse-Data-Visualisation-App.git
   ```
2. Navigate into the project directory:
   ```
   cd Esquisse-Data-Visualisation-App
   ```
3. Open the project in RStudio.

4. Install the required R packages (if not already installed):
   ```R
   install.packages(c("shiny", "esquisse", "colourpicker"))
   ```

5. Run the application:
   ```R
   shiny::runApp()
   ```

## Usage

1. Launch the application by running the R script as described above.
2. Upload your dataset through the app interface.
3. Use the Esquisse drag-and-drop interface to design your visualization.
4. Enable the **Colour-Blind Friendly Check** to validate the colour palette for accessibility.
5. Save or export your visualization in your desired format.

## Contributing

Contributions are welcome! If you have ideas for improving the app or expanding its features, feel free to fork the repository, make your changes, and submit a pull request.


## Contact

For any questions or support, feel free to reach out to [Philip Leftwich](https://github.com/Philip-Leftwich).
