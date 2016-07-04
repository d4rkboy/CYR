local function run(msg, matches, callback, extra)

local data = load_data(_config.moderation.data)

local group_welcome = data[tostring(msg.to.id)]['group_welcome']

-------------------------- Data Will be save on Moderetion.json

if matches[1] == 'delwelcome' and is_owner(msg) then 
    
   data[tostring(msg.to.id)]['group_welcome'] = nil --delete welcome
        save_data(_config.moderation.data, data)
        
        return 'Group welcome Deleted!'
end
if not is_owner(msg) then 
    return 'For Owners Only!'
end
--------------------Loading Group Rules
local rules = data[tostring(msg.to.id)]['rules']
    
if matches[1] == 'setwelcome' and matches[2] == 'rules' and matches[3] and is_owner(msg) then
    if data[tostring(msg.to.id)]['rules'] == nil then --when no rules found....
        return 'No Rules Found!\n\nSet Rule first by /set rules [rules]\nOr\nset normal welcome by /setwlc [wlc msg]'
end
data[tostring(msg.to.id)]['group_welcome'] = matches[3]..'\n\nGroup Rules :\n'..rules
        save_data(_config.moderation.data, data)
        
        return 'Group welcome Set To :\n'..matches[3]
end
if not is_owner(msg) then 
    return 'For Owners Only!'
end

if matches[1] == 'setwelcome' and is_owner(msg) then
    
data[tostring(msg.to.id)]['group_welcome'] = matches[2]
        save_data(_config.moderation.data, data)
        
        return 'Group welcome Seted To : \n'..matches[2]
end
if not is_owner(msg) then 
    return 'For Owners Only!'
end

if matches[1] == 'chat_add_user' or 'chat_add_user_link' then --For Normal Group
    if not msg.service then 
        return nil 
    else
        return group_welcome
end
end
end
return {
  patterns = {
      "^[#!/](setwelcome) (rules) +(.*)$",
  "^[#!/](setwelcome) +(.*)$",
  "^[#!/](delwelcome)$",
  "^!!tgservice (chat_add_user)$",
  "^!!tgservice (chat_add_user_link)$",
  },
  run = run,
  pre_process = pre_process
}