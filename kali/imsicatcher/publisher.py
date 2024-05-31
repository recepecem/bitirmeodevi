import socket
import os
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

file_path = '/home/analyst/bitirme/bip'

with open(file_path, 'r') as file:
    s = file.read().strip()

 
server_address = (s, 12345)

client_socket.connect(server_address)

file_path = '/home/analyst/bitirme/imsicatcher/sum'

with open(file_path, 'r') as file:
    message = file.read()

client_socket.send(message.encode())

data = client_socket.recv(1024)

client_socket.close()
