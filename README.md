# zadanie 2

\# Zadanie 2 czerwiec 2023, inf.02
\## Konfiguracja mikrotika
1\. Reset routera. System -\> Reset Configuration
![image1](media/image1.png)
1\. Mostek i Port (Bridge)
Bridge -\> zakładka Bridge -\> + -\> Name: bridge1 -\> OK.
![image2](media/image2.png)
Zakładka Ports -\> + -\> Interface: ether2, Bridge: bridge1 -\> OK.
![image3](media/image3.png)
2\. Interfejsy VLAN (Bramy dla sieci)
To tutaj router zaczyna rozumieć sieci:
Interfaces -\> zakładka VLAN -\> +:
Name: vlan1, VLAN ID: 1, Interface: bridge1
![image4](media/image4.png)
Name: vlan2, VLAN ID: 2, Interface: bridge1
Name: vlan3, VLAN ID: 3, Interface: bridge1
Widok całości:
![image5](media/image5.png)
3\. Adresy IP (IP -\> Addresses)
Nadaj routerowi ip/maskę w każdej sieci:
10.27.10.1/24 na vlan1
![image6](media/image6.png)
10.27.20.1/24 na vlan2
10.27.30.1/24 na vlan3
Całość:
![image7](media/image7.png)
4\. DHCP (Żeby komputer dostał IP)
IP -\> Pool -\> + -\> Name: pool2, Range: 10.27.20.10-10.27.20.15.
![image8](media/image8.png)
IP -\> DHCP Server -\> DHCP -\> + -\> Name: dhcp2, Interface: vlan2,
Address Pool: pool2.
![image9](media/image9.png)
![image10](media/image10.png)
Networks -\> + -\> Address: 10.27.20.0/24, Gateway: 10.27.20.1, DNS:
10.27.30.3.
![image11](media/image11.png)
![image12](media/image12.png)
5\. Tagowanie (Bridge -\> VLANs)
Bez tego pakiety nie wyjdą poza router:
Kliknij + -\> VLAN IDs: 1, Tagged: bridge1, ether2 (użyj strzałki w dół,
by dodać drugi).
![image13](media/image13.png)
Kliknij + -\> VLAN IDs: 2, Tagged: bridge1, ether2.
Kliknij + -\> VLAN IDs: 3, Tagged: bridge1, ether2.
Całość:
![image14](media/image14.png)
6\. Włączamy filtrowanie:
Bridge -\> zakładka Bridge -\> kliknij dwa razy w bridge1.
Zakładka VLAN -\> zaznacz VLAN Filtering -\> Apply.
![image15](media/image15.png)
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--
Komunikacja Serwer - Stacja:
Spróbuj pingować bezpośrednio ze stacji (10.27.20.x) na adres serwera
(10.27.30.3). Jeśli to działa, oznacza to, że routing między VLANami
jest OK.
![image16](media/image16.png)
Ping z serwera:
![image17](media/image17.png)
Tablica ARP:
W WinBox wejdź w IP -\> ARP. Powinieneś tam widzieć:
![image18](media/image18.png)
Adres stacji przypisany do interfejsu vlan2.
Adres serwera przypisany do interfejsu vlan3.
Adres switcha przypisany do interfejsu vlan1.
Ustawienia na stacji:
![image19](media/image19.png)
Eksport ustawień:
![image20](media/image20.png)
![image21](media/image21.png)
\-\--
Polecenia:

```bash
/interface bridge
add name=bridge1 vlan-filtering=yes
/interface wireless disable \[find\]
set \[ find default-name=wlan1 \] ssid=MikroTik
set \[ find default-name=wlan2 \] ssid=MikroTik
/interface vlan
add interface=bridge1 name=vlan1 vlan-id=1
add interface=bridge1 name=vlan2 vlan-id=2
add interface=bridge1 name=vlan3 vlan-id=3
/interface wireless security-profiles
set \[ find default=yes \] supplicant-identity=MikroTik
/ip pool
add name=pool2 ranges=10.27.20.10-10.27.20.15
/ip dhcp-server
add address-pool=pool2 interface=vlan2 name=dhcp2
/interface bridge port
add bridge=bridge1 interface=ether2
/interface bridge vlan
add bridge=bridge1 tagged=bridge1,ether2 vlan-ids=1
add bridge=bridge1 tagged=bridge1,ether2 vlan-ids=3
add bridge=bridge1 tagged=bridge1,ether2 vlan-ids=2
/ip address
add address=10.27.10.1/24 interface=vlan1 network=10.27.10.0
add address=10.27.20.1/24 interface=vlan2 network=10.27.20.0
add address=10.27.30.1/24 interface=vlan3 network=10.27.30.0
/ip dhcp-server network
add address=10.27.20.0/24 dns-server=10.27.30.3 gateway=10.27.20.1
netmask=24
```

Sprawdzenie:
![image22](media/image22.png)
\`\`\`bash
/ip address print
\`\`\`
![image23](media/image23.png)
\`\`\`bash
ip route print
\`\`\`
![image24](media/image24.png)
\`\`\`bash
/interface bridge port print
\`\`\`
![image25](media/image25.png)
\`\`\`bash
/interface bridge vlan print
\`\`\`
![image26](media/image26.png)
\`\`\`bash
/ip dhcp-server lease print
\`\`\`
![image27](media/image27.png)
\`\`\`bash
/ip dhcp-server /ping print
\`\`\`
![image28](media/image28.png)
\`\`\`bash
/ping 10.27.10.2 count=3
\`\`\`
\## Konfiguracja switcha
Ustawienie PVID:
![image29](media/image29.png)
Widok VLAN:
![image30](media/image30.png)
Widok VLAN 3:
![image31](media/image31.png)
Widok VLAN2:
![image32](media/image32.png)
KONIEC.
