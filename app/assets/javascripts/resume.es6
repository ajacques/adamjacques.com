(function() {
  function LoadHandler() {
    const HEIGHT_OF_SKY_REGION_PX = 252;
    const HEIGHT_OF_NAME_BOX = 400;
    const DEFAULT_COLOR = 230;
    const videoElement = document.getElementById('main-video');
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
    const vidCount = VideoManifest.length;
    const manifest = VideoManifest[Math.floor(Math.random() * vidCount * 3) % vidCount];
    function LoadRandomVideo() {
      videoElement.src = manifest.file;
      if (manifest.text) {
        nameHeader.style.position = 'absolute';
        nameHeader.style.left = manifest.text.x + '%';
      }
    }
    LoadRandomVideo();
    if (!manifest.disable_scroll_effect) {
      document.addEventListener('scroll', HandleScroll);
      HandleScroll();
    }
  }

  if (document.readyState === 'interactive') {
    window.setTimeout(LoadHandler, 200);
  } else {
    document.addEventListener('DOMContentLoaded', LoadHandler);
  }
})();
