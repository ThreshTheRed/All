import os.path, os, zipfile, zlib, shutil, logging, datetime

input_range = ('A','B','C','D','E','Z')
number_range = (1,2,3)
not_exist = ('File does not exist.')
now = datetime.datetime.now()

# Logging module configuration

logging.basicConfig(filename='C:/pythonlog/' + now.strftime("%Y%m%d%H%M%S") + ".log", filemode='w', level=logging.INFO, format='%(asctime)s - %(message)s')
logging.info('Script started')

while True:

    print('What do you want to do with a file?:\n[A]Show text file content.\n[B]Compress.\n[C]Show file size.\n[D]Show directory content.\n[E]Delete.\n[Z]Exit.\n')        

    # Making letters capitalised.
    
    pick_one = input('Pick a leter:\n')
    capitalizer = pick_one.capitalize()
    logging.info('Leter picked: ' + capitalizer)


    if capitalizer in input_range: 

        # File Content block

        if capitalizer in ('A'):
            directory = input('File directory (f.ex. C:/temp/):\n')
            if os.path.exists(directory):
                print('************')
                with open(directory, "r", encoding="utf-8") as file:
                    for line in file:
                        print(line)
                    print('************')
                    logging.info('File content has been shown.')   
            else:
                print(logging.info(not_exist), not_exist) 

        # Compression block
        # zip (if zlib is imported), tar, gztar (if zlib imported), bztar (if bz2 is imported), zip works fine, rest to test

        elif capitalizer in ('B'):            
            directory = input('File directory (f.ex. C:/temp/):\n')
            if os.path.exists(directory):
                c_dir = input('Archive directory:\n')
                c_type = input('Compression type:\n') 
                c_name = input('Name of the archive:\n')
                shutil.make_archive(c_dir + c_name, c_type, c_dir, directory)
                print('\nFile is compressed in ' + c_dir)
                logging.info('File from ' + directory + ' compressed to ' + c_dir + ' with name ' + c_name + c_type + '.\n')
            else:
                print(logging.info(not_exist), not_exist)

        # File size block
        
        elif capitalizer in ('C'):
            answer = input('File directory (f.ex. C:/temp/printout.txt):\n')
            if os.path.exists(answer):
                print(int(os.path.getsize(answer))/1000000," MB")
                logging.info('File size showed.')
            else:
                print(logging.info(not_exist), not_exist)  

        # Directory content block
        
        elif capitalizer in ('D'):
            answer = input('Directory (f.ex. C:/temp/):\n')
            if os.path.exists(answer):
                print(os.listdir(answer))
                logging.info('Directory content showed.')
            else:
                print(logging.info(not_exist), not_exist)

        # Delete block

        elif capitalizer in ('E'):
            print('What do you want to delete?\n')
            print('1.Everything in particular directory (with directory).\n2.Only subdirectory content.\n3.Files based on filetype.\n')
            nr = int(input('Pick a number:\n'))
            if nr in number_range:
                logging.info('User pick: ' + str(nr))
                if nr == 1:
                    rm_dir = input('Directory to remove: ')
                    shutil.rmtree(rm_dir, onerror=None)             # fix it bejbe
                    if True:
                        print('File successfully removed.')
                        logging.info('File removed.')
                    else:
                        print(logging.info(not_exist), not_exist)
                elif nr == 2:
                    directory = input('Directory:\n')
                    os.chdir(directory)
                    for root, dirs, files in os.walk(".", topdown=False):
                        for file in files:
                            print(os.path.join(root, file))
                            os.remove(os.path.join(root, file))
                    else:
                        print(logging.info(not_exist), not_exist)
                elif nr == 3:
                    file_type = input('File type (f.ex. .txt):\n')                    

        
        # End script block

        elif capitalizer in ('Z'):
            print("You quit.")
            capitalizer = ""                        #variable cleaning
            directory = ""
            logging.info('End of script.')
            break
    else:
        print("\nUnsupported choice. Either input is word, number or it's not in defined range.")
        logging.info("Unsupported choice. Either input is word, number or it's not in defined range.")



# 2do - ogarnąć logi w w przypadku gdzie przerywamy skrypt za pomocą Ctrl+C
# wybór do funkcji
