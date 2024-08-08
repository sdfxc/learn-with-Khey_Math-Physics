function toggleLanguage() {
    // Get the current language
    const currentLanguage = document.documentElement.lang;

    // Determine the new language to switch to
    const newLanguage = currentLanguage === 'en' ? 'kh' : 'en';

    // Update the lang attribute in the HTML tag
    document.documentElement.lang = newLanguage;

    // Select all elements with data-en and data-kh attributes
    const translatableElements = document.querySelectorAll('[data-en][data-kh]');

    // Loop through each element and update its text content based on the new language
    translatableElements.forEach(el => {
        el.textContent = el.getAttribute(`data-${newLanguage}`);
    });

    // Update the text on the language toggle button
    const languageToggleButton = document.getElementById('language-toggle');
    languageToggleButton.textContent = newLanguage === 'en' ? 'ភាសាខ្មែរ' : 'English';
}

function openPDF(filePath) {
    window.open(filePath, '_blank');
}
