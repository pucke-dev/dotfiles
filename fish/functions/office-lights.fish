function office-lights
    set url http://huebridge.fritz.box/api/DY43ehIBlu2ndItopGHuInb5rJX3ObFMAg7a35Ht/lights/3/state

    if count $argv > /dev/null
        set data "{\"on\":false, \"bri\": 100}"

    else
        set data "{\"on\":true, \"bri\": 100}"
    end

    curl -X PUT -d $data $url
end
