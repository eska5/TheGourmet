import paramiko


ssh = paramiko.SSHClient()
keyfilename = "D:\Politechnika\The Gourmet\GourmentVM_key.pem"
host = "20.229.147.8"
user = "azureuser"
k = paramiko.RSAKey.from_private_key_file(keyfilename)

ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname=host, username=user, pkey=k)
branch = input("Branch name(leave empty if main):")
stdin, stdout, stderr = ssh.exec_command(f"sudo ./pipe.sh {branch}")
while True:
    line = stdout.readline()
    if not line:
        break
    print(line, end="")

ssh.close()
