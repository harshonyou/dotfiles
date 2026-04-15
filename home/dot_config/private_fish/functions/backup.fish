# Create a .bak copy of a file
# Usage: backup file.txt → creates file.txt.bak
function backup --argument filename --description "Create a .bak copy of a file"
    cp $filename $filename.bak
end
