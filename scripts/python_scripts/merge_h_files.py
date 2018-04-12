import os,re
inputfolder = '/N/dc2/projects/PromoterPopGen/human/human-split-data/'
outputfolder = '/N/dc2/projects/PromoterPopGen/Xuan'

def merge1dir(path,outfile):
    os.chdir(os.path.join(inputfolder,path))
    flist=[]
    for f in os.listdir('.'):
        if re.search(r'^\d+\s-\s\d+',f) is not None:
            flist.append([int(f.split()[0]),f])
    flist.sort(key=lambda x:x[0])
    csvhead=None
    with open(os.path.join(outputfolder,outfile), 'w',) as of:
        for index,f in flist:
            with open(f) as csvfile:
                if csvhead is None:
                    csvhead = csvfile.next()
                    of.write(csvhead)
                else:
                    csvfile.next()
                for line in csvfile:
                    of.write(line)


if __name__=='__main__':
    for i in range(1,23):
        cisregfile = 'cisreg_chr'+str(i)+'.txt'
        genefile = 'gene_chr'+str(i)+'.txt'
        cisregpath = 'cisreg_chr'+str(i)
        genepath = 'gene_chr'+str(i)
        merge1dir(cisregpath,cisregfile)
        merge1dir(genepath,genefile)

