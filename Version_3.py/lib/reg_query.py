import subprocess  # IMPORT FOR SUB PROCESS . RUN METHOD
import time
import os.path
    
cmd = r'''reg query "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" /s'''
# HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store
POWERSHELL_PATH = "powershell.exe"  # POWERSHELL EXE PATH
ps_script_path = cmd  # YOUR POWERSHELL FILE PATH

class Utility:  # SHARED CLASS TO USE IN OUR PROJECT

    @staticmethod    # STATIC METHOD DEFINITION
    def run_powershell(script_path, *params):  # SCRIPT PATH = POWERSHELL SCRIPT PATH,  PARAM = POWERSHELL SCRIPT PARAMETERS ( IF ANY )

        commandline_options = [POWERSHELL_PATH, script_path]  # ADD POWERSHELL EXE AND EXECUTION POLICY TO COMMAND VARIABLE
        #commandline_options = [POWERSHELL_PATH, '-ExecutionPolicy', 'Unrestricted', script_path]  # ADD POWERSHELL EXE AND EXECUTION POLICY TO COMMAND VARIABLE
        for param in params:  # LOOP FOR EACH PARAMETER FROM ARRAY
            commandline_options.append("'" + param + "'")  # APPEND YOUR FOR POWERSHELL SCRIPT

        process_result = subprocess.run(commandline_options, stdout = subprocess.PIPE, stderr = subprocess.PIPE, universal_newlines = True)  # CALL PROCESS

        #print(process_result.returncode)  # PRINT RETURN CODE OF PROCESS  0 = SUCCESS, NON-ZERO = FAIL  
        return str(process_result.stdout)      # PRINT STANDARD OUTPUT FROM POWERSHELL
        #print(process_result.stderr)      # PRINT STANDARD ERROR FROM POWERSHELL ( IF ANY OTHERWISE ITS NULL|NONE )

        # if process_result.returncode == 0:  # COMPARING RESULT
        #     Message = "Success !"
        # else:
        #     Message = "Error Occurred !"

        # return Message  # RETURN MESSAGE

def writer(): 
    output = str(Utility.run_powershell(ps_script_path))
    # with open(dir, 'w+', encoding="utf-8", errors='replace') as f:
    #     f.write(output)
    return output

def parse_output(output):
    steam_exe = []
    steam_path = []
    lines = output.splitlines()
    for i in lines:
        try:
            tabsplit = i.split('    ')
        except:
            continue
        for x in tabsplit: 
            if "steam.exe" in x: 
                steam_path.append(x)  
    return steam_path


def main(): 
    dirname = os.path.dirname(__file__)
    dir = os.path.join(dirname, "log.txt")
    
    output = writer()
    ret = []
    ret = parse_output(output) 
    return ret
    #list_of_steam_addys = parse_output(output)
    #return list_of_steam_addys
    
    #print("Steam Addresses: ", list_of_steam_addys)
    #print("Steam Addresses: ", len(list_of_steam_addys))
    #return list_of_steam_addys

#if __name__ == "__main__":
#    main()  





