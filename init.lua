-- -*- coding: utf-8, tab-width: 2 -*-

local M = { name = minetest.get_current_modname() }
M.basedir = (minetest.get_modpath(M.name) or error('get_modpath failed'))

local function identity(...) return ... end
local jsonize = minetest.write_json
local function serialize(x) return (jsonize(x) or tostring(x)) end

local function vec3(v, ...) return v.x, v.y, v.z, ... end

local function fmtNodeObj(n)
  if not n then return n end
  n = table.copy(n)
  if n.param1 == 0 then n.param1 = nil end
  if n.param2 == 0 then n.param2 = nil end
  n.description = nil
  return n
end

local function fmtSimpleNodeEv(v, n) return vec3(v, fmtNodeObj(n)) end

local function fmtPointedThing(p)
  if not p then return p end
  p = table.copy(p)
  p.above = {vec3(p.above)}
  p.under = {vec3(p.under)}
  return p
end


local fmts = {
  dignode   = fmtSimpleNodeEv,
  punchnode = fmtSimpleNodeEv,
}

function fmts.placenode(pointed, placed)
  return fmtPointedThing(pointed), fmtNodeObj(placed)
end


local function logEv(ev, ...)
  local f = fmts[ev]
  local a = {...}
  if f then a = {f(...)} end
  local m = ''
  for i, v in ipairs(a) do
    i, v = pcall(serialize, v)
    if not i then v = 'error(' .. tostring(v) .. ')' end
    m = m .. ' ' .. v
  end
  minetest.log(M.name .. ': ' .. ev .. m)
end


local function makePrefixArgProxy(f, k)
  return function (...) return f(k, ...) end
end

local hooked = {}
for k, v in pairs(minetest) do
  k = k:match('^register_on_([%w_]+)$')
  if k then
    v(makePrefixArgProxy(logEv, k))
    table.insert(hooked, k)
  end
end
table.sort(hooked)

local srv = minetest.get_server_info()
local user = minetest.localplayer
user = (user and user.get_name())

logEv('Ready', {
  basedir= M.basedir,
  host = srv.address,
  port = srv.port,
  user = user,
  events = table.concat(hooked, ' '),
})
