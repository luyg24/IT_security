#ossec
##一、config
###1.install


###2.manage agent
first : add host to ossec-server
run ./manage_agents to add host , and export the key  
second: 
run ./manage_agents to import the key 
last:
restart the server and agent

view active agent in ossec server : ./agent_control -l

###3. control the angent use ossec-server
