f = open("large_data.cpp", "w")

data_size = 1024*2

data_size = data_size * 1024

data_size_code = "unsigned int arr_data_size = {};\n".format(data_size)

f.write(data_size_code)

data_array_code_start = "unsigned char arr_data[] = {"

f.write(data_array_code_start)

for i in range(0, data_size):
    f.write(str(i%256))

    if(i!=data_size-1):
        f.write(",")

    if(i%256 == 255):
        f.write("\n")

f.write("};\n")

code_p_array_data = "unsigned char* p_arr_data = &arr_data[0];\n"

f.write(code_p_array_data)

f.close()