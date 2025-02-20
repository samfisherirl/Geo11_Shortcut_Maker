import os
import os.path
from lib import reg_query as GetSteam
import time
from lib import locate_steam

appinfos = []
appinfos = locate_steam.main()
appinfo = appinfos[0]
steampath = appinfos[1]

def appinfo():
    appinfo = appinfos[0]
    return appinfo

def steamlib():
    steampath = appinfos[1]
    path = os.path.join(steampath, 'config\\libraryfolders.vdf')
    return path

#################################################
# get steam paths from list of installs on reg
# combine in loop with appinfo
# return proper appinfo install path
################################################# 
class Dir:
    def dirname():
        directory = os.path.dirname(__file__)
        return directory

    def checker(appinfo):
        if not os.path.exists(appinfo):
            return os.path.join(appinfo, 'appinfo.vdf')
        else:
            return appinfo

    def loop_addys(path):
        
        pather = os.path.join(path, 'appcache\\appinfo.vdf')
        if os.path.exists(pather):
                    return True, pather
        else:
            False, pather

def old_main():
    
    list_of_steam_addys = GetSteam.main()
    print(list_of_steam_addys)
    for i in list_of_steam_addys:
        try:
            ifexist = Dir.loop_addys(i.strip("steam.exe"))
            if ifexist[0]:  # if exist
                appinfo = ifexist[1] # path return
                break
            else:
                continue
        except:
            continue
    
    #directory = Dir.dirname()
    #appinfo = Dir.checker(appinfo)

    return appinfo
 



    