document.addEventListener("DOMContentLoaded", function() {
    const countElements = {
        "kali-imsi": document.getElementById("kali-imsi"),
        "kali-80211": document.getElementById("kali-80211"),
        "rpi1": document.getElementById("rpi1"),
        "rpi2": document.getElementById("rpi2")
    };

    function fetchData() {
        fetch('counts.json')
            .then(response => response.json())
            .then(data => {
                countElements["kali-imsi"].textContent = data["kali-imsi"];
                countElements["kali-80211"].textContent = data["kali-80211"];
                countElements["rpi1"].textContent = data["rpi1"];
                countElements["rpi2"].textContent = data["rpi2"];
            })
            .catch(error => {
                console.error('Hata:', error);
                for (let key in countElements) {
                    countElements[key].textContent = 'Veri alınamadı';
                }
            });
    }

    // İlk veriyi çek
    fetchData();

    // Verileri her 1 saniyede bir güncelle
    setInterval(fetchData, 1000);
});
