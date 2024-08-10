const fs = require('fs');
const path = require('path');
const cheerio = require('cheerio');

// Folder containing the downloaded HTML files
const inputFolder = 'eagle_japan_videos';

// Get all HTML files in the input folder
const htmlFiles = fs.readdirSync(inputFolder).filter(file => file.endsWith('.html'));

htmlFiles.forEach(htmlFile => {
    const filePath = path.join(inputFolder, htmlFile);
    const outputFilePath = path.join(inputFolder, `${path.basename(htmlFile, '.html')}_video_list.html`);

    // Read the HTML file content
    const htmlContent = fs.readFileSync(filePath, 'utf8');

    // Load the HTML content into cheerio
    const $ = cheerio.load(htmlContent);

    // Extract the div with id="video_list"
    const videoListDiv = $('#video_list').html();

    if (videoListDiv) {
        // Save the extracted content to a new file
        fs.writeFileSync(outputFilePath, videoListDiv, 'utf8');
        console.log(`Created: ${outputFilePath}`);
    } else {
        console.log(`No div with id="video_list" found in: ${htmlFile}`);
    }
});

console.log("All video list files created.");