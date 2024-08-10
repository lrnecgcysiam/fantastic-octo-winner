const fs = require('fs');
const path = require('path');
const cheerio = require('cheerio');

// Get the input folder from command-line arguments
const inputFolder = process.argv[2];

if (!inputFolder) {
    console.error('Please provide the input folder as an argument.');
    process.exit(1);
}

// Get all HTML files in the input folder
const htmlFiles = fs.readdirSync(inputFolder).filter(file => file.endsWith('.html'));

htmlFiles.forEach(htmlFile => {
    const filePath = path.join(inputFolder, htmlFile);
    const outputFilePath = path.join(inputFolder, `${path.basename(htmlFile, '.html')}_thumb_items.html`);

    // Read the HTML file content
    const htmlContent = fs.readFileSync(filePath, 'utf8');

    // Load the HTML content into cheerio
    const $ = cheerio.load(htmlContent);

    // Extract all divs with class="thumb-list__item video-thumb video-thumb--type-video"
    const thumbItems = $('div.thumb-list__item.video-thumb.video-thumb--type-video').toArray().map(el => $.html(el)).join('\n');

    if (thumbItems) {
        // Save the extracted content to a new file
        fs.writeFileSync(outputFilePath, thumbItems, 'utf8');
        console.log(`Created: ${outputFilePath}`);
    } else {
        console.log(`No div with class="thumb-list__item video-thumb video-thumb--type-video" found in: ${htmlFile}`);
    }
});

console.log("All thumb items files created.");