import math, os, cv2
import numpy as np
import matplotlib
matplotlib.use("TkAgg")
import matplotlib.pyplot as plt
from shapely.geometry import Polygon
from shapely.affinity import rotate, translate
from shapely.ops import unary_union
from natsort import natsorted


image_folder      = "cross_frames"
video_output_dir  = "rendered_video"
output_filename   = "hook_demo.mp4"
fps               = 1                # Frames per second


os.makedirs(image_folder,     exist_ok=True)
os.makedirs(video_output_dir, exist_ok=True)
output_path = os.path.join(video_output_dir, output_filename)


# function to define the "boundary"
def create_outer_radii(radius=2.5, segments=100):
    arc = [(radius*math.cos(a), radius*math.sin(a))
           for a in np.linspace(0, 2*math.pi, segments)]
    return Polygon([(0, 0)] + arc + [(0, 0)])

def create_final_cross(cx, cy,
                       bar_len, bar_thk,
                       hook_len, hook_thk,
                       angle=0):
    
    hl, ht  = bar_len/2, bar_thk/2
    hs      = hook_thk/2

    # 中心横条
    h_bar = Polygon([
        (cx-hl, cy-ht), (cx+hl, cy-ht),
        (cx+hl, cy+ht), (cx-hl, cy+ht)
    ])
    # 中心竖条
    v_bar = Polygon([
        (cx-ht, cy-hl), (cx+ht, cy-hl),
        (cx+ht, cy+hl), (cx-ht, cy+hl)
    ])

    # four hook
    top = Polygon([
        (cx-hook_len/2, cy+hl),
        (cx+hook_len/2, cy+hl),
        (cx+hook_len/2, cy+hl+hook_thk),
        (cx-hook_len/2, cy+hl+hook_thk)
    ])
    bottom = Polygon([
        (cx-hook_len/2, cy-hl-hook_thk),
        (cx+hook_len/2, cy-hl-hook_thk),
        (cx+hook_len/2, cy-hl),
        (cx-hook_len/2, cy-hl)
    ])
    left = Polygon([
        (cx-hl-hook_thk, cy-hook_len/2),
        (cx-hl,            cy-hook_len/2),
        (cx-hl,            cy+hook_len/2),
        (cx-hl-hook_thk, cy+hook_len/2)
    ])
    right = Polygon([
        (cx+hl,            cy-hook_len/2),
        (cx+hl+hook_thk, cy-hook_len/2),
        (cx+hl+hook_thk, cy+hook_len/2),
        (cx+hl,            cy+hook_len/2)
    ])

    full = unary_union([h_bar, v_bar, top, bottom, left, right])
    return rotate(full, angle, origin=(cx, cy), use_radians=False)


# function to plot the shapes with zip (solving the issue of plotting polygons with holes))
def plot_shape(ax, shape, color='green', alpha=0.6, edgecolor=None):   
    if shape.is_empty:
        return
    if shape.geom_type == 'Polygon':
        x, y = shape.exterior.xy
        ax.fill(x, y, alpha=alpha, fc=color, ec=edgecolor)
        for interior in shape.interiors:
            xi, yi = zip(*interior.coords)
            ax.fill(xi, yi, color='white', ec='none')
    elif shape.geom_type == 'MultiPolygon':
        for geom in shape.geoms:
            plot_shape(ax, geom, color=color, alpha=alpha, edgecolor=edgecolor)



# defining variables
bar_len  = 2.0       
bar_thk  = 0.4
hook_thk = 0.4
outer_radius = 2.5
outer_radii  = create_outer_radii(radius=outer_radius)
domain_area  = outer_radii.area
I_values = []


hook_values = np.arange(0.4, 1.7, 0.4)	# take value from 0.4 to ..., step 0.4
x_vals  = np.arange(-outer_radius, outer_radius+0.01, 0.2)
y_vals  = np.arange(-outer_radius, outer_radius+0.01, 0.2)
angles  = np.arange(0, 360, 4)        # take a value every 4°, from 0 to []





# doing three for loops in those 4 dimentions

for hook_len in hook_values:

    cross_fixed = create_final_cross(
        0, 0, bar_len, bar_thk,
        hook_len, hook_thk, angle=0
    )

    valid_shapes = []
    valid_count  = 0

    for x in x_vals:
        for y in y_vals:
            for angle in angles:
                cross_trial = create_final_cross(
                    0, 0, bar_len, bar_thk,
                    hook_len, hook_thk, angle=0
                )
                cross_trial = rotate(cross_trial, angle, origin=(0, 0))
                cross_trial = translate(cross_trial, xoff=x, yoff=y)

          # if the cross shape is within the boundary and not null. then add it to the valid shapes
                if not cross_fixed.intersects(cross_trial) and not cross_trial.is_empty:
                    valid_shapes.append(cross_trial)
                    valid_count += 1

     # combing all valid shapes into a single shape
    accessible_union = unary_union(valid_shapes)
    accessible_area  = accessible_union.intersection(outer_radii).area
    fixed_area       = cross_fixed.area
    inaccessible_area = domain_area - fixed_area - accessible_area
    I = inaccessible_area / domain_area
    I_values.append(I)

     #  plotting the shapes
    fig, ax = plt.subplots(figsize=(6, 6))
    plot_shape(ax, accessible_union, color='green', alpha=0.4)
    plot_shape(ax, cross_fixed,      color='blue',  alpha=0.6)
    ax.set_title(f"hook_len = {hook_len:.2f},  I = {I:.4f}")
    ax.set_xlim(-outer_radius, outer_radius)
    ax.set_ylim(-outer_radius, outer_radius)
    ax.set_aspect('equal')
    plt.grid(True)
    img_path = f"{image_folder}/hook_{hook_len:.2f}.png"
    plt.savefig(img_path)
    plt.close()

    print(f"hook_len = {hook_len:.2f} → Valid placements: {valid_count}, I = {I:.5f}")
    print(f"Saved: {img_path}")


# read images and create videos
images = natsorted([f for f in os.listdir(image_folder) if f.endswith('.png')])
if not images:
    raise RuntimeError(f"No .png images found in folder: {image_folder}")

h, w, _ = cv2.imread(os.path.join(image_folder, images[0])).shape

# Set up the video writer
fourcc  = cv2.VideoWriter_fourcc(*'mp4v')
video   = cv2.VideoWriter(output_path, fourcc, fps, (w, h))


# Write each image frame to the video
for img_name in images:
    img_path = os.path.join(image_folder, img_name)
    frame = cv2.imread(img_path)
    video.write(frame)


video.release()
print(f"Video saved to: {output_path}")


# plotting the inacessibility values versus the hook angle
plt.figure(figsize=(8, 5))
plt.plot(hook_values, I_values, marker='o')
plt.xlabel("Hook length (scaled units)")
plt.ylabel("Inaccessibility I")
plt.title("Inaccessibility I vs Hook Length")
plt.grid(True)
plt.tight_layout()
plt.show()
