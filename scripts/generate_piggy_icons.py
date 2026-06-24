from PIL import Image, ImageDraw
import os

OUT_DIR = os.path.dirname(__file__) + os.sep + '..'
OUT_DIR = os.path.abspath(OUT_DIR)

sizes = [512,192,180,167,152,120,32,16]

# Colors
bg_color = (255,255,255,255)  # white background
pig_fill = (233, 85, 110, 255)  # warm pink
pig_accent = (200, 50, 90, 255)  # darker pink
eye_color = (255,255,255,255)

for s in sizes:
    img = Image.new('RGBA', (s, s), bg_color)
    draw = ImageDraw.Draw(img)
    # Draw a simple piggy bank shape using ellipses and rectangle
    # Body
    body_bbox = [int(s*0.08), int(s*0.25), int(s*0.78), int(s*0.62)]
    draw.ellipse(body_bbox, fill=pig_fill)
    # Snout
    snout_bbox = [int(s*0.58), int(s*0.35), int(s*0.72), int(s*0.46)]
    draw.ellipse(snout_bbox, fill=pig_accent)
    # Snout nostrils
    nostril_r = max(1, int(s*0.015))
    draw.ellipse([snout_bbox[0]+int(s*0.02), snout_bbox[1]+int(s*0.02), snout_bbox[0]+int(s*0.02)+nostril_r*2, snout_bbox[1]+int(s*0.02)+nostril_r*2], fill=(120,0,0,255))
    draw.ellipse([snout_bbox[0]+int(s*0.07), snout_bbox[1]+int(s*0.02), snout_bbox[0]+int(s*0.07)+nostril_r*2, snout_bbox[1]+int(s*0.02)+nostril_r*2], fill=(120,0,0,255))
    # Ear
    ear_bbox = [int(s*0.2), int(s*0.08), int(s*0.4), int(s*0.28)]
    draw.polygon([(ear_bbox[0], ear_bbox[3]), ((ear_bbox[0]+ear_bbox[2])//2, ear_bbox[1]), (ear_bbox[2], ear_bbox[3])], fill=pig_fill)
    # Tail (simple curved line approximated by arc)
    tail_bbox = [int(s*0.72), int(s*0.2), int(s*0.92), int(s*0.38)]
    draw.arc(tail_bbox, start=200, end=320, fill=pig_accent, width=max(1, int(s*0.02)))
    # Eye
    eye_x = int(s*0.46)
    eye_y = int(s*0.4)
    eye_r = max(1, int(s*0.02))
    draw.ellipse([eye_x-eye_r, eye_y-eye_r, eye_x+eye_r, eye_y+eye_r], fill=(80,0,0,255))
    # Coin slot (top)
    slot_w = max(1, int(s*0.22))
    slot_h = max(1, int(s*0.03))
    slot_x = int(s*0.18)
    slot_y = int(s*0.18)
    draw.rectangle([slot_x, slot_y, slot_x+slot_w, slot_y+slot_h], fill=(120,120,120,255))
    # Save as PNG
    out_path = os.path.join(OUT_DIR, f'icon-{s}.png')
    img.save(out_path, format='PNG')
    print('Wrote', out_path)
