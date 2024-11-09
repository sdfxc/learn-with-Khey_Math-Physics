# Variables for Vehicle A and Vehicle B
distance_a = 60  # in kilometers
speed_a = 40     # in km/h

distance_b = 80  # in kilometers
speed_b = 40     # in km/h

# Calculate time for each vehicle
time_a = distance_a / speed_a  # Time = Distance / Speed
time_b = distance_b / speed_b

# Print results
print(f"Time taken by Vehicle A: {time_a} hours")
print(f"Time taken by Vehicle B: {time_b} hours")

# Determine which vehicle took more time
if time_a > time_b:
    print("Vehicle A took more time.")
elif time_a < time_b:
    print("Vehicle B took more time.")
else:
    print("Both vehicles took the same time.")

# Calculate the difference in time
time_difference = abs(time_a - time_b)
print(f"Time difference: {time_difference} hours")
