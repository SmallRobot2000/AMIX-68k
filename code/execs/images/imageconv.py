import sys
from PIL import Image

def rgb8_to_4bit(value):
    return value >> 4

def convert_image(input_file, palette_file, image_file):
    # Open and convert image to indexed 256 colors, resize to 160x120
    img = Image.open(input_file).resize((160, 120)).convert("P", palette=Image.ADAPTIVE, colors=256)

    # Extract palette: first 256 RGB triples
    palette_8bit = img.getpalette()[:256*3]

    # Convert palette to 16-bit ARGB 4:4:4:4 format with A=0b1000
    palette_16bit = bytearray()
    for i in range(256):
        r = rgb8_to_4bit(palette_8bit[i*3])
        g = rgb8_to_4bit(palette_8bit[i*3 + 1])
        b = rgb8_to_4bit(palette_8bit[i*3 + 2])
        a = 0b1000  # Alpha always 0b1000 (8 decimal)
        color_16 = (a << 12) | (r << 8) | (g << 4) | b
        palette_16bit.append((color_16 >> 8) & 0xFF)
        palette_16bit.append(color_16 & 0xFF)

    # Save palette to file
    with open(palette_file, "wb") as f:
        f.write(palette_16bit)

    # Save indexed image pixels as raw 8bpp data
    with open(image_file, "wb") as f:
        f.write(img.tobytes())

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print(f"Usage: {sys.argv[0]} <input_image> <output_palette> <output_image>")
        sys.exit(1)

    input_file = sys.argv[1]
    palette_file = sys.argv[2]
    image_file = sys.argv[3]

    convert_image(input_file, palette_file, image_file)
    print(f"Converted {input_file} to raw 8bpp image '{image_file}' and 16-bit palette '{palette_file}'")
