function getstats
    echo "arg: $argv[1]"

    switch $argv
        case health
            curl 'localhost:9200/_cat/health?v'
        case indx
            curl 'localhost:9200/_cat/indices?v'
        case h
            echo "options: health, indx, h, nodes, shards"
        case nodes
            curl 'localhost:9200/_cat/nodes?v'
        case shards
            curl 'localhost:9200/_cat/shards/'$argv[2]'?v'

    end

end
