(function() {
  function LoadHandler() {
    const HEIGHT_OF_SKY_REGION_PX = 252;
    const HEIGHT_OF_NAME_BOX = 400;
    const DEFAULT_COLOR = 230;
    const nameHeader = document.getElementsByTagName('header')[0];
    let lastColor = DEFAULT_COLOR;
    function HandleScroll() {
      const transitionFactor = Math.min(Math.max((window.scrollY - HEIGHT_OF_SKY_REGION_PX) / (window.innerHeight / 2 - HEIGHT_OF_NAME_BOX), 0), 1);

      const color = Math.floor(DEFAULT_COLOR * (1 - transitionFactor));
      if (lastColor === color) {
        return;
      }
      lastColor = color;
      nameHeader.style.color = `rgb(${color},${color},${color})`;
    }
    document.addEventListener('scroll', HandleScroll);
    HandleScroll();
  }

  if (document.readyState === 'interactive') {
    LoadHandler();
  } else {
    document.addEventListener('DOMContentLoaded', LoadHandler);
  }
})();
