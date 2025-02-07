import matplotlib.pyplot as plt
import numpy as np

# Define raw data
data = {
    "Method": ["Optical", "Radio Waves", "Acoustic Waves"],
    "Propagation Speed (normalized)": [1.0, 1.0, 0.005],  # Based on ~3×10⁸ m/s vs 1.5 km/s
    "Security (normalized)": [1.0, 0.2, 0.8],  # Relative scaling
    "Attenuation (normalized)": [0.8, 0.6, 1.0],  # Lower attenuation is better
    "Distance (normalized)": [0.3, 0.1, 1.0],  # Based on ~300 m, ~100 m, >1000 m
}

# Assign higher weight to Distance and moderate weights to Security and Attenuation
weights = [0.1, 0.3, 0.3, 0.3]  # Less weight for Propagation Speed, more for Distance, Security, and Attenuation
methods = data["Method"]
scores = []
keys = list(data.keys())[1:]  # Convert keys to a list and exclude 'Method'

for i in range(len(methods)):
    score = sum(data[key][i] * weight for key, weight in zip(keys, weights))
    scores.append(score)

# Add Acoustic Wave Score
acoustic_wave_score = scores[2]
optic_wave_score=scores[0]
radio_wave_score=scores[1]


# Visualization
fig, ax = plt.subplots(figsize=(8, 5))
bars = ax.bar(methods, scores, color=['blue', 'orange', 'red'])

# Annotate scores
ax.bar_label(bars, labels=[f"{s:.2f}" for s in scores], fontsize=10, padding=3)

# Add labels and title
ax.set_ylabel("Normalized Score", fontsize=12)
ax.set_xlabel("Communication Methods", fontsize=12)
ax.set_title("Normalized Scores of Communication Methods", fontsize=14)

# Highlight acoustic waves
bars[2].set_color('red')  # Acoustic Waves highlighted in red

plt.show()

# Print the score for Acoustic Waves
print(f"Score for Acoustic Waves: {acoustic_wave_score:.2f}")
print(f"Score for Optic Waves: {optic_wave_score:.2f}")
print(f"Score for Radio Waves: {radio_wave_score:.2f}")
