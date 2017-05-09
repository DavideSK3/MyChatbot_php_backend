cinema = ["Cinema Nuova Roma","Supercinema Vittoria"];
month = ["2017-05","2017-06","2017-07"]
film = [1,2,3,4];
time = ["19:00","21:30"]


for f in range(len(film)):
    for c in range(len(cinema)):
        for m in range(len(month)):
            for d in range(1,32):
                for t in range(len(time)):
                    x=str(film[f])+", "+cinema[c]+", "+month[m]+"-"
                    if(d<10):
                        x=x+"0"
                    x=x+str(d)+", "+time[t]+"\n"
                    print(x)
                    with open("C:\\Users\\david\\Desktop\\out.txt", "a") as myfile:
                        myfile.write(x)


"""apex= data[0][0]
for s in range(len(data)):
    data[s]= data[s].replace(apex,'');
    with open("C:\\Users\\david\\Desktop\\out.txt", "a") as myfile:
        myfile.write(data[s])
    print(data[s]);
    """