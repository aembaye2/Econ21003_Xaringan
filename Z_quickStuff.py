import csv

# Define the data
data = [
    {"Name": "Allan Hatch", "UA ID": "X", "Email": "hatch@uark.edu"},
    {"Name": "Arafat Rafi", "UA ID": "011080108", "Email": "arafi@uark.edu"},
    {"Name": "Danielle Purcell", "UA ID": "010983402", "Email": "purcell@uark.edu"},
    {"Name": "Emmanuel Oguntomi", "UA ID": "011072977", "Email": "oguntomi@uark.edu"},
    {"Name": "Kerry-Ann Purcell", "UA ID": "010980179", "Email": "kjpurcel@uark.edu"},
    {"Name": "Kushal Lamichhane", "UA ID": "010953574", "Email": "kl048@uark.edu"},
    {"Name": "Mario de Armas", "UA ID": "X", "Email": "mdearmas@uark.edu"},
    {"Name": "Matthew Diyaolu", "UA ID": "011016513", "Email": "mdiyaolu@uark.edu"},
    {"Name": "Md Shahporan Swadhin", "UA ID": "011044940",
        "Email": "mswadhin@uark.edu"},
    {"Name": "Miguel Cuellar", "UA ID": "010913641", "Email": "mecuella@uark.edu"},
    {"Name": "MohammadJavad Bakhtiarvandi",
        "UA ID": "011011603", "Email": "mk054@uark.edu"},
    {"Name": "Priyanka Pimple", "UA ID": "011011720", "Email": "ppimple@uark.edu"},
    {"Name": "Raiyan Syed", "UA ID": "010734083", "Email": "rmsyed@uark.edu"},
    {"Name": "Sheikh Elhum Uddin Quadery", "UA ID": "X", "Email": "su008@uark.edu"},
    {"Name": "Tandem Young", "UA ID": "010851859", "Email": "tjy003@uark.edu"}
]

# Define the file path
file_path = 'students.csv'

# Write the data to a CSV file
with open(file_path, mode='w', newline='') as file:
    fieldnames = ["Name", "UA ID", "Email"]
    writer = csv.DictWriter(file, fieldnames=fieldnames)

    writer.writeheader()
    writer.writerows(data)

print(f"Data saved to {file_path}")
