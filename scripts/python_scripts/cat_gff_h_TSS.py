import os

inputfolder = '/N/dc2/projects/PromoterPopGen/Xuan'
outputfolder = '/N/dc2/projects/PromoterPopGen/Xuan/h_matrix'


def cat_gff_h(gfffile, h_file, outputfolder):
    with open(h_file) as hf:
        hsplit = [line.split() for line in hf]

    head = hsplit[0]
    pj = 1

    population_h_dict = {i: {} for i in head}
    promoter_name_dict = {}
    promoter_center_list = []

    with open(gfffile) as gf:
        for line in gf:
            if line[0] == '#' or len(line) < 3:
                continue
            linesp = line.split()
            left = int(linesp[3])
            right = int(linesp[4])
            strand = linesp[6]
            center = int(round((left + right) / 2))
            promoter_center_list.append(center)
            if center not in promoter_name_dict:
                promoter_name_dict[center] = linesp[8]
            for pop in head:
                population_h_dict[pop][center] = []

            while pj+1<len(hsplit) and int(hsplit[pj + 1][0]) <= left:
                pj = pj + 1
            pk = pj

            for i in range(left, right + 1):
                while pk+1<len(hsplit) and int(hsplit[pk + 1][0]) <= i:
                    pk = pk + 1
                if int(hsplit[pk][0]) == i:
                    for pop_index in range(1, len(hsplit[pk])):
                        pop = head[pop_index - 1]
                        population_h_dict[pop][center].append(hsplit[pk][pop_index])
                else:
                    for pop_index in range(1, len(hsplit[pk])):
                        pop = head[pop_index - 1]
                        population_h_dict[pop][center].append('0')
            if strand == '-':
                for pop in head:
                    population_h_dict[pop][center].reverse()

    for pop in head:
        with open(os.path.join(outputfolder, pop + '.txt'), 'w') as popout:
            for promoter in promoter_center_list:
                popout.write('\t'.join([str(promoter), promoter_name_dict[promoter]]
                                       + population_h_dict[pop][promoter]) + '\n')

    pass


if __name__ == '__main__':
    for i in range(1,23):
        outsubfolder = os.path.join(outputfolder, 'cis' + str(i))
        if not os.path.isdir(outsubfolder):
            os.mkdir(outsubfolder)
        cat_gff_h(os.path.join(inputfolder, 'TSSset_human_chr_' + str(i) + '_updated_sorted_.gff3'),
                  os.path.join(inputfolder, 'cisreg_chr' + str(i) + '.txt'), outsubfolder)
        #outsubfolder = os.path.join(outputfolder, 'gene' + str(i))
        #if not os.path.isdir(outsubfolder):
        #    os.mkdir(outsubfolder)
        #cat_gff_h(os.path.join(inputfolder, 'TSSset_human_chr_' + str(i) + '_updated_sorted_.gff3'),
        #          os.path.join(inputfolder, 'gene_chr' + str(i) + '.txt'), outsubfolder)