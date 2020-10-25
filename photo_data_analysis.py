from barcode_tracker_photos_modified import *
from os.path import isfile, isdir, join, splitext, ismount
import re
from datetime import datetime
from os import rename
import TagList
import time
from sys import argv


target_pop = argv[1]
server_path = "/mnt/Videos_GRETI/field_season_fall_2020/"
data_dir_csv = "/home/michael/pinpoint_exp2/data/"
already_processed_filename = "already_processed/processed_photos_{}.txt".format(target_pop)

with open(already_processed_filename, "a+") as processed_file:
    processed_file.seek(0)
    already_processed = [line.strip() for line in processed_file]
    print("Already processed {}".format(len(already_processed)))

def create_csv(data_filepath):
    with open(data_filepath, "a+") as savefile: # open data file in append mode
        # write column names to file
        header = "population,time,id,id_prob,x,y,orientation\n"
        savefile.write(header)

if __name__=="__main__":

    tags = TagList.TagList()
    tags.load("master_list_outdoor.pkl")

    parent_directories = [join(server_path, d) for d in os.listdir(server_path)
                            if (isdir(join(server_path, d)) and
                            re.search("P\d?\d", d).group(0)==target_pop) and
                            "Puzzle" not in d and
                            join(server_path,d) not in already_processed]
    parent_directories = sorted(parent_directories, key=str.lower, reverse=False)

    for directory in parent_directories:
        #rawtime = re.search("\d\d\d\d-\d\d-\d\d_\d\d", directory).group(0)
        population = re.search("P\d?\d", directory).group(0)
        #these child directories are filled with photos from 5 min intervals
        child_directories = [join(server_path, directory, child) for child in os.listdir(directory)
                                if (isdir(join(server_path, directory, child)) and
                                join(server_path,directory,child) not in already_processed)]
        child_directories = sorted(child_directories, key=str.lower, reverse=False)

        for folder in child_directories:
            if folder not in already_processed:
                data_filepath = join(data_dir_csv,"{}_pinpoint.csv".format(os.path.basename(folder)))
                print(data_filepath)
                if not isfile(data_filepath):
                    create_csv(data_filepath)
                print(folder)
                t0= time.time()
                decode(folder, data_filepath, tags,population)
                with open(already_processed_filename, "a+") as processed_file:
                    processed_file.write("{}\n".format(folder))
                t1= time.time()
                print("Processing took {} seconds".format(t1-t0))


        print("finished processing {}".format(directory))
        #with open(already_processed_filename, "a+") as processed_file:
            #processed_file.write("{}\n".format(directory))
