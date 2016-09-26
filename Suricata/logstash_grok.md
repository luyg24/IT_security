- 匹配alert日志:
match => ['message','\]\s\[\d+\:\d+\:\d+\]\s%{GREEDYDATA:attack_summary}\s\[\*\*\]\s\[Classification: %{GREEDYDATA:attack_info}\s\[Priority:\s%{WORD:priority}\] \{%{WORD:protocol_type}\} %{IP:source_ip}:%{WORD:source_port} -> %{IP:dest_ip}:%{WORD:dest_port}']
match => ['message','%{IP:ip}\s*-\s*-\s*\[%{HTTPDATE:httpdate}\]\s*\"\w+\s*%{URIPATH:path}\s*%{NOTSPACE:http}\"\s*%{POSINT:state}\s*%{INT:bytes_sent}\s*\s*\"%{URI:url}\"\s*\"\s*%{GREEDYDATA:http_user_agent}\"']
