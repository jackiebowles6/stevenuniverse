myfile = open('file.txt','w')
myfile.write('This is a test file\n')
myfile.write('Hello Student\n')
myfile.write('Testing 1, 2, 3 - testing !\n')
myfile.write('Python rocks !\n')
myfile.close()

# Write a code segment that opens a file named file.txt for input and prints the number of lines in that file.
fname = input("Enter file name: ")
num_lines = 0
with open(fname, 'r') as f:
    for line in f:
        num_lines += 1
print("Number of lines:")
print(num_lines)

# Write a code segment that opens a file for input and prints the number of five-letter words in the file.
fname = input("Enter file name: ")
k = 0
 
with open(fname, 'r') as f:
    for element in f:
        words = element.split()
        for word in words:
            if len(word) == 5:
                k=k+1
print("How Many Five Letter Words Occur:")
print(k)


# Write a code segment that prints the names of all the items in the current working directory.
import os

for root, dirs, files in os.walk("."):
    for filename in files:
        print(filename)

# Write a code segment that prompts the user for a file. If the file does not exist then the program should print an error. Otherwise, the program should print its contents.
import os.path
myfile = input("Enter file name: ")
if os.path.isfile(myfile):
    myfile = open(myfile)
    txt = myfile.read()
    print(txt)
    myfile.close()
else:
    print('Error: File Does Not Exist')



