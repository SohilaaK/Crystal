# Image Search Engine using Unsplash API in Crystal Language

This is an Image Search Engine application built using the Unsplash API and Crystal Language. It allows users to search for images on any topic and displays the resulting images.

# Features

- **Search for Images:** Users can search for images based on any topic.
- **Display Results:** The search results display a set of images related to the search query.
- **User-Friendly:** Simple and intuitive command-line interface.

# Prerequisites

- Crystal Language installed on your machine. You can follow the installation instructions from the [official Crystal website](https://crystal-lang.org/install/).
- Unsplash API access key. Sign up and get your access key from the [Unsplash Developers page](https://unsplash.com/developers).

# Installation

1. Clone the Repository:
   ```sh
   git clone https://github.com/yourusername/image-search-engine.git
   cd image-search-engine
2. Install Dependencies:
This project uses HTTP::Client for making API requests and JSON for parsing responses, which are part of the standard library of Crystal, so no additional dependencies are required.

3. Setup Environment Variables:
Create a .env file in the root directory of the project and add your Unsplash API key:
UNSPLASH_ACCESS_KEY=your_access_key_here

# How to Run
Compile the Program:
1. crystal build src/image_search_engine.cr
2. Run the Program:
./image_search_engine
Search for Images:
Enter a topic you want to search for when prompted. The program will fetch and display images related to the topic from Unsplash.

# Code Overview
Here's a brief overview of the main parts of the code:

# Explanation
1. Environment Variables: The dotenv library loads the Unsplash API key from the .env file.
2. HTTP Client: Uses HTTP::Client to make GET requests to the Unsplash API.
3. JSON Parsing: The JSON module parses the JSON response from the API.
4. Image URLs: Extracts and displays the URLs of the images from the JSON response.

# Additional Notes
1. Ensure your API key is kept secret and not shared publicly.
2. This is a basic implementation, and additional error handling and features can be added as needed.
# Contributing
Feel free to fork the repository and submit pull requests. For major changes, please open an issue first to discuss what you would like to change.

# License
This project is licensed under the SAA License.
