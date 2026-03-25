import sharp from 'sharp'
import { mkdirSync } from 'fs'

mkdirSync('./public/icons', { recursive: true })

const sizes = [72, 96, 128, 144, 152, 192, 384, 512]
const svg = Buffer.from(`
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
  <rect width="512" height="512" rx="80" fill="#C0151A"/>
  <text x="256" y="320" font-size="280" font-family="Arial,sans-serif"
    font-weight="bold" text-anchor="middle" fill="white">SM</text>
</svg>`)

for (const size of sizes) {
  await sharp(svg)
    .resize(size, size)
    .png()
    .toFile(`./public/icons/icon-${size}x${size}.png`)
  console.log(`✓ icon-${size}x${size}.png`)
}
