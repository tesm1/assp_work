import csv


# input_file = 'stream_in.in'
input_file = 'delay_in.in'
output_file = 'output.csv'


if __name__ == "__main__":

	with open(input_file, 'r') as infile:
		lines = infile.readlines()

	values = [line.strip() for line in lines]

	with open(output_file, mode='w', newline='') as outfile:
		writer = csv.writer(outfile)
		writer.writerow(values)

	print(f'Data has been written to {output_file}')
