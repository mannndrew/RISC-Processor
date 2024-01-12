import sys

memory = []
width = 8
depth = 65536

# Check if the correct number of arguments were provided
if len(sys.argv) != 2:
    print("Usage: python makehex.py <file>")
    sys.exit(1)

# Get the file name from the arguments
file_name = sys.argv[1]

# Check if the file name is valid
if file_name[-4:] != ".bin":
    print("Error: File must be '.bin'")
    sys.exit(1)

# Check if file exists and open it
binary_file = None
try:
    binary_file = open(file_name, "rb")
except FileNotFoundError:
    print(f"Error: File '{file_name}' not found")
    sys.exit(1)

# Read the contents of the file
binary_data = binary_file.read()

# print(binary_data)

# Display the binary data as hexadecimal
for byte in binary_data:
    byte = hex(byte)[2:]
    if len(byte) == 1:
        byte = "0" + byte
    byte = str.upper(byte)
    memory.append(byte)

# Close the binary file
binary_file.close()




# Open the output file in write mode
file_path = file_name[:-4] + ".mif"
output_file = open(file_path, "w")

# Write the MIF header
output_file.write(f"DEPTH = {depth};\n")
output_file.write(f"WIDTH = {width};\n")
output_file.write(f"ADDRESS_RADIX = HEX;\n")
output_file.write(f"DATA_RADIX = HEX;\n")
output_file.write(f"CONTENT\n")
output_file.write(f"BEGIN\n")

# Write the contents of the memory
byte_count = 0
for address in range(depth):
    word = ""

    if byte_count < len(memory):
        word = word + memory[byte_count]
        byte_count += 1

    else:
        word = "00"

    output_file.write(f"{address:04x}: {word};\n")

# Write the MIF footer
output_file.write(f"END;")

# Close the output file
output_file.close()
