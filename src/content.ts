function replaceNewlines() {
    const elements = document.querySelectorAll<HTMLTextAreaElement>('textarea')
    const regex = /\\n/;
    const regexReplace = /\\n/g;
    const containsElement = Array.of(...elements).filter(x => x.value.match(regex));
    containsElement.forEach((x) => {
      const source = x.value;
      const result = source.replace(regexReplace, '\n');
      x.value = result;
    });
}
  
document.onkeydown = function(e: any) {
    // Alt + Shift + Meta + N
    if(e.altKey && e.shiftKey && e.metaKey && e.keyCode == 78) {
        replaceNewlines();
    }
}
  