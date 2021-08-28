const Videos = require('json-loader!./Videos.json');

interface TextLocation {
  x: number,
  y: number
}

interface ManifestSpec {
  file: string,
  text?: TextLocation,
  disableScrollEffect?: boolean
}

const VideoManifest: ManifestSpec[] = Videos as ManifestSpec[];

const vidCount = VideoManifest.length;
const manifest = VideoManifest[Math.floor(Math.random() * vidCount * 3) % vidCount];

export default manifest;
