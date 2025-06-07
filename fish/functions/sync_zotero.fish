function sync_zotero
    set -l options 'f/force'
    argparse $options -- $argv
    
    # Check if a destination PC argument is provided
    if test (count $argv) -ne 1
        echo "Usage: sync-zotero [-f|--force] DESTINATION_PC"
        echo "Example: sync-zotero username@remote-pc"
        echo "Options:"
        echo "  -f, --force    Force sync (ignore file timestamps and always copy)"
        return 1
    end

    # Store the destination PC argument
    set dest_pc $argv[1]

    # Define source and destination paths
    set source_path ~/Zotero/
    set dest_path Zotero/

    if not set -q _flag_force
        # Normal sync - will check timestamps and size
        echo "Performing normal sync..."
        rsync -avz --progress $source_path $dest_pc:$dest_path
    else
        # Force sync - ignore timestamps and copy everything
        echo "Performing forced sync (ignoring timestamps)..."
        rsync -avzI --progress $source_path $dest_pc:$dest_path
    end

    # Check if rsync was successful
    if test $status -eq 0
        echo "Zotero sync completed successfully"
    else
        echo "Error: Zotero sync failed"
        return 1
    end
end
