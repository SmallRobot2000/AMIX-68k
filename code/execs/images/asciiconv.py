import sys
import argparse
from PIL import Image

# ASCII characters arranged by brightness from dark to light
ASCII_CHARS = "@%#*+=-:. "

# IBM 16-color palette RGB values (approximate)
IBM_COLORS = [
    (0, 0, 0),       # 0 - Black
    (0, 0, 128),     # 1 - Blue
    (0, 128, 0),     # 2 - Green
    (0, 128, 128),   # 3 - Cyan
    (128, 0, 0),     # 4 - Red
    (128, 0, 128),   # 5 - Magenta
    (128, 128, 0),   # 6 - Brown/Yellow
    (192, 192, 192), # 7 - Light gray
    (128, 128, 128), # 8 - Dark gray
    (0, 0, 255),     # 9 - Light Blue
    (0, 255, 0),     # 10 - Light Green
    (0, 255, 255),   # 11 - Light Cyan
    (255, 0, 0),     # 12 - Light Red
    (255, 0, 255),   # 13 - Light Magenta
    (255, 255, 0),   # 14 - Yellow
    (255, 255, 255), # 15 - White
]

def resize_image(image, new_width=80, new_height=32):
    return image.resize((new_width, new_height))

def grayscale(image):
    return image.convert("L")

def rgb_to_ansi_idx(r, g, b):
    # Find nearest IBM palette color index by Euclidean distance in RGB space
    min_dist = float('inf')
    best_idx = 0
    for i, (cr, cg, cb) in enumerate(IBM_COLORS):
        dist = (r - cr)**2 + (g - cg)**2 + (b - cb)**2
        if dist < min_dist:
            min_dist = dist
            best_idx = i
    return best_idx

def pixels_to_ascii_with_color(image_gray, image_color):
    width, height = image_gray.size
    gray_pixels = list(image_gray.getdata())
    color_pixels = list(image_color.getdata())

    ascii_chars = []
    for i in range(width * height):
        pixel_val = gray_pixels[i]
        char = ASCII_CHARS[pixel_val * len(ASCII_CHARS) // 256]

        r, g, b = color_pixels[i]
        fg = rgb_to_ansi_idx(r, g, b)  # foreground color from pixel
        bg = 0  # black background as default
        color_byte = (bg << 4) | fg

        ascii_chars.append(bytes([color_byte]) + char.encode('ascii'))

    return b"".join(ascii_chars)

def convert_to_ascii_with_color(image_path, width=80, height=32):
    try:
        image = Image.open(image_path)
    except Exception as e:
        print(f"Unable to open image file {image_path}.")
        print(e)
        return None

    image = resize_image(image, width, height)
    image_gray = grayscale(image)

    ascii_bytes = pixels_to_ascii_with_color(image_gray, image)
    return ascii_bytes

def main():
    parser = argparse.ArgumentParser(description="Convert an image to colored ASCII art at 80x32 size with color bytes before ASCII characters.")
    parser.add_argument("file", help="Path to the image file to convert")
    parser.add_argument("-o", "--output", help="Output binary file to save ASCII art with color bytes", default=None)
    
    args = parser.parse_args()

    ascii_art_bytes = convert_to_ascii_with_color(args.file, 80, 32)
    if ascii_art_bytes:
        if args.output:
            with open(args.output, "wb") as f:
                f.write(ascii_art_bytes)
            print(f"Colored ASCII art written to {args.output}")
        else:
            # Print raw bytes might not be readable, so we print hex for demonstration
            print(ascii_art_bytes.hex())

if __name__ == "__main__":
    main()
