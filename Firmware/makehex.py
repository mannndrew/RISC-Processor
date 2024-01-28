import sys
import os

memory = []

instruction_width = 32
instruction_origin = 0x0000_0000
instruction_length = 1024
instruction_depth = 256

data_width = 32
data_origin = 0x0000_0100
data_length = 1024
data_depth = 256

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



# Display the binary data as hexadecimal
for byte in binary_data:
    byte = hex(byte)[2:]
    if len(byte) == 1:
        byte = "0" + byte
    byte = str.upper(byte)
    memory.append(byte)


# Close the binary file
binary_file.close()


# Create folder
if not os.path.exists("output"):
    # Create the folder if it doesn't exist
    os.makedirs("output")

# Open the output file in write mode
file_path = "output/instruction_file" + ".mif"
output_file = open(file_path, "w")

# Write the MIF header
output_file.write(f"DEPTH = {instruction_depth};\n")
output_file.write(f"WIDTH = {instruction_width};\n")
output_file.write(f"ADDRESS_RADIX = HEX;\n")
output_file.write(f"DATA_RADIX = HEX;\n")
output_file.write(f"CONTENT\n")
output_file.write(f"BEGIN\n")

# Write the contents of the memory
for address in range(instruction_depth):
    word = ""

    for byte in range(4):
        if memory:
            word = memory[0] + word
            memory.pop(0)

        else:
            word = "00" + word

    output_file.write(f"{address:02x}: {word};\n")

# Write the MIF footer
output_file.write(f"END;")

# Close the output file
output_file.close()






# Open the output file in write mode
file_path = "output/data_file" + ".mif"
output_file = open(file_path, "w")

# Write the MIF header
output_file.write(f"DEPTH = {data_depth};\n")
output_file.write(f"WIDTH = {data_width};\n")
output_file.write(f"ADDRESS_RADIX = HEX;\n")
output_file.write(f"DATA_RADIX = HEX;\n")
output_file.write(f"CONTENT\n")
output_file.write(f"BEGIN\n")

# Write the contents of the memory
for address in range(data_depth):
    word = ""

    for byte in range(4):
        if memory:
            word = memory[0] + word
            memory.pop(0)

        else:
            word = "00" + word

    output_file.write(f"{address:02x}: {word};\n")

# Write the MIF footer
output_file.write(f"END;")

# Close the output file
output_file.close()
