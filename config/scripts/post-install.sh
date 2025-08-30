#!/bin/bash

# Varijable za praćenje izvršenih akcija
logout_done=0
thunar_done=0

# Putanja do power.sh u korisničkom direktorijumu
power_script="$HOME/openbox-setup/config/scripts/power.sh"

# Pitanje za Logout menu
read -p "Da li želite da kreirate Logout menu? (da/ne): " answer_logout
if [ "$answer_logout" = "da" ]; then
    # Provera da li power.sh fajl postoji
    if [ ! -f "$power_script" ]; then
        echo "Greška: Fajl $power_script ne postoji!"
        exit 1
    fi

    # Tačka 1: Kopiranje i podešavanje skripte sa sudo
    sudo cp "$power_script" /usr/local/bin/power.sh
    if [ $? -ne 0 ]; then
        echo "Greška prilikom kopiranja power.sh u /usr/local/bin/"
        exit 1
    fi

    sudo chmod +x /usr/local/bin/power.sh
    if [ $? -ne 0 ]; then
        echo "Greška prilikom dodeljivanja izvršnih ovlašćenja za power.sh"
        exit 1
    fi

    openbox --reconfigure
    if [ $? -ne 0 ]; then
        echo "Greška prilikom rekonfiguracije Openbox-a"
        exit 1
    fi

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
    # Provera da li akcija postoji pre zamene
    if grep -q "<name>Open Terminal Here</name>" "$uca_file"; then
        sed -i '/<name>Open Terminal Here<\/name>/,/<\/action>/ s|<command>.*</command>|<command>terminator --working-directory %f</command>|' "$uca_file"
    else
        echo "Upozorenje: Akcija 'Open Terminal Here' nije pronađena u $uca_file. Kreiram novu akciju."
        unique_id=$(date +%s)
        # Koristimo temp fajl za umetanje
        temp_action=$(mktemp)
        cat > "$temp_action" << EOF
<action>
<unique-id>$unique_id</unique-id>
<name>Open Terminal Here</name>
<command>terminator --working-directory %f</command>
<description>Open terminal here</description>
<icon>terminator</icon>
<patterns>*</patterns>
<directories/>
</action>
EOF
        sed -i -e "/<\/actions>/ {r $temp_action" -e "N}" "$uca_file"
        rm -f "$temp_action"
    fi
    
    # 2b: Dodavanje nove akcije "Open Root Terminal Here"
    unique_id=$(date +%s)
    # Koristimo temp fajl za umetanje
    temp_file=$(mktemp)
    cat > "$temp_file" << EOF
<action>
<unique-id>$unique_id</unique-id>
<name>Open Root Terminal Here</name>
<command>sh -c &quot;cd %f &amp;&amp; terminator -e &apos;sudo -s&apos;&quot;</command>
<description>Open root terminal here</description>
<icon>terminator</icon>
<patterns>*</patterns>
<directories/>
</action>
EOF
    
    # Ubacite sadržaj prije </actions>
    sed -i -e "/<\/actions>/ {r $temp_file" -e "N}" "$uca_file"
    
    # Obrišite temp fajl
    rm -f "$temp_file"
    
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
