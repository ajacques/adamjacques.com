interface TextLocation {
  x: number,
  y: number
}

interface ManifestSpec {
  file: string,
  text?: TextLocation,
  disableScrollEffect?: boolean
}

const VideoManifest: ManifestSpec[] = [
  { file: '/assets/beach-38f0fbd021469badf84c46f8f7a9686b1a1a7ade0f4f9d02a34f762957818f14.mp4' },
  { file: '/assets/video-748f731b432488d4b3f62f408107db51e86f001104faf024051c6d15ba92fae0.mp4' },
  { file: '/assets/snoqualmie_falls-4e1ae1831b5f652b1b57161bc1140e74b93c1d984bc2888974fd2f3b79552de3.mp4', text: { x: 10, y: 70 }, disableScrollEffect: true }
];

const vidCount = VideoManifest.length;
const manifest = VideoManifest[Math.floor(Math.random() * vidCount * 3) % vidCount];

export default manifest;
