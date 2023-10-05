import VideoManifest from './VideoManifest';

const HEIGHT_OF_SKY_REGION_PX = 252;
const HEIGHT_OF_NAME_BOX = 400;
const DEFAULT_COLOR = 230;
let videoElement: HTMLVideoElement;
let nameHeader: HTMLElement;
let lastColor = DEFAULT_COLOR;

function clamp(input: number): number {
  return Math.min(Math.max(input, 0), 1);
}

function HandleScroll(): void {
  const transitionFactor = clamp((window.scrollY - HEIGHT_OF_SKY_REGION_PX) / (window.outerHeight / 2 - HEIGHT_OF_NAME_BOX));

  const color = Math.floor(DEFAULT_COLOR * (1 - transitionFactor));
  if (lastColor === color) {
    return;
  }
  lastColor = color;
  nameHeader.style.color = `rgb(${color},${color},${color})`;
}

function LoadRandomVideo(): void {
  videoElement.src = VideoManifest.file;
  videoElement.setAttribute('aria-label', 'A cinemgraph background video');
  videoElement.setAttribute('aria-description', VideoManifest.description);
  if (VideoManifest.text) {
    nameHeader.style.position = 'absolute';
    nameHeader.style.left = VideoManifest.text.x + '%';
  }
}

export default function(): void {
  videoElement = document.getElementById('main-video') as HTMLVideoElement;
  nameHeader = document.getElementsByTagName('header')[0] as HTMLElement;
  LoadRandomVideo();
  if (!VideoManifest.disableScrollEffect) {
    document.addEventListener('scroll', HandleScroll);
    HandleScroll();
  }
};
