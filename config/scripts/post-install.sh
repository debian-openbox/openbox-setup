#!/bin/bash

# Varijable za praćenje izvršenih akcija
logout_done=0
thunar_done=0

# Pitanje za Logout menu
read -p "Da li želite da kreirate Logout menu? (da/ne): " answer_logout
if [ "$answer_logout" = "da" ]; then
    # Tačka 1: Kopiranje i podešavanje skripte
    cp ~/openbox-setup/config/scripts/power.sh /usr/local/bin/power.sh
    chmod +x /usr/local/bin/power.sh
    openbox --reconfigure
    logout_done=1
fi

# Pitanje za Thunar kontekstni meni
read -p "Da li želite da definišete otvaranje Terminala iz kontekstnog menija u Thunar-u? (da/ne): " answer_thunar
if [ "$answer_thunar" = "da" ]; then
    # Tačka 2: Konfiguracija Thunar custom actions
    uca_file="$HOME/.config/Thunar/uca.xml"
    
    # Osiguraj da fajl postoji
    if [ ! -f "$uca_file" ]; then
        mkdir -p "$HOME/.config/Thunar"
        echo "<actions></actions>" > "$uca_file"
    fi
    
    # 2a: Izmena postojeće akcije "Open Terminal Here"
    # Koristimo sed za zamenu command linije (pretpostavljamo da postoji tačno jedna takva akcija)
    sed -i '/<name>Open Terminal Here<\/name>/,/<\/action>/ s|<command>.*</command>|<command>terminator --working-directory %f</command>|' "$uca_file"
    
    # 2b: Dodavanje nove akcije "Open Root Terminal Here"
    unique_id=$(date +%s)
    new_action="<action>
<unique-id>$unique_id</unique-id>
<name>Open Root Terminal Here</name>
<command>sh -c 'terminator -e \"bash -c \\\"cd %f &amp;&amp; echo 'Direktorijum: %f' &amp;&amp; sudo -s\\\"\"'</command>
<description>Open root terminal here</description>
<icon>terminator</icon>
<patterns>*</patterns>
<directories/>
</action>"
    
    # Dodaj novu akciju pre zatvarajućeg </actions>
    sed -i "/<\/actions>/i $new_action" "$uca_file"
    
    # Ponovo učitaj Thunar ako je potrebno (ali Thunar se obično ažurira automatski)
    thunar_done=1
fi

# Ispis završne poruke na osnovu odgovora
if [ $logout_done -eq 1 ] && [ $thunar_done -eq 1 ]; then
    echo "Aktivan Logout menu, Kreirano kontekstno otvaranje menija u Thunar-u"
elif [ $logout_done -eq 1 ]; then
    echo "Aktivan Logout menu"
elif [ $thunar_done -eq 1 ]; then
    echo "Kreirano kontekstno otvaranje menija u Thunar-u"
else
    echo "korisnik ne želi izmene"
fi
