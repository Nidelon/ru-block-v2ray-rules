while IFS= read -r site; do
    if [[ -n "$site" ]]; then
        ip=$(host -t A "$site" | awk '/has address/ { print $NF }')
        if [[ -n "$ip" ]]; then
            echo "$ip" >> ip_blocked_by_site
        fi
    fi
done < block_list
