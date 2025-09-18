import argparse
from moviepy.editor import VideoFileClip
from PIL import Image
import numpy as np

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

# IBM CP437 characters for shading from dark to light
IBM_CHAR_BYTES = [0xDB, 0xB2, 0xB1, 0xB0, ord('.'), ord(' ')]

WIDTH = 80
HEIGHT = 32
FPS = 6

def rgb_to_ansi_idx(r, g, b):
    min_dist = float('inf')
    best_idx = 0
    for i, (cr, cg, cb) in enumerate(IBM_COLORS):
        dist = (r - cr) ** 2 + (g - cg) ** 2 + (b - cb) ** 2
        if dist < min_dist:
            min_dist = dist
            best_idx = i
    return best_idx

def convert_frame_to_ascii_bytes(frame):
    image = Image.fromarray(frame)
    image = image.resize((WIDTH, HEIGHT))
    image_gray = image.convert("L")

    gray_pixels = list(image_gray.getdata())
    color_pixels = list(image.getdata())

    char_len = len(IBM_CHAR_BYTES)
    ascii_bytes = bytearray()
    for i in range(WIDTH * HEIGHT):
        pixel_val = gray_pixels[i]
        idx = pixel_val * char_len // 256
        if idx == char_len:
            idx -= 1
        char_byte = IBM_CHAR_BYTES[idx]

        r, g, b = color_pixels[i]
        fg = rgb_to_ansi_idx(r, g, b)
        bg = 0  # black background fixed
        color_byte = (bg << 4) | fg

        ascii_bytes.append(color_byte)
        ascii_bytes.append(char_byte)

    return bytes(ascii_bytes)

def video_to_ascii_file(input_path, output_path):
    clip = VideoFileClip(input_path).subclip()
    total_frames = int(clip.duration * FPS)

    with open(output_path, "wb") as f:
        for frame_num in range(total_frames):
            t = frame_num / FPS
            frame = clip.get_frame(t)
            frame_bytes = convert_frame_to_ascii_bytes(frame)
            f.write(frame_bytes)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert video to a large file of colored ASCII frames at 80x32 resolution and 6 FPS.")
    parser.add_argument("input", help="Input video file path")
    parser.add_argument("output", help="Output binary file path")
    args = parser.parse_args()

    video_to_ascii_file(args.input, args.output)
