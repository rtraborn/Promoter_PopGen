import os,re
inputfolder = '/N/dc2/projects/PromoterPopGen/TSSs_gff/'
inputfolder2 = '/N/dc2/projects/PromoterPopGen/genes_gff/'
outputfolder = '/N/dc2/projects/PromoterPopGen/Xuan'

def sortgff(inputfile,outputfile):
    with open(inputfile) as input, open(outputfile,'w') as output:
        linelist=[]
        for line in input:
            if line[0]=='#' or len(line)<3:
                output.write(line)
                continue
            linelist.append([line,line.split()[3]])
        linelist.sort(key=lambda x:int(x[1]))
        for line, index in linelist:
            output.write(line)

if __name__=='__main__':
    os.chdir(inputfolder)
    for f in os.listdir('.'):
        if re.search(r'updated.gff3$',f) is not None:
            sortgff(f,os.path.join(outputfolder,os.path.splitext(f)[0]+'_sorted_'+os.path.splitext(f)[1]))
    os.chdir(inputfolder2)
    for f in os.listdir('.'):
        if re.search(r'.gff3$',f) is not None:
            sortgff(f,os.path.join(outputfolder,os.path.splitext(f)[0]+'_sorted_'+os.path.splitext(f)[1]))