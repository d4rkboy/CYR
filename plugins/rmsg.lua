local function history(extra, suc, result)
  for i=1, #result do
    delete_msg(result[i].id, ok_cb, false)
  end
  if tonumber(extra.con) == #result then
    send_msg(extra.chatid, '"'..#result..'" message Has been Cleaned', ok_cb, false)
  else
    send_msg(extra.chatid, 'Last Message Has been cleaned', ok_cb, false)
  end
end
local function run(msg, matches)
  if matches[1] == 'rmsg' and is_owner(msg) then
    if msg.to.type == 'channel' then
      if tonumber(matches[2]) > 100 or tonumber(matches[2]) < 10 then
        return "Wrong number,range is [10-100]"
      end
      get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
    else
      return "Only work in SuperGroup"
    end
  else
    return "You are not owner"
  end
end

return {
    patterns = {
        '^[!/#](rmsg) (%d*)$'
    },
    run = run
}