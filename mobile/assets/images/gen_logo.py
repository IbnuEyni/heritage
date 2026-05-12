"""
Kebena Heritage — App Icon Generator
Writes icons directly into Android mipmap and iOS AppIcon folders.
"""
import math, os
from PIL import Image, ImageDraw, ImageFilter

SIZE = 1024
CX = CY = SIZE // 2

PRIMARY       = (27,  67,  50)
PRIMARY_LIGHT = (45, 106,  79)
PRIMARY_MID   = (58, 125,  94)
GOLD          = (212, 160,  23)

def alpha(color, a):
    return (*color[:3], int(255 * a))

def radial_gradient(size):
    img = Image.new("RGBA", (size, size))
    cx = cy = size // 2
    for y in range(size):
        for x in range(size):
            dist = math.hypot(x - cx, y - (cy - size * 0.08))
            t = min(dist / (size * 0.72), 1.0) ** 1.3
            r = int(PRIMARY_MID[0] * (1-t) + 13 * t)
            g = int(PRIMARY_MID[1] * (1-t) + 43 * t)
            b = int(PRIMARY_MID[2] * (1-t) + 31 * t)
            img.putpixel((x, y), (r, g, b, 255))
    return img

def star_path(cx, cy, outer_r, inner_r, points, rotation=0):
    pts = []
    for i in range(points * 2):
        angle = (i * math.pi / points) - math.pi / 2 + rotation
        r = outer_r if i % 2 == 0 else inner_r
        pts.append((cx + r * math.cos(angle), cy + r * math.sin(angle)))
    return pts

def draw_dashed_circle(draw, cx, cy, r, color, width, dash_count=48):
    step = (2 * math.pi) / dash_count
    for i in range(0, dash_count, 2):
        start = math.degrees(i * step)
        end   = math.degrees(i * step + step * 0.55)
        bbox  = [cx - r, cy - r, cx + r, cy + r]
        draw.arc(bbox, start=start, end=end, fill=color, width=width)

def draw_circle_stroke(draw, cx, cy, r, color, width):
    draw.ellipse([cx-r, cy-r, cx+r, cy+r], outline=color, width=width)

def make_icon(size, rounded=True):
    scale = size / SIZE
    img   = radial_gradient(SIZE).resize((size, size), Image.LANCZOS)
    draw  = ImageDraw.Draw(img, "RGBA")
    cx = cy = size // 2
    r  = size * 0.46

    # Glow halo
    glow = Image.new("RGBA", (size, size), (0,0,0,0))
    gd   = ImageDraw.Draw(glow, "RGBA")
    for i in range(6):
        gr = r * (1.05 + i * 0.04)
        gd.ellipse([cx-gr, cy-gr, cx+gr, cy+gr], fill=(*GOLD, max(1, 28 - i*4)))
    glow = glow.filter(ImageFilter.GaussianBlur(radius=size * 0.025))
    img  = Image.alpha_composite(img, glow)
    draw = ImageDraw.Draw(img, "RGBA")

    # Outer ring
    draw_circle_stroke(draw, cx, cy, int(r*1.02), alpha(GOLD, 0.30), max(1, int(2*scale)))
    # Dashed ring
    draw_dashed_circle(draw, cx, cy, int(r*0.90), alpha(GOLD, 0.55), max(1, int(3*scale)))

    # Gradient disc
    disc = Image.new("RGBA", (size, size), (0,0,0,0))
    dd   = ImageDraw.Draw(disc, "RGBA")
    disc_r = int(r * 0.78)
    for i in range(disc_r, 0, -1):
        t  = 1 - (i / disc_r)
        rc = int(PRIMARY_MID[0]*(1-t) + PRIMARY[0]*t)
        gc = int(PRIMARY_MID[1]*(1-t) + PRIMARY[1]*t)
        bc = int(PRIMARY_MID[2]*(1-t) + PRIMARY[2]*t)
        dd.ellipse([cx-i, cy-i, cx+i, cy+i], fill=(rc, gc, bc, 255))
    img  = Image.alpha_composite(img, disc)
    draw = ImageDraw.Draw(img, "RGBA")

    # Inner rings
    draw_circle_stroke(draw, cx, cy, int(r*0.78), alpha(GOLD, 0.65), max(1, int(2*scale)))
    draw_circle_stroke(draw, cx, cy, int(r*0.62), alpha(GOLD, 0.22), max(1, int(1*scale)))

    # Outer 8-pointed star
    outer_star = star_path(cx, cy, r*0.50, r*0.21, 8)
    draw.polygon(outer_star, fill=alpha(GOLD, 0.18))
    draw.polygon(outer_star, outline=alpha(GOLD, 1.0), width=max(2, int(4*scale)))

    # Inner 8-pointed star rotated 22.5°
    inner_star = star_path(cx, cy, r*0.30, r*0.13, 8, rotation=math.pi/8)
    draw.polygon(inner_star, outline=alpha(GOLD, 0.60), width=max(1, int(2*scale)))

    # Center jewel
    jr = int(r * 0.10)
    draw.ellipse([cx-jr, cy-jr, cx+jr, cy+jr], fill=GOLD)
    jr2 = int(r * 0.055)
    draw.ellipse([cx-jr2, cy-jr2, cx+jr2, cy+jr2], fill=PRIMARY)

    # Rounded corners
    if rounded:
        mask = Image.new("L", (size, size), 0)
        ImageDraw.Draw(mask).rounded_rectangle(
            [0, 0, size, size], radius=int(size * 0.2232), fill=255)
        img.putalpha(mask)
    else:
        img = img.convert("RGB")

    return img

