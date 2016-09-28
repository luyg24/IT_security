##logstash_agent
input {
     file {
      type => "ids-alert"
      path => "/var/log/suricata/fast.log"
}
     file {
      type => "ids-http_access"
      path => "/var/log/suricata/http.log"
}
}


output {
    if [type] == "ids-alert" {
    redis{
    data_type => "list"
    key => "ids-alert"
        host => "127.0.0.1"
    db => "1"
    }
    }
    if [type] == "ids-http_access" {
    redis{
    data_type => "list"
        key => "ids-http_access"
        host => "127.0.0.1"
    db => "1"
    }
    }
}





##logstash_indexer

input {
      redis {
    host => "127.0.0.1"
    data_type => "list"
    key => "ids-http_access"
        type => "ids-http_access"
    }
    redis {
        host => "127.0.0.1"
        data_type => "list"
        key => "ids-alert"
        type => "ids-alert"
    }
}
filter {
    if [type] == "ids-alert" {
    grok{
    match => ['message','\]\s\[\d+\:\d+\:\d+\]\s%{GREEDYDATA:attack_summary}\s\[\*\*\]\s\[Classification: %{GREEDYDATA:attack_info}\s\[Priority:\s%{WORD:priority}\] \{%{WORD:protocol_type}\} %{IP:source_ip}:%{WORD:source_port} -> %{IP:dest_ip}:%{WORD:dest_port}']
    }
}
    if [type] == "ids-http_access" {
    grok{
    match => ['message','%{URIPATHPARAM:request} \[\*\*\] %{GREEDYDATA:user_agent} \[\*\*\] %{GREEDYDATA:referer} \[\*\*\] %{WORD:method} \[\*\*\] %{GREEDYDATA} \[\*\*\] %{GREEDYDATA:http_status} \[\*\*\] %{INT:length} bytes \[\*\*\] %{IP:source_ip}:%{WORD:source_port} -> %{IP:dest_ip}:%{WORD:dest_port}']
    }
}
}


output {
    if [type] == "ids-alert" {
    elasticsearch{
        hosts => ["localhost:9200"]
    index => "ids-alert-%{+YYYY.MM.dd}"
    }
    }
    if [type] == "ids-http_access" {
    elasticsearch{
    hosts => ["localhost:9200"]
    index => "ids-http_access-%{+YYYY.MM.dd}"
    }
    }
    file {
    path => "/var/log/logela.log"
    }
}
