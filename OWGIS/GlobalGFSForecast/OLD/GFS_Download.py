import subprocess
from datetime import datetime
from datetime import timedelta
import math as mt
from multiprocessing import Process

__author__="Olmo S. Zavala Romero"


def getParGFS(procNumber,totIterations,totProc):

    now = datetime.today()
    add = timedelta(days=1)
    # We use the forecast of the previous day
    newd = now - add

    cy = str(newd.year)
    cm = str(newd.month).zfill(2)
    cd = str(newd.day).zfill(2)

    fileNumbers =  [x*3+(procNumber*totIterations*3) for x in range(totIterations)]

    for num in fileNumbers:
        tocall = "wget ftp://nomads.ncdc.noaa.gov/GFS/Grid4/%s%s/%s%s%s/gfs_4_%s%s%s_0000_%s.grb2"\
                   %(cy,cm,cy,cm,cd,cy,cm,cd,str(num).zfill(3))

        print(tocall)
        subprocess.call([tocall],shell=True)


if __name__ == "__main__":
    totProc = 8
    totIterations = mt.ceil((384/3)/totProc)

    for th in range(totProc):
        t = Process(target=getParGFS, args=(th,totIterations,totProc,))
        t.start()
