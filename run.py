import os, sys, time

os.system("clear")

def jalan(z):

 for x in z:
        sys.stdout.write(x)
        sys.stdout.flush()
        time.sleep(00000.1)
jalan("welcome to my tools")
time.sleep(2)
os.system("clear")
p = """
   __  ______  ____
  /  |/  / _ \/ __/
 / /|_/ / // /__ \\n
/_/  /_/____/____/ Tools f0r sXc m3mber
"""
print p
print "1. md5"
print "2. hash"
print "3. exit"
a = raw_input("number > ")
if a =="1":
   os.system('php md5.php')
if a =="2":
   os.system('bash hash.sh')
if a =="3":
   os.system("apt update && apt upgrade")
   os.system("apt install php && apt install bash")
   os.system("python2 run.py")
