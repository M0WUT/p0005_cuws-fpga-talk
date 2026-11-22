import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator

theta = np.linspace(0, 1000, 1000)
theta_wrapped = theta % 360
sine_theta = np.sin(np.deg2rad(theta_wrapped))

fig, ax = plt.subplots(2, 1, figsize=(10, 6), sharex=True)

# Wrapped theta
ax[0].plot(theta, theta_wrapped, color="blue", linewidth=2)
ax[0].set_ylabel("Theta (degrees)")
ax[0].set_title("Wrapped Theta (0°–360°)")
ax[0].set_ylim(0, 360)
ax[0].grid(True)

# Sine theta
ax[1].plot(theta, sine_theta, color="red", linewidth=2)
ax[1].set_xlabel("Input Angle (degrees)")
ax[1].set_ylabel("sin(θ)")
ax[1].set_ylim(-1.1, 1.1)
ax[1].grid(True)

# Major x-axis ticks every 90 degrees
ax[1].xaxis.set_major_locator(MultipleLocator(90))

plt.tight_layout()
plt.show()
