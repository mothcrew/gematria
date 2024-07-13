#!/bin/bash

# Define the ALW cipher mapping
declare -A alw_cipher
alw_cipher=(
    [A]=1 [L]=2 [W]=3 [H]=4 [S]=5 [D]=6 [O]=7 [Z]=8 [K]=9 [V]=10
    [G]=11 [R]=12 [C]=13 [N]=14 [Y]=15 [J]=16 [U]=17 [F]=18 [Q]=19
    [B]=20 [M]=21 [X]=22 [I]=23 [T]=24 [E]=25 [P]=26
    [a]=1 [l]=2 [w]=3 [h]=4 [s]=5 [d]=6 [o]=7 [z]=8 [k]=9 [v]=10
    [g]=11 [r]=12 [c]=13 [n]=14 [y]=15 [j]=16 [u]=17 [f]=18 [q]=19
    [b]=20 [m]=21 [x]=22 [i]=23 [t]=24 [e]=25 [p]=26
)

# Function to calculate the sum of the digits of a number
calculate_nummogram() {
    local number="$1"
    local sum=0

    while [ $number -gt 0 ]; do
        sum=$((sum + number % 10))
        number=$((number / 10))
    done

    # If the sum is greater than 9, reduce it to a single digit
    while [ $sum -gt 9 ]; do
        number=$sum
        sum=0
        while [ $number -gt 0 ]; do
            sum=$((sum + number % 10))
            number=$((number / 10))
        done
    done

    echo "$sum"
}

# Function to categorize the nummogram value
categorize_nummogram() {
    local nummogram="$1"
    case $nummogram in
        3|6) echo "Outside Time - The Warp" ;;
        1|2|4|5|7|8) echo "Chromic Time - The Time Circuit" ;;
        0|9) echo "Outside Time - The Plex" ;;
        *) echo "Unknown Category" ;;
    esac
}

# Function to convert input to ALW cipher and calculate sums
convert_to_alw() {
    local input="$1"
    local output=""
    local sum=0

    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"
        if [[ ${alw_cipher[$char]} ]]; then
            output+="${alw_cipher[$char]} "
            sum=$((sum + alw_cipher[$char]))
        else
            output+="$char "
        fi
    done

    local nummogram=$(calculate_nummogram $sum)
    local category=$(categorize_nummogram $nummogram)

    echo "ALW Cipher Output: $output"
    echo "Total Sum: $sum"
    echo "Nummogram Value: $nummogram"
    echo "Category: $category"
}

# Read input from the user
echo "Enter a word or sentence:"
read input

# Convert the input to ALW cipher and display the output
convert_to_alw "$input"

