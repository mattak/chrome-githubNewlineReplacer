// クリックハンドラーを削除し、ショートカットハンドラーに変更
chrome.commands.onCommand.addListener((command) => {
  if (command === 'convert-newlines') {
    chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
      const tab = tabs[0];
      if (!tab.id) return;

      chrome.scripting.executeScript({
        target: { tabId: tab.id },
        func: convertNewlines,
      });
    });
  }
});

function convertNewlines() {
  const textareas = document.querySelectorAll<HTMLTextAreaElement>("span textarea");
  
  textareas.forEach(textarea => {
    const currentValue = textarea.value;
    const newValue = currentValue.replace(/\\n/g, '\n');
    
    if (currentValue !== newValue) {
      textarea.value = newValue;
      
      // テキストエリアの変更イベントを発火させる
      const event = new Event('input', { bubbles: true });
      textarea.dispatchEvent(event);
    }
  });
} 