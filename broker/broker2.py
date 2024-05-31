import socket
import json
import os

# JSON dosya yolu
json_file_path = '/var/www/html/counts.json'

# JSON dosyasını yükle veya oluştur
def load_json():
    if os.path.exists(json_file_path):
        with open(json_file_path, 'r') as f:
            return json.load(f)
    else:
	    return {"kali-imsi": -404, "kali-80211": -404, "rpi1": -404, "rpi2": -404}


def save_json(data):
    with open(json_file_path, 'w') as f:
        json.dump(data, f, indent=4)

# Gelen veriyi işle ve JSON dosyasını güncelle
def process_data(data):
    json_data = load_json()
    
    # Veriyi parse et
    key, value = data.split(': ')
    json_data[key.strip()] = int(value.strip())

    # JSON dosyasını güncelle
    save_json(json_data)

srvaddr = str(os.popen("ifconfig wlan0 | grep -Eo 'inet ([0-9]{1,3}.){3}[0-9]{1,3}' | grep -Eo '([0-9]{1,3}.){3}[0-9]{1,3}'").read()).strip()
def start_server(host=srvaddr, port=12345):
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((host, port))
    server_socket.listen(5)
    print(f"Sunucu {host}:{port} üzerinde dinleniyor...")

    while True:
        client_socket, addr = server_socket.accept()
        print(f"Bağlantı sağlandı: {addr}")

        data = client_socket.recv(1024).decode('utf-8')
        if data:
            print(f"Gelen veri: {data}")
            process_data(data)

        client_socket.close()

if __name__ == "__main__":
    start_server()
