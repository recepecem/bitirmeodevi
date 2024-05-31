import socket
import random

rnum = random.randint(1000, 9999)
message = "rpi2: " + str(rnum)

# İstemci soketi oluştur
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

with open("/home/ahududu2/bitirme/bip", "r") as file:
	for line in file:
		srvraddr = line.strip()

# Sunucu adresi ve port numarası
server_address = (srvraddr, 12345)

# Sunucuya bağlan
client_socket.connect(server_address)

# Mesajı sunucuya gönder
client_socket.send(message.encode())

# Bağlantıyı kapat
client_socket.close()

