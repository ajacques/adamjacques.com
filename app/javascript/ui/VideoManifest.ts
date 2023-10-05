const Videos = require('./Videos.json');

interface TextLocation {
  x: number,
  y: number
}

interface ManifestSpec {
  file: string,
  text?: TextLocation,
  disableScrollEffect?: boolean,
  description: string
}

const VideoManifest: ManifestSpec[] = Videos as ManifestSpec[];

const context = require.context("../../assets/videos");

for (const manifest of VideoManifest) {
  manifest.file = context(`./${manifest.file}`).default;
}

const vidCount = VideoManifest.length;
const manifest = VideoManifest[Math.floor(Math.random() * 10 % vidCount)];

export default manifest;