if __name__ == "__main__":
    base = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))

    # ── Master assets ────────────────────────────────────────────────────────
    assets_dir = os.path.join(base, "assets", "images")
    make_icon(1024).save(os.path.join(assets_dir, "icon_1024.png"))
    print("✓ assets/images/icon_1024.png")

    # ── Android mipmap ───────────────────────────────────────────────────────
    android_sizes = {
        "mipmap-mdpi":    48,
        "mipmap-hdpi":    72,
        "mipmap-xhdpi":   96,
        "mipmap-xxhdpi":  144,
        "mipmap-xxxhdpi": 192,
    }
    for folder, size in android_sizes.items():
        path = os.path.join(base, "android", "app", "src", "main", "res", folder, "ic_launcher.png")
        make_icon(size, rounded=False).save(path)
        print(f"✓ android/{folder}/ic_launcher.png  ({size}px)")

    # ── iOS AppIcon ──────────────────────────────────────────────────────────
    ios_dir = os.path.join(base, "ios", "Runner", "Assets.xcassets", "AppIcon.appiconset")
    ios_sizes = {
        "Icon-App-20x20@1x.png":      20,
        "Icon-App-20x20@2x.png":      40,
        "Icon-App-20x20@3x.png":      60,
        "Icon-App-29x29@1x.png":      29,
        "Icon-App-29x29@2x.png":      58,
        "Icon-App-29x29@3x.png":      87,
        "Icon-App-40x40@1x.png":      40,
        "Icon-App-40x40@2x.png":      80,
        "Icon-App-40x40@3x.png":      120,
        "Icon-App-60x60@2x.png":      120,
        "Icon-App-60x60@3x.png":      180,
        "Icon-App-76x76@1x.png":      76,
        "Icon-App-76x76@2x.png":      152,
        "Icon-App-83.5x83.5@2x.png":  167,
        "Icon-App-1024x1024@1x.png":  1024,
    }
    for filename, size in ios_sizes.items():
        make_icon(size, rounded=False).save(os.path.join(ios_dir, filename))
        print(f"✓ ios AppIcon/{filename}  ({size}px)")

    print("\n✅  All icons written. Run your app to see the new icon.")
