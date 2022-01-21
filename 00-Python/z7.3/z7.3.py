
def get_dict(file_line,info_count_line):
    for file in file_line:
        with open(file) as f:
            size=(len(f.readlines()))
            info_count_line[file]=size
    return info_count_line

def sort_dict(info_count_line):
    sorted_dict = {}
    sorted_values = sorted(info_count_line, key=info_count_line.get) 
    for w in sorted_values:
        sorted_dict[w] = info_count_line[w]
    return(sorted_dict)   


def get_result_file(file,sorted_dict):
    for file_name,count_line in sorted_dict.items():
        data=''
        with open(file_name) as f:
            data=f.read()
        f = open(file, 'a')
        f.write(str(file_name)+'\n'+
                str(count_line)+'\n'+
                data+'\n')
    f.close()
    return print('success')

def main(file_line,result_file):
    info_count_line={}
    info_count_line=get_dict(file_line,info_count_line)
    info_count_line=sort_dict(info_count_line)
    get_result_file(result_file,info_count_line)

main(['z7.3/1.txt','z7.3/2.txt','z7.3/3.txt'],'z7.3/result.txt')