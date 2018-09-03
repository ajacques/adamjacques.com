import VideoManifest from './VideoManifest';

const HEIGHT_OF_SKY_REGION_PX = 252;
const HEIGHT_OF_NAME_BOX = 400;
const DEFAULT_COLOR = 230;
let videoElement: HTMLVideoElement;
let nameHeader: HTMLElement;
let scrollPosElem: HTMLElement;
let lastColor = DEFAULT_COLOR;

function clamp(input: number): number {
  return Math.min(Math.max(input, 0), 1);
}

function HandleScroll() {
  const transitionFactor = clamp((window.scrollY - HEIGHT_OF_SKY_REGION_PX) / (window.outerHeight / 2 - HEIGHT_OF_NAME_BOX));

  const color = Math.floor(DEFAULT_COLOR * (1 - transitionFactor));
  scrollPosElem.innerHTML = `${transitionFactor}% ${window.scrollY} - ${color}`;
  if (lastColor === color) {
    return;
  }
  lastColor = color;
  nameHeader.style.color = `rgb(${color},${color},${color})`;
}
function LoadRandomVideo() {
  videoElement.src = VideoManifest.file;
  if (VideoManifest.text) {
    nameHeader.style.position = 'absolute';
    nameHeader.style.left = VideoManifest.text.x + '%';
  }
}
export default function() {
  videoElement = <HTMLVideoElement> document.getElementById('main-video');
  nameHeader = document.getElementsByTagName('header')[0];
  scrollPosElem = document.getElementById('scroll-pos');
  LoadRandomVideo();
  if (!VideoManifest.disableScrollEffect) {
    document.addEventListener('scroll', HandleScroll);
    HandleScroll();
  }
};
